require_relative 'test_helper'
require 'lanyrd_session'

require 'dotenv'
Dotenv.load

class LanyrdSessionTest < Minitest::Test
  def teardown
    @lanyrd_session.close if @lanyrd_session
  end

  def test_speaker_presence
    init_lanyrd_session

    assert @lanyrd_session.speaker_present? 'Nicolas Cannasse'
  end

  def test_non_speaker_presence
    init_lanyrd_session

    refute @lanyrd_session.speaker_present? 'Jean Dumoulin'
  end

  def test_session_presence
    init_lanyrd_session

    assert @lanyrd_session.session_present? 'Keynote'
  end

  def test_non_session_presence
    init_lanyrd_session

    refute @lanyrd_session.session_present? 'Apéro'
  end

  def test_add_session
    title = (0...8).map { ('a'..'z').to_a[rand(26)] }.join
    init_lanyrd_session '2015/test-3'

    @lanyrd_session.add_session title, 'abstract...', '07:00', '07:50'

    assert @lanyrd_session.session_present?(title)
  end

  private

  def init_lanyrd_session(event = '2014/bdxio')
    @lanyrd_session = LanyrdSession.new(event, ENV['LANYRD_LOGIN'], ENV['LANYRD_PASSWORD'])
  end
end
