import { PreTokenGenerationV2TriggerEvent } from "aws-lambda"
import CustomTokenAttributesFactoryImpl from "../../application/service/CustomTokenAttributesFactoryImpl"
import CustomTokenAttributesImpl from "../../core/usecase/CustomTokenAttributesImpl"
import Logger from "../../infra/logger/Logger"

const openidEvent = {
    "version": "2",
    "triggerSource": "TokenGeneration_Authentication",
    "region": "us-east-1",
    "userPoolId": "openiduserpool",
    "userName": "n-ae510725-22ba-49f8-92a5-5385a4a5f367",
    "callerContext": {
        "awsSdkVersion": "aws-sdk-java-2.20.43",
        "clientId": "28epfcqniqc1574hqtmu3cpg6"
    },
    "request": {
        "userAttributes": {
            "sub": "bad5fe1c-e285-4da2-ab11-ec50bd647a9f",
            "custom:customerId": "001",
            "cognito:user_status": "CONFIRMED",
            "custom:scope": "customer:read customer:write operation:read",
            "name": "App01",
            "custom:mfa_enabled": "true"
        },
        "groupConfiguration": {
            "groupsToOverride": [
                "developer"
            ],
            "iamRolesToOverride": [],
            "preferredRole": null
        },
        "scopes": [
            "aws.cognito.signin.user.admin"
        ]
    },
    "response": {
        "claimsAndScopeOverrideDetails": null
    }
} as unknown as PreTokenGenerationV2TriggerEvent 


const oauthEvent = {
    "version": "2",
    "triggerSource": "TokenGeneration_Authentication",
    "region": "us-east-1",
    "userPoolId": "oauthuserpool",
    "userName": "n-ae510725-22ba-49f8-92a5-5385a4a5f367",
    "callerContext": {
      "awsSdkVersion": "aws-sdk-java-2.20.43",
      "clientId": "28epfcqniqc1574hqtmu3cpg6"
    },
    "request": {
      "userAttributes": {
        "sub": "bad5fe1c-e285-4da2-ab11-ec50bd647a9f",
        "cognito:user_status": "CONFIRMED",
        "custom:scope": "customer:read customer:write",
        "name": "App01"
      },
      "groupConfiguration": {
        "groupsToOverride": [],
        "iamRolesToOverride": [],
        "preferredRole": null
      },
      "scopes": [ "aws.cognito.signin.user.admin" ]
    },
    "response": { "claimsAndScopeOverrideDetails": null }
} as unknown as PreTokenGenerationV2TriggerEvent 

describe('CustomTokenAttributesImpl', () => {

    beforeEach(() => {
        process.env.OPENID = 'openiduserpool'
        process.env.OAUTH = 'oauthuserpool'
    }) 

    it('should be generate custom attributes from openid event', () => {
        const logger = new Logger()
        const factory = new CustomTokenAttributesFactoryImpl(logger)
        const usecase = new CustomTokenAttributesImpl(factory, logger)      
        const response = usecase.execute(openidEvent)
        expect(response).not.toBeNull()
    })

    it('should be generate custom attributes from oauth event', () => {
        const logger = new Logger()
        const factory = new CustomTokenAttributesFactoryImpl(logger)
        const usecase = new CustomTokenAttributesImpl(factory, logger)      
        const response = usecase.execute(oauthEvent)
        expect(response).not.toBeNull()
    })

    it('shoud be not generate because protocol not found', () => {
        const event = { ...oauthEvent, userPoolId: 'faileduserpool' }
        const logger = new Logger()
        const factory = new CustomTokenAttributesFactoryImpl(logger)
        const usecase = new CustomTokenAttributesImpl(factory, logger)
        expect(() => usecase.execute(event)).toThrow()
    })

    it('shoud be not generate because not set environments variables', () => {
        delete process.env.OPENID
        delete process.env.OAUTH
        const event = { ...oauthEvent, userPoolId: 'faileduserpool' }
        const logger = new Logger()
        const factory = new CustomTokenAttributesFactoryImpl(logger)
        const usecase = new CustomTokenAttributesImpl(factory, logger)
        expect(() => usecase.execute(event)).toThrow()
    })
})