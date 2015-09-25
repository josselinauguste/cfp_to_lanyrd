require_relative '../test_helper'
require 'cfp'

class InstanceTest < Minitest::Test
  def setup
    @instance = CFP::Instance.from('http://cfp.bdx.io')
  end

  def test_get_conferences
    conferences = @instance.conferences

    assert_equal 1, conferences.length
    assert_equal 'BdxIO2015', conferences.first.event_code
  end

  def test_get_schedule
    conference = @instance.conferences.first

    refute_nil conference.schedule_list
    assert_equal 1, conference.schedule_list.schedules.length
    assert_operator conference.schedule_list.schedules.first.slots.length, :>, 1
    refute_empty conference.schedule_list.schedules.first.slots.first.room_id
    assert_operator conference.schedule_list.schedules.first.talks.length, :>, 1
    refute_empty conference.schedule_list.schedules.first.talks.first.title
  end

  def test_get_speakers
    conference = @instance.conferences.first

    refute_nil conference.speaker_list
    refute_empty conference.speaker_list.speakers
  end
end
