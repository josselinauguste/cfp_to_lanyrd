require 'faraday'
require 'faraday_middleware'
require_relative 'cfp/instance'
require_relative 'cfp/conference'
require_relative 'cfp/schedule_list'
require_relative 'cfp/speaker_list'
require_relative 'cfp/schedule'
require_relative 'cfp/slot'
require_relative 'cfp/talk'
require_relative 'cfp/speaker'
require_relative 'cfp/snake_middleware'

module CFP
  Faraday::Response.register_middleware :camel_to_snake  => lambda { CFP::SnakeMiddleware }

  def self.create_connector(base_url = nil)
    Faraday.new(url: base_url) do |faraday|
      faraday.request :json

      faraday.response :camel_to_snake
      faraday.response :json
      #faraday.response :logger

      faraday.adapter Faraday.default_adapter
    end
  end
end
