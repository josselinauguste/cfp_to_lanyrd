require 'cgi'
require 'watir'
require 'nokogiri'

class LanyrdSession
  def initialize(event, login, password)
    @base_url = 'https://lanyrd.com/' + event + '/'
    @agent = Watir::Browser.new :firefox
    login(login, password)
  end

  def close
    @agent.close
  end

  def login(login, password)
    @agent.goto 'http://lanyrd.com/signin/'
    @agent.text_field(name: 'email').set(login)
    @agent.text_field(name: 'password').set(password)
    @agent.button(value: 'Go').click
  end

  def session_present?(session_title)
    @agent.goto "#{@base_url}edit/schedule/?q=#{CGI.escape(session_title)}"
    page = Nokogiri::HTML(@agent.html)
    !page.search('.sessions-table .row-content').empty?
  end

  def add_session(title, abstract, start_at, end_at, room = nil)
    @agent.goto "#{@base_url}edit/schedule/add/"
    @agent.text_field(name: 'title').set(title)
    @agent.textarea(name: 'abstract').set(abstract)
    @agent.text_field(name: 'start_time').set(start_at)
    @agent.text_field(name: 'end_time').set(end_at)
    if room && room_list = @agent.select_list(name: 'location')
      room_list.select("- #{room}")
    end
    @agent.button(value: 'Save session').click
  end

  def delete_sessions
    Kernel.loop do
      @agent.goto "#{@base_url}edit/schedule/"
      links = @agent.links(text: 'Remove session').to_a
      break if links.length == 0
      links.each do |link|
        link.click
        @agent.input(value: 'Delete session').when_present.click
      end
    end
  end

  def speaker_present?(full_name)
    @agent.goto "#{@base_url}edit/speakers/?q=#{CGI.escape(full_name)}"
    page = Nokogiri::HTML(@agent.html)
    !page.search('.mini-profile').empty?
  end

  def add_speaker()
    @agent.goto "#{@base_url}edit/speakers/"
    # todo
  end
end
