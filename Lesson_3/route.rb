class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    return if stations.include?(station)
    stations.insert(-2,station)
  end

  def delete_station(station)
    return if [stations.first, stations.last].include?(station)
    stations.delete(station)
  end

  def display_stations
    stations.each { |station| puts station.name }
  end

end
