class BdxioSessionPresenter
  def initialize(slot)
    @slot = slot
  end

  def title
    @slot.talk ? @slot.talk.title : nil
  end

  def abstract
    @slot.talk ? @slot.talk.summary : nil
  end

  def start_at
    DateTime.parse(@slot.from_time).to_time.strftime('%H:%M')
  end

  def end_at
    DateTime.parse(@slot.to_time).to_time.strftime('%H:%M')
  end

  def room
    case @slot.room_id
    when 'GdAmphi' then 'Grand Amphi'
    when /Amphi(A|B|D|E)/ then "Amphi #{$1}"
    when /Td(\d\d)/ then "TD #{$1}"
    end
  end

  def eligible?
    @slot.talk && !room.nil?
  end
end
