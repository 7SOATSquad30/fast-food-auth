import { PreTokenGenerationV2TriggerEvent } from "aws-lambda";

export default interface CustomTokenAttributes {
    execute: (event: PreTokenGenerationV2TriggerEvent) => PreTokenGenerationV2TriggerEvent
}