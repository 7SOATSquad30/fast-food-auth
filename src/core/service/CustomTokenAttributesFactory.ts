import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";
import CustomTokenAttributes from "../usecase/CustomTokenAttributes";

export default interface CustomTokenAttributesFactory {

    getService(event: PreTokenGenerationV2TriggerEvent): CustomTokenAttributes
}