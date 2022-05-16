import { dynamoDBClient } from '@libs/db';
import { CONNECTIONS_TABLE } from './db';
import * as AWS from 'aws-sdk';

export async function sendMessage(connectionId: string, body: any) {
    try {
        const endpoint = process.env.APIG_ENDPOINT;
        const apig = new AWS.ApiGatewayManagementApi({
            apiVersion: '2018-11-29',
            endpoint
        });
        await apig.postToConnection({
            ConnectionId: connectionId,
            Data: JSON.stringify(body)
        }).promise();
    } catch (err) {
        // Ignore if connection no longer exists
        if (err.statusCode !== 400 && err.statusCode !== 410) {
            throw err;
        }
    }
}

export async function getAllConnections() {
    const { Items, LastEvaluatedKey } = await dynamoDBClient().scan({
        TableName: CONNECTIONS_TABLE,
        AttributesToGet: ['connectionId']
    }).promise();

    const connections = Items.map(({ connectionId }) => connectionId);
    if (LastEvaluatedKey) {
        connections.push(...await getAllConnections());
    }

    return connections;
}
