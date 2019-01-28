class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def station_add(station)
    self.stations.insert(-2,station)
  end

  def station_delete(station)
    return unless self.stations.include?(station)
    self.stations.delete(station)
  end

  def stations_display
    return if self.stations.empty?
    self.stations.each {|station| puts station.name}
  end

end
