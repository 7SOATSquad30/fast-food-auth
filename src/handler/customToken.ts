import { PreTokenGenerationV2TriggerEvent } from 'aws-lambda'
import CustomTokenController from '../controller/CustomTokenController';
import Logger from '../infra/logger/Logger';

export const handler = async (event: PreTokenGenerationV2TriggerEvent) => {
    const logger = new Logger()
    const controller = new CustomTokenController(logger)
    return controller.customTokenAttributes(event)
}