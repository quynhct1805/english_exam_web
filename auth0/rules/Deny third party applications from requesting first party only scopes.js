function restrictFirstPartyOnlyScopes(user, context, callback) {
  const first_party_only_scopes = ['all:all', 'private'];
  const first_party_app_ids = configuration.first_party_app_ids.split(',');
  const req = context.request;
  const requested_scopes = ((req.query && req.query.scope) || (req.body && req.body.scope) || '').split(' ').map(scope => scope.trim());
  
  if(requested_scopes.length && 
     first_party_only_scopes.some(scope => requested_scopes.includes(scope)) && 
     !first_party_app_ids.includes(context.clientID)) {
   return callback(new UnauthorizedError('Your application is not allowed to request first-party only scopes')); 
  }

  callback(null, user, context);
}