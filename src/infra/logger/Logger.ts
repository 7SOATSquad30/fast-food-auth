import { Logger as AwsLogger, LogLevel } from '@aws-lambda-powertools/logger'

export default class Logger extends AwsLogger {
    
    constructor() {
        const validLogLevels = Object.keys(LogLevel)
        const envLogLevel = process.env.LOG_LEVEL as string
        const logLevel: any = validLogLevels.includes(envLogLevel) ? envLogLevel : "INFO"
        super({ serviceName: 'fast-food-auth-service', logLevel })
    }
}