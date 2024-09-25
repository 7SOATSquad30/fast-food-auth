import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";
import CustomTokenAttributesFactoryImpl from "../application/service/CustomTokenAttributesFactoryImpl";
import CustomTokenAttributesImpl from "../core/usecase/CustomTokenAttributesImpl";
import CustomTokenAttributes from "../core/usecase/CustomTokenAttributes";
import Logger from "../infra/logger/Logger";

export default class CustomTokenController {
    private readonly customTokenAttributesUseCase: CustomTokenAttributes
    private readonly logger: Logger

    constructor(logger: Logger) {
        this.logger = logger
        const factory = new CustomTokenAttributesFactoryImpl(logger)
        this.customTokenAttributesUseCase = new CustomTokenAttributesImpl(factory, logger)
    }

    customTokenAttributes(event: PreTokenGenerationV2TriggerEvent) {
        this.logger.debug(`Execution 'customTokenAttributes' method...`, { event })
        return this.customTokenAttributesUseCase.execute(event)
    }
}