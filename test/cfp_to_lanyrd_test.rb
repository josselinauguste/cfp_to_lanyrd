require_relative 'test_helper'
require 'cfp_to_lanyrd'

class CfpToLanyrdTest < Minitest::Test
  def test_create_sessions_on_lanyrd
    cfp = create_cfp
    session = Minitest::Mock.new
    session.expect :session_present?, false, ['Keynote']
    session.expect :add_session, nil, ['Keynote', 'Summary', '09:00', '09:50', 'Grand Amphi']
    session.expect :set_session_speakers, nil, ['Keynote', ['@dumb', '@dumber']]

    cfp_to_lanyrd cfp, session

    session.verify
  end

  def test_dont_create_existing_session_on_lanyrd
    cfp = create_cfp
    session = Minitest::Mock.new
    session.expect :session_present?, true, ['Keynote']
    session.expect :set_session_speakers, nil, ['Keynote', ['@dumb', '@dumber']]

    cfp_to_lanyrd cfp, session

    session.verify
  end

  def test_dont_create_uneligible_session_on_lanyrd
    cfp = create_cfp(room_id: 'Foo')
    session = Minitest::Mock.new

    cfp_to_lanyrd cfp, session

    session.verify
  end

  private

  def create_cfp(room_id: 'GdAmphi')
    Object.new.tap do |instance|
      instance.instance_variable_set('@room_id', room_id)
      def instance.conferences
        [] << Object.new.tap do |conference|
          conference.instance_variable_set('@room_id', @room_id)
          def conference.schedule_list
            Object.new.tap do |schedule_list|
              schedule_list.instance_variable_set('@room_id', @room_id)
              def schedule_list.schedules
                [] << Object.new.tap do |schedule|
                  schedule.instance_variable_set('@room_id', @room_id)
                  def schedule.slots
                    cfp = CFP::Slot.new(
                      room_id: @room_id,
                      from_time: '07:00',
                      to_time: '07:50')
                    def cfp.talk
                      Object.new.tap do |talk|
                        def talk.title
                          'Keynote'
                        end
                        def talk.summary
                          'Summary'
                        end
                        def talk.speaker_list
                          [CFP::Speaker.new({twitter: '@dumb'}), CFP::Speaker.new({twitter: '@dumber'})]
                        end
                      end
                    end
                    [] << cfp
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
