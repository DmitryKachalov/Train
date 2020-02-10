# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(place)
    super
    @type = :passenger
  end

  def take_place
    super(1)
  end
end
