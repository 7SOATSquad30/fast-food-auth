import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";
import CustomTokenAttributesFactory from "../../core/service/CustomTokenAttributesFactory";
import CustomTokenAttributes from "../../core/usecase/CustomTokenAttributes";
import OauthCustomTokenAttributes from "../../core/usecase/OauthCustomTokenAttributes";
import Logger from "../../infra/logger/Logger";

export default class CustomTokenAttributesFactoryImpl implements CustomTokenAttributesFactory {

    private readonly OPENID
    private readonly OAUTH

    constructor(private readonly logger: Logger) {
        this.OPENID = process.env.OPENID?.split(',') || []
        this.OAUTH = process.env.OAUTH?.split(',') || []
    }
    
    getService(event: PreTokenGenerationV2TriggerEvent): CustomTokenAttributes {
        // if(this.OPENID.includes(event.userPoolId)) {
        //     this.logger.info(`Protocol OPENID chosen...`, { userPoolId: event.userPoolId })
        //     return new OpenidCustomTokenAttributes(this.logger);
        // }
        
        if(this.OAUTH.includes(event.userPoolId)) {
            this.logger.info(`Protocol OAUTH chosen...`, { userPoolId: event.userPoolId })
            return new OauthCustomTokenAttributes(this.logger);
        }

        throw new Error("Protocol not found");
    }

}