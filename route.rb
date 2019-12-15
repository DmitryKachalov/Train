class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station
    @stations.delete_at(-2) if @stations.size > 2
  end
end
