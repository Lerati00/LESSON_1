require_relative "instance_counter.rb"

class Route
  STATION_OBJECT_ERROR = "Начальная или конечная станция не является объектом класса 'Station'"

  include InstanceCounter

  attr_reader :stations, :name

  def initialize(from, to)
    @stations = [from, to]
    validate!
    @name = "#{from.name}-#{to.name}" 
    register_instance
  end

  def add_station(station)
    return unless station.valid?
    return if stations.include?(station)
    stations.insert(-2,station)
  end

  def delete_station(station)
    return if [stations.first, stations.last].include?(station)
    stations.delete(station)
  end

  def validate!
    raise STATION_OBJECT_ERROR unless @stations[0].valid? && @stations[-1].valid?
  end

end
