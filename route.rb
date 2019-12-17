class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]

  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless [start, finish].include? station
  end

  def print_stations
    @stations.each { |station| puts station.name }
  end

  def start
    @stations.first
  end

  def finish
    @stations.last
  end
end
