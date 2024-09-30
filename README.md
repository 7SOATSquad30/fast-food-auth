# Auth Services

![Node.js Version](https://img.shields.io/badge/Node.js-20.x-brightgreen)
![NPM Version](https://img.shields.io/badge/NPM-10.x-orange)
![Serverless Version](https://img.shields.io/badge/Serverless-3.x-blue)
![Typescript Version](https://img.shields.io/badge/Typescript-5.x-blue)

Monorepo com serviços serverless (Lambda) com contexto de Autenticação e Autorização.

## Services
- **custom-token-generation:** Lambda que intercepta a geração de token do serviço AWS Cognito, para adicionar e personalizar claims, no contexto Oauth.

### Custom Token Generation

Deve ser aplicado no Lambda Triggers, com o type Authentication, function Pre token generation trigger.

Trigger event version: Basic feature + access token customization.