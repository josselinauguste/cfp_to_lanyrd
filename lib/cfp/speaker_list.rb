require 'virtus'
require_relative 'speaker'

module CFP
  class SpeakerList
    include Virtus.model

    attribute :speakers, Array[Speaker]

    def self.from(url)
      speakers = CFP.create_connector.get(url).body
      new({speakers: speakers})
    end
  end
end
