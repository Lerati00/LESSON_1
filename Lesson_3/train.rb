class Train
  attr_reader :carriges_count, :route, :number, :type, :speed
  
  def initialize(number, type, carriges_count)
    @number = number
    @type = type
    @carriges_count = carriges_count
    @speed = 0
  end

  def accelerate(accelerate_by = 10)
    @speed += accelerate_by
  end

  def stop
    @speed = 0
  end

  def add_carrige
    @carriges_count += 1 if speed == 0  
  end

  def delete_carrige
    @carriges_count -= 1 if speed == 0 && carriges_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = route.stations.index(route.stations.first)
    route.stations[@current_station].add_train(self)
  end

  def current_station
    route.stations[@current_station]
  end

  def next_station
    route.stations[@current_station + 1] if @current_station + 1 < route.stations.size
  end

  def previous_station
    route.stations[@current_station - 1] if @current_station - 1 >= 0
  end

  def move_forward
    return if @current_station + 1 >= route.stations.size
    route.stations[@current_station].send_train(self)
    @current_station += 1
    route.stations[@current_station].add_train(self)
  end

  def move_back
    return if @current_station - 1 < 0
    route.stations[@current_station].send_train(self)
    @current_station -= 1
    route.stations[@current_station].add_train(self)
  end
end
