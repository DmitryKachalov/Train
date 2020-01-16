class Route
  attr_reader :stations

  def initialize(start, finish, stations = nil)
    @stations = [start, finish]
    stations&.each { |station| add_station(station) }
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless [start, finish].include? station
  end

  def print
    @stations.each_with_index { |station, index| puts "#{index}. #{station.name}" unless station == start || station == finish }
  end

  def start
    @stations.first
  end

  def finish
    @stations.last
  end

  def name
    "#{start.name} - #{finish.name}"
  end
end
