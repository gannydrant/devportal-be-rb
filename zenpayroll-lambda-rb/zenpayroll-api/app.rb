require 'httparty'
require 'awesome_print'
require 'json'

def lambda_handler(event:, context:)
  # Sample pure Lambda function

  # Parameters
  # ----------
  # event: Hash, required
  #     API Gateway Lambda Proxy Input Format
  #     Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

  # context: object, required
  #     Lambda Context runtime methods and attributes
  #     Context doc: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html

  # Returns
  # ------
  # API Gateway Lambda Proxy Output Format: dict
  #     'statusCode' and 'body' are required
  #     # api-gateway-simple-proxy-for-lambda-output-format
  #     Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html

  # begin
  #   response = HTTParty.get('http://checkip.amazonaws.com/')
  # rescue HTTParty::Error => error
  #   puts error.inspect
  #   raise error
  # end

  base_url = "http://host.docker.internal:3000/internal"

  partner_id = event['pathParameters']['partnerId']
  params = JSON.parse(event['body']).merge({ 'partner_id' => partner_id })

  begin
    response = HTTParty.post("#{base_url}/partners/#{partner_id}/applications", body: params.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
  rescue HTTParty::Error => error
    puts error.inspect
    return {
      statusCode: 500,
      message: 'Ruh-roh'
    }
  end

  ap JSON.parse(response)

  {
    statusCode: 200,
    body: {
      message: "Hello Applications!",
      # location: response.body
    }.to_json
  }
end
