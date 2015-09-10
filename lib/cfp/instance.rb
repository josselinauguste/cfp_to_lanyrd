require 'virtus'

module CFP
  class Instance
    include Virtus.model

    attribute :links, Array

    def self.from(url)
      new(CFP.create_connector(url).get('/api/conferences').body)
    end

    def conferences
      @conferences ||= links.select { |c| /profile\/conference/ =~ c['rel'] }.map { |c| Conference.from(c['href']) }
    end
  end
end
