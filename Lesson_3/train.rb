class Train
  attr_accessor :speed, :current_station
  attr_reader :carriges_count, :route, :number, :type 
  
  def initialize(number, type, carriges_count)
    @number = number
    @type = type
    @carriges_count = carriges_count
    @speed = 0
  end

  def stop
    speed = 0
  end

  def arrige_add
    self.carriges_count += 1 if speed == 0  
  end

  def carrige_delete
    self.carriges_count -= 1 if speed == 0 && carriges_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = self.route.stations.first
    self.current_station.train_add(self)
  end

  def next_station
    station_index = self.route.stations.index(@current_station)
    return if station_index >= self.route.stations.size - 1 
    puts "next station is :\t #{self.route.stations[station_index + 1].name}"
  end

  def previous_station
    station_index = self.route.stations.index(@current_station)
    return if station_index <= 0
    puts "previous station is :\t #{self.route.stations[station_index - 1].name}"
  end

  def move_forward
    return if self.route.nil?
    station_index = route.stations.index(self.current_station)
    return if station_index >= self.route.stations.size - 1

    self.current_station.send_train(self)
    self.current_station = self.route.stations[station_index + 1]
    self.current_station.train_add(self)
  end

  def move_back
    return if self.route.nil?
    station_index = self.route.stations.index(self.current_station)
    return if station_index <= 0

    self.current_station.send_train(self)
    self.current_station = self.route.stations[station_index - 1]
    self.current_station.train_add(self)
  end
end
