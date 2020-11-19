module LambdaFunctions
    class Handler
        def self.process(event:, context:)
            {
                statusCode: 200,
                body: {
                    message: 'From scratch again'
                }.to_json
            }
        end
    end
end
