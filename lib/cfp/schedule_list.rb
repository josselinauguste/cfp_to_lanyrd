require 'virtus'

module CFP
  class ScheduleList
    include Virtus.model

    attribute :links, Array

    def self.from(url)
      new(CFP.create_connector.get(url).body)
    end

    def schedules
      @schedules ||= links.select { |c| /profile\/schedule/ =~ c['rel'] }.map { |c| Schedule.from(c['href']) }
    end
  end
end
