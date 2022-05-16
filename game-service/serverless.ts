import type { AWS } from '@serverless/typescript';

import hello from '@functions/hello';
import game from '@functions/game';

import dynamodbTables from 'resources/dynamodb-tables';


const serverlessConfiguration: AWS = {
    service: 'game-service',
    frameworkVersion: '3',
    custom: {
        stageType: '${opt:stage, env:AWS_STAGE, "dev"}',
        envType: '${env:ENV_TYPE, "dev"}',
        prefix: '${self:custom.stageType}-${self:service}',
        connections_table: '${self:service}-connections-table-${self:custom.stageType}',
        table_throughputs: {
            prod: 5,
            default: 1,
        },
        hostedZoneName: '${env:HOSTED_ZONE, "${self:custom.envType}.typescript-msl.ml"}',
        apiDomainName: 'api.${self:custom.hostedZoneName}',
        apiBasePath: 'api-${self:custom.stageType}-${self:service}',
        esbuild: {
            bundle: true,
            minify: false,
            sourcemap: true,
            exclude: ['aws-sdk'],
            target: 'node14',
            define: { 'require.resolve': undefined },
            platform: 'node',
            concurrency: 10,
            loader: { '.html': 'text' },
        },
        table_throughput: '${self:custom.table_throughputs.${self:custom.stageType}, self:custom.table_throughputs.default}',
        dynamodb: {
            stages: '${self:custom.stageType}',
            start: {
                migrate: true,
            },
        },
    },
    plugins: [
        'serverless-esbuild',
        'serverless-deployment-bucket',
        'serverless-dynamodb-local',
        'serverless-offline',

    ],
    provider: {
        name: 'aws',
        runtime: 'nodejs14.x',
        stage: '${self:custom.stageType}',
        region: "eu-west-3",
        deploymentBucket: {
            name: '${self:service}-${self:custom.envType}-${self:provider.region}-deployment-bucket',
        },
        apiGateway: {
            minimumCompressionSize: 1024,
            shouldStartNameWithService: true,
        },
        environment: {
            CONNECTIONS_TABLE: '${self:custom.connections_table}',
            OFFLINE: 'false',
        },
        iam: {
            role: {
                statements: [
                    {
                        Effect: 'Allow',
                        Action: [
                            'dynamodb:DescribeTable',
                            'dynamodb:Query',
                            'dynamodb:Scan',
                            'dynamodb:GetItem',
                            'dynamodb:PutItem',
                            'dynamodb:UpdateItem',
                            'dynamodb:DeleteItem'
                        ],
                        Resource: [
                            { "Fn::GetAtt": ['ConnectionsTable', 'Arn'] }
                        ]
                    },
                ],
            },
        },
    },
    functions: {
        hello,
        game,
    },
    package: {
        // When true optimise lambda performance but increase deployment time
        individually: !!process.env.STAGE_TYPE && process.env.STAGE_TYPE !== 'dev',
    },
    resources: {
        Resources: Object.assign(dynamodbTables),
        Outputs: {
            ApiURL: {
                Value: 'https://${self:custom.apiDomainName}/${self:custom.apiBasePath}'
            }
        }
    }
};

module.exports = serverlessConfiguration;
