import { middyfy } from '@libs/lambda';
import { APIGatewayProxyHandler } from 'aws-lambda';

/**
 * Simple function to avoid ApiGatway error 
 * "Inaccessible host: `execute-api.us-east-1.amazonaws.com'. This service may not be available in the `us-east-1' region."
 */
export const hello: APIGatewayProxyHandler = async (event, _context) => {
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello ! Your function executed successfully!',
      input: event,
    }, null, 2),
  };
}
export const main = middyfy(hello);
