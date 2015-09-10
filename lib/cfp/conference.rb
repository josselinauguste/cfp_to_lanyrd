require 'virtus'

module CFP
  class Conference
    include Virtus.model

    attribute :event_code, String
    attribute :links, Array

    def self.from(url)
      new(CFP.create_connector.get(url).body)
    end

    def schedule_list
      @schedule_list ||= ScheduleList.from(links.select { |c| /profile\/schedules/ =~ c['rel'] }.first['href'])
    end

    def speaker_list
      @speaker_list ||= SpeakerList.from(links.select { |c| /profile\/list-of-speakers/ =~ c['rel'] }.first['href'])
    end
  end
end
