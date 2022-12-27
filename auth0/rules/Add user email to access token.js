function addEmailToAccessToken(user, context, callback) {
  var namespace = configuration.namespace;
  context.accessToken[namespace + 'email'] = user.email;
  callback(null, user, context);
}
