# frozen_string_literal: true

require 'sequel'
require 'awesome_print'

module LambdaFunctions
  class Handler
    def self.process(event:, context:)
      db = Sequel.connect(adapter: :postgres, user: 'daniel.grant', host: '127.0.0.1', port: '5432', database: 'devportal_development')

      db['select title from films'].each { |r| puts r }

      ap 'using a bundled dependency!'

      {
        statusCode: 200,
        body: {
          message: 'From scratch again'
        }.to_json
      }
    end
  end
end
