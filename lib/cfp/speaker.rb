require 'virtus'

module CFP
  class Speaker
    include Virtus.model

    attribute :uuid, String
    attribute :last_name, String
    attribute :first_name, String
    attribute :links, Array
    attribute :avatar_url, String
    attribute :twitter, String

    def self.from(url)
      new(CFP.create_connector.get(url).body)
    end
  end
end
