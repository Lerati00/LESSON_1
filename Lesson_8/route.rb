require_relative 'instance_counter.rb'

class Route
  STATION_OBJECT_ERROR = "Начальная или конечная станция не является объектом класса 'Station'".freeze
  STATION_EQUALS_ERROR = 'Начальная и конечная станции не должны совпадать'.freeze

  include InstanceCounter

  attr_reader :stations, :name

  def initialize(from, to)
    @stations = [from, to]
    validate!
    @name = "#{from.name}-#{to.name}"
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    return unless station.valid?
    return if stations.include?(station)

    stations.insert(-2, station)
  end

  def delete_station(station)
    return if [stations.first, stations.last].include?(station)

    stations.delete(station)
  end

  private

  def validate!
    raise STATION_OBJECT_ERROR unless @stations[0].is_a?(Station) && @stations[-1].is_a?(Station)
    raise STATION_EQUALS_ERROR if @stations[0] == @stations[-1]
  end
end
