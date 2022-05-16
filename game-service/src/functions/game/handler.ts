import { formatJSONResponse, ValidatedEventAPIGatewayProxyEvent } from '@libs/apiGateway';
import { middyfy } from '@libs/lambda';
import { CONNECTIONS_TABLE, dynamoDBClient } from '@libs/db';
import { getAllConnections, sendMessage } from '@libs/broadcast';

import gameSchema from '../../schema/game';


const game: ValidatedEventAPIGatewayProxyEvent<typeof gameSchema> = async (event) => {

  console.log(event);
  const { body, requestContext: { connectionId, routeKey }} = event;
  console.log(body, routeKey, connectionId);
  
  switch (routeKey) {
    case '$connect':
      await dynamoDBClient().put({
        TableName: CONNECTIONS_TABLE,
        Item: {
          connectionId,
          // Expire the connection an hour later. This is optional, but recommended.
          // You will have to decide how often to time out and/or refresh the ttl.
          ttl: parseInt((Date.now() / 1000).toString() + 3600)
        }
      }).promise();
      break;

    case '$disconnect':
      await dynamoDBClient().delete({
        TableName: CONNECTIONS_TABLE,
        Key: { connectionId }
      }).promise();
      break;

    case '$default':
    default:
      const connections = await getAllConnections();
      await Promise.all(
        connections.map(connectionId => sendMessage(connectionId, body))
      );
      break;
  }

  return formatJSONResponse({
    statusCode: 200,
    // message: "report created",
    // data: params.Item,
  });
}

export const main = middyfy(game);
