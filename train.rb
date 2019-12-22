class Train
  attr_reader :number, :speed

  def initialize(number)
    @number = number.to_s
    @wagons = []
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value.abs
    @speed = 0 if @speed.negative?
  end

  def increase_speed(value)
    @speed += value.abs
  end

  #def add_wagon(wagon)
  #  @wagons << wagon if @speed.zero? && @type == :type
  #end
  
  def remove_wagon
    @wagons.pop if @speed.zero?
  end

  def accept_route(route)
    @route = route
    @route.stations.first.add_train(self)
    @current_station_index = 0
  end

  def forward_train
    return unless next_station

    current_station.remove_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def backward_train
    return unless prev_station

    current_station.remove_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def next_station
    return if @current_station_index >= @route.stations.size - 1

    @route.stations[@current_station_index + 1]
  end

  def prev_station
    return if @current_station_index.zero?

    @route.stations[@current_station_index - 1]
  end

  def current_station
    @route.stations[@current_station_index]
  end

end
