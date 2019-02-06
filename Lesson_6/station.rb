require_relative "instance_counter.rb"

class Station
  NIL_NAME_ERROR = "Название станции не может быть пустым"

  include InstanceCounter

  attr_reader :name, :trains
  
  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@stations <<  self
  end

  def valid?
    validate!
    true
  rescue
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

  private

  def validate!
    raise NIL_NAME_ERROR if name.nil? || name == ""
  end

end
