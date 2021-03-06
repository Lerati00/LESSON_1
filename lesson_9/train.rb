require_relative 'passenger_carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessor.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessor

  NUMBER_FORMAT = /^[\wа-яё]{3}-?[\wа-яё]{2}$/i.freeze

  attr_reader :number,
              :type,
              :carriages

  attr_accessor_with_history :speed, :route

  validate :number, :presence
  validate :number, :format,   NUMBER_FORMAT
  validate :number, :type,     String

  def initialize(number)
    @number = number
    validate!
    @type      = 'Not speсified'
    @carriages = []
    @speed     = 0
    @trains    = {}
    @trains[number] ||= self
    register_instance
  end

  def self.find(number)
    @trains[number]
  end

  def accelerate(accelerate_by = 10)
    @speed += accelerate_by
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage = Carriage.new)
    return unless speed.zero?

    @carriages << carriage if attachable_carriage?(carriage)
  end

  def delete_carriage(carriage = @carriages.last)
    @carriages.delete(carriage) if speed.zero?
  end

  def carriages_count
    @carriages.count
  end

  def route=(route)
    @route = route
    @current_station = 0
    route.stations[@current_station].add_train(self)
  end

  def next_station
    return if route.nil?

    route.stations[@current_station + 1]
  end

  def current_station
    return if route.nil?

    route.stations[@current_station]
  end

  def previous_station
    return if route.nil?

    route.stations[@current_station - 1] if @current_station > 0
  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    next_station.add_train(self)
    @current_station += 1
  end

  def move_back
    return unless previous_station

    current_station.send_train(self)
    previous_station.add_train(self)
    @current_station -= 1
  end

  def each_carriage_with_index
    carriages.each_with_index { |carriage, index| yield(carriage, index) }
  end
end
