require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'station.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :name

  validate :stations,       :presence
  validate :first_stantion, :type,     Station
  validate :last_stantion,  :type,     Station
  validate :first_stantion, :equals, :last_stantion

  def initialize(from, to)
    @first_stantion = from
    @last_stantion = to
    @stations = [from, to]
    validate!
    @name = "#{from.name}-#{to.name}"
    register_instance
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
end
