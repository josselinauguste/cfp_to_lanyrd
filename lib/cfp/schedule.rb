require 'virtus'
require_relative 'slot'

module CFP
  class Schedule
    include Virtus.model

    attribute :slots, Array[Slot]

    def initialize(attributes)
      super(attributes)
    end

    def self.from(url)
      new(CFP.create_connector.get(url).body)
    end

    def talks
      slots.collect(&:talk).compact
    end
  end
end
