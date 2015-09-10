require 'virtus'

module CFP
  class Talk
    include Virtus.model

    attribute :id, String
    attribute :talk_type, String
    attribute :track, String
    attribute :title, String
    attribute :lang, String
    attribute :summary, String
  end
end
