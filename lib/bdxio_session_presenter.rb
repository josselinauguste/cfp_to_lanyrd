class BdxioSessionPresenter
  def initialize(slot)
    @slot = slot
  end

  def title
    @slot.talk.title
  end

  def abstract
    @slot.talk.summary
  end

  def start_at
    @slot.from_time
  end

  def end_at
    @slot.to_time
  end

  def room
    case @slot.room_id
    when 'GdAmphi' then 'Grand Amphi CapGé'
    when /Amphi(\w)/ then "Amphi #{$1}"
    when /Td(\d+)/ then "TD #{$1}"
    end
  end
end
