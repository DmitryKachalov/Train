class Train
  attr_reader :number, :type, :count_wagons, :speed

  def initialize(number, type, count_wagons)
    @number = number.to_s
    @type = type.to_s
    @count_wagons = count_wagons.to_i
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value.abs
    @speed = 0 if @speed.negative?
    @speed
  end

  def increase_speed(value)
    @speed += value.abs
  end

  def add_wagon
    @count_wagons += 1 if @speed.zero?
  end
  
  def remove_wagon
    @count_wagons -= 1 if @speed.zero? && @count_wagons.positive?
  end

  def accept_route(route)
    @route = route
    @route.stations.first.add_train(self)
    @current_station_index = 0
  end

  def forward_train
    return unless next_station

    @route.stations[@current_station_index].remove_train(self)
    @current_station_index += 1
    @route.stations[@current_station_index].add_train(self)
  end

  def backward_train
    return unless prev_station

    @route.stations[@current_station_index].remove_train(self)
    @current_station_index -= 1
    @route.stations[@current_station_index].add_train(self)
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
