require_relative 'test_helper'
require 'cfp_to_lanyrd'

class CfpToLanyrdTest < Minitest::Test
  def test_create_sessions_on_lanyrd
    cfp = create_cfp
    session = Minitest::Mock.new
    session.expect :session_present?, false, ['Keynote']
    session.expect :add_session, nil, ['Keynote', 'Summary', '07:00', '07:50', 'Grand Amphi CapGé']

    cfp_to_lanyrd cfp, session

    session.verify
  end

  def test_dont_create_existing_sessions_on_lanyrd
    cfp = create_cfp
    session = Minitest::Mock.new
    session.expect :session_present?, true, ['Keynote']

    cfp_to_lanyrd cfp, session

    session.verify
  end

  private

  def create_cfp
    Object.new.tap do |instance|
      def instance.conferences
        [] << Object.new.tap do |conference|
          def conference.schedule_list
            Object.new.tap do |schedule_list|
              def schedule_list.schedules
                [] << Object.new.tap do |schedule|
                  def schedule.slots
                    [] << CFP::Slot.new(
                      room_id: 'GdAmphi',
                      from_time: '07:00',
                      to_time: '07:50',
                      talk: CFP::Talk.new(
                        title: 'Keynote',
                        summary: 'Summary'
                      ))
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
