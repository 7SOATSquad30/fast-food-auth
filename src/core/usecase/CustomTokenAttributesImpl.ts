import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";
import CustomTokenAttributes from "./CustomTokenAttributes";
import CustomTokenAttributesFactory from "../service/CustomTokenAttributesFactory";
import Logger from "../../infra/logger/Logger";

export default class CustomTokenAttributesImpl implements CustomTokenAttributes {
    
    constructor(private readonly factory: CustomTokenAttributesFactory, private readonly logger: Logger) {
        
    }

    execute(event: PreTokenGenerationV2TriggerEvent): PreTokenGenerationV2TriggerEvent {
        this.logger.debug('Get service by event...', { event })
        const service = this.factory.getService(event)
        this.logger.debug('Execute service...', { event })
        return service.execute(event)
    }

}