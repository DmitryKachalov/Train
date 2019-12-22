require_relative 'train'

class CargoTrain < Train

  def initialize(number)
    super
    @type = :cargo
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end
end