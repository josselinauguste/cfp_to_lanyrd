require_relative 'lanyrd_session'
require_relative 'bdxio_session_presenter'
require_relative 'cfp'

require 'dotenv'
Dotenv.load

def cfp_to_lanyrd(cfp, lanyrd_session)
  conference = cfp.conferences.first
  schedule = conference.schedule_list.schedules.first
  schedule.slots.each do |slot|
    session_presenter = BdxioSessionPresenter.new(slot)
    unless session_presenter.eligible?
      puts "Session \"#{session_presenter.title}\" is not eligible to export." if session_presenter.title
      next
    end
    unless lanyrd_session.session_present?(session_presenter.title)
      lanyrd_session.add_session(
        session_presenter.title,
        session_presenter.abstract,
        session_presenter.start_at,
        session_presenter.end_at,
        session_presenter.room)
    end
    twitters = slot.talk.speaker_list.collect(&:twitter).select { |s| !s.nil? && s.length > 0 }
    lanyrd_session.set_session_speakers(session_presenter.title, twitters)
  end
end

if __FILE__ == $PROGRAM_NAME
  # 'http://cfp.bdx.io' '2015/bdxio'
  cfp = CFP::Instance.from(ARGV[0])
  session = LanyrdSession.new(ARGV[1], ENV['LANYRD_LOGIN'], ENV['LANYRD_PASSWORD'])
  if ARGV[2] == '-clean'
    session.delete_sessions
  end
  cfp_to_lanyrd(cfp, session)
end
