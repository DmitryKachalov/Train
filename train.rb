class Train
  attr_reader :number, :type, :count_wagons
  attr_accessor :speed
  def initialize(number, type, count_wagons)
    @number = number
    @type = type
    @count_wagons = count_wagons
    @speed = 0
  end
  
  def stop
    @speed = 0
  end
  
  def add_wagon
    @count_wagons += 1 if @speed.zero?
  end
  
  def remove_wagon
    @count_wagons -= 1 if @speed.zero? && @count_wagons.positive?
  end

  def accept_route(route)
    @route = route
    @route.first.add_train(self)
  end

  def forward_train
    index = @route.index(current_station)
    return nil unless index < @route.size - 1

    @route[index].remove_train(self)
    @route[index + 1].add_train(self)
  end

  def backward_train
    index = @route.index(current_station)
    return nil if index.zero?

    @route[index].remove_train(self)
    @route[index - 1].add_train(self)
  end

  def current_station
    @route.select { |station| station.select { |train| train == self } }
  end

  def next_station
    index = @route.index(current_station)
    return nil unless index < @route.size - 1

    @route[index + 1]
  end

  def prev_station
    index = @route.index(current_station)
    return nil if index.zero?

    @route[index - 1]
  end
end
