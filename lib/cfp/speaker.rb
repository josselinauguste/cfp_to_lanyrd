require 'virtus'

module CFP
  class Speaker
    include Virtus.model

    attribute :uuid, String
    attribute :last_name, String
    attribute :first_name, String
    attribute :links, Array
    attribute :avatar_url, String
  end
end
