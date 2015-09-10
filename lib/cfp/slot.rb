require 'virtus'
require_relative 'talk'

module CFP
  class Slot
    include Virtus.model

    attribute :room_id, String
    attribute :not_allocated, Boolean
    attribute :from_time_millis, Integer
    attribute :break, Hash
    attribute :room_setup, String
    attribute :talk, Talk
    attribute :from_time, String
    attribute :to_time_millis, Integer
    attribute :to_time, String
    attribute :room_capacity, Integer
    attribute :room_name, String
    attribute :slot_id, String
    attribute :day, String
  end
end
