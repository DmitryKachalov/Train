require_relative 'train'

class PassengerTrain < Train

  def initialize(number)
    super
    @type = :passenger
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end
end