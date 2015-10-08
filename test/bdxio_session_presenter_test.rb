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

  def test_title_and_abstract_can_be_nil
    slot = CFP::Slot.new(talk: CFP::Talk.new())
    presenter = BdxioSessionPresenter.new(slot)

    assert_nil presenter.title
    assert_nil presenter.abstract
  end

  def test_room_label_grd_amphi
    slot = CFP::Slot.new(room_id: 'GdAmphi')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Grand Amphi', presenter.room
  end

  def test_room_label_amphi
    slot = CFP::Slot.new(room_id: 'AmphiD')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Amphi D', presenter.room
  end

  def test_room_label_td
    slot = CFP::Slot.new(room_id: 'Td11')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Salle TD 11', presenter.room
  end

  def test_room_label_td_with_space
    slot = CFP::Slot.new(room_id: 'Td 11')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal 'Salle TD 11', presenter.room
  end

  def test_slot_with_known_room_is_eligible
    slot = CFP::Slot.new(room_id: 'Td11', talk: CFP::Talk.new)
    presenter = BdxioSessionPresenter.new(slot)

    assert presenter.eligible?
  end

  def test_slot_with_unknown_room_isnt_eligible
    slot = CFP::Slot.new(room_id: 'Annie Hall', talk: CFP::Talk.new)
    presenter = BdxioSessionPresenter.new(slot)

    refute presenter.eligible?
  end

  def test_slot_without_talk_isnt_eligible
    slot = CFP::Slot.new(room_id: 'Td11')
    presenter = BdxioSessionPresenter.new(slot)

    refute presenter.eligible?
  end

  def test_convert_time_to_zone
    slot = CFP::Slot.new(from_time: '08:00', to_time: '08:50')
    presenter = BdxioSessionPresenter.new(slot)

    assert_equal '10:00', presenter.start_at
    assert_equal '10:50', presenter.end_at
  end
end
