# serverless

Template of a simple serverless ts api service with dynamodb 

## Installation

```bash
npx degit https://github.com/TheSmartMonkey/create-serverless-simple-ts-service game-service
```

Changes to be done

1. package.json config name

1. serverless.ts service name

1. Change the region in `serverless.ts` provider/region (current region: Paris)

## Getting started

1. Install serverless framework : [serverless framework Get Started](https://www.serverless.com/framework/docs/getting-started)

1. Setup your aws credentials : [aws config](https://www.serverless.com/framework/docs/providers/aws/guide/credentials)

Create a cloud formation stack on aws : `npm run deploy`

Remove a cloud formation stack on aws : `npm run undeploy`

## Manual test locally

In order to test the lambda functions locally, after you have deployed the stack a first times
for dependencies like dynamodb, run the following command:

- `npx sls invoke local -f hello --path src/functions/hello/mock.json`

Check the [sls invoke local command documentation](https://www.serverless.com/framework/docs/providers/aws/cli-reference/invoke-local/) for more information.

## To simulate remote locally

In serverless.ts put environment/OFFLINE to 'true'

Then run `npm run offline`

Your `sls invoke local` commands now target your offline stack
