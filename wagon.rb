# frozen_string_literal: true

require_relative './module/manufacturer'

class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(place)
    @max_place = place
    @free = place
  end

  def take_place(place)
    free = @free - place
    raise 'Превышение максимального места' if free.negative?

    @free = free
  end

  def free_place
    @free
  end

  def occupied_place
    @max_place - @free
  end
end
