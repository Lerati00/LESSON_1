require_relative "instance_counter.rb"

class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(from, to)
    @stations = [from, to]
    @name = "#{from.name}-#{to.name}" 
    register_instance
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
