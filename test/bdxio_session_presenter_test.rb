require_relative 'test_helper'
require 'bdxio_session_presenter'
require 'cfp'

class BdxioSessionPresenterTest < Minitest::Test
  def test_title
    slot = CFP::Slot.new(talk: CFP::Talk.new(title: 'Keynote'))
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Keynote', presenter.title
  end

  def test_abstract
    slot = CFP::Slot.new(talk: CFP::Talk.new(summary: 'Keynote'))
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Keynote', presenter.abstract
  end

  def test_start_at
    slot = CFP::Slot.new(from_time: '07:00')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal '07:00', presenter.start_at
  end

  def test_end_at
    slot = CFP::Slot.new(to_time: '07:00')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal '07:00', presenter.end_at
  end

  def test_room_label_grd_amphi
    slot = CFP::Slot.new(room_id: 'GdAmphi')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Grand Amphi CapGé', presenter.room
  end

  def test_room_label_amphi
    slot = CFP::Slot.new(room_id: 'AmphiD')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Amphi D', presenter.room
  end

  def test_room_label_td
    slot = CFP::Slot.new(room_id: 'Td11')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'TD 11', presenter.room
  end

  def test_slot_with_known_room_is_eligible
    slot = CFP::Slot.new(room_id: 'Td11')
    presenter = BdxioSessionPresenter.new(slot)

    assert presenter.eligible?
  end

  def test_slot_with_unknown_room_isnt_eligible
    slot = CFP::Slot.new(room_id: 'Annie Hall')
    presenter = BdxioSessionPresenter.new(slot)

    refute presenter.eligible?
  end
end
