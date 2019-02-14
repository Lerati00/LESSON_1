require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name, :presence
  validate :name, :type, String

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@stations << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.all
    @@stations
  end

  def add_train(train)
    return if trains.include?(train)

    @trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_train
    trains.each { |train| yield(train) }
  end
end
