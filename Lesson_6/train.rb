require_relative "passenger_carriage.rb"
require_relative "cargo_carriage.rb"
require_relative "manufacturer.rb"
require_relative "instance_counter.rb"

class Train 
  include Manufacturer 
  include InstanceCounter
  
  attr_reader  :route, :number, :type, :speed, :carriages

  @@trains = {}
  
  def initialize(number) 
    @number = number
    @type = "Not speсified"
    @carriages = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains.[number]
  end

  def accelerate(accelerate_by = 10)
    @speed += accelerate_by
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage = Carriage.new)
    return unless speed == 0
    @carriages << carriage if attachable_carriage?(carriage)
  end

  def delete_carriage(carriage = @carriages.last)
    @carriages.delete(carriage) if speed == 0 
  end

  def carriages_count
    @carriages.count
  end

  def set_route(route)
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

  protected

  def attachable_carriage?(carriage)
    true
  end

end
