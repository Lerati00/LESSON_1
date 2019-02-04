require_relative "instance_counter.rb"

class Station
  include InstanceCounter

  attr_reader :name, :trains
  
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
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

end
