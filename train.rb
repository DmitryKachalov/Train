class Train
  attr_reader :number, :type, :count_wagons, :speed, :current_station

  def initialize(number, type, count_wagons)
    @number = number
    @type = type
    @count_wagons = count_wagons
    @speed = 0
  end

  def decrease_speed(value)
    @speed -= value
    @speed = 0 if @speed.negative?
  end

  def increase_speed(value)
    @speed += value
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

    @route[@current_station].remove_train(self)
    @current_station_index += 1
    @route[@current_station].add_train(self)
  end

  def backward_train
    return unless prev_station

    @route[@current_station].remove_train(self)
    @current_station_index -= 1
    @route[@current_station].add_train(self)
  end

  def next_station
    return if @current_station >= @route.size - 1

    @route[@current_station + 1]
  end

  def prev_station
    return if @current_station == @route.start

    @route[@current_station - 1]
  end
end
