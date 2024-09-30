import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";
import CustomTokenAttributes from "./CustomTokenAttributes";
import Logger from "../../infra/logger/Logger";

export default class OauthCustomTokenAttributes implements CustomTokenAttributes {
    private readonly scopesSupress = ['aws.cognito.signin.user.admin']
    
    constructor(private readonly logger: Logger) {

    }

    execute(event: PreTokenGenerationV2TriggerEvent): PreTokenGenerationV2TriggerEvent {
        this.logger.debug('Customize attributes...', { event })
        const scopes = event.request.userAttributes['custom:scope'].split(" ")
        const customerId = event.request.userAttributes['custom:customerId']

        event.response.claimsAndScopeOverrideDetails = {
            accessTokenGeneration: {
                claimsToAddOrOverride: {
                    'customer_id': customerId
                },
                scopesToAdd: scopes,
                scopesToSuppress: this.scopesSupress
            }
        }
        this.logger.debug('Custom attributes...', { event })
        return event
    }
    
}