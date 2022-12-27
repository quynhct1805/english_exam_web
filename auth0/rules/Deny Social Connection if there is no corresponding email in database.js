function validateSocialConnection(user, context, callback) {
  // Skip this rule if this is not a social connection
  if (!["google-oauth2"].includes(context.connectionStrategy))
    return callback(null, user, context);
  
  // Set-up the management client
  var ManagementClient = require("auth0@2.9.1").ManagementClient;
  var management = new ManagementClient({
    token: auth0.accessToken,
    domain: auth0.domain,
  });

  // Get a list of all users with the same email,
  // then check if there is an user that exists in any auth0's database
  // connections (i.e not social connection)
  // If there is no user -> deny login
  management.getUsersByEmail(user.email, function (err, users) {
    var userExisted = users.some(function (user) {
      return !user.blocked && user.identities.some(function (identity) {
        return identity.isSocial === false;
      });
    });
    if (!userExisted) {
      return callback(
        new UnauthorizedError("There is no user with that email.")
      );
    }
    callback(null, user, context);
  });
}