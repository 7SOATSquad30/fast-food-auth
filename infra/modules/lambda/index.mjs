export const handler = function(event, context) {
  // Retrieve user attribute from event request
  const cpf = event.request.userAttributes['custom:cpf'];

  if (cpf) {
    // Add scope to event response
    event.response = {
      "claimsAndScopeOverrideDetails": {
        "idTokenGeneration": {},
        "accessTokenGeneration": {
          "claimsToAddOrOverride": {
            "cpf": userAttributes['custom:cpf']
          },
          "scopesToAdd": ["custom:cpf"]
        }
      }
    };
  }
  
  // Return to Amazon Cognito
  context.done(null, event);
};