class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_add(train)
    return if self.trains.include?(train)
    @trains << train
  end

  def trains_display(trains = self.trains)
    return if trains.empty?
    trains.each { |train| puts "#{train.number}:#{train.type}:#{train.carriges_count}" }    
  end

  def trains_display_with_type(trains = self.trains, type)
    return if trains.empty?
    select_trains = trains.select { |train| train.type == type }
    trains_display(select_trains)    
  end

  def send_train(train)
    return unless self.trains.include?(train)
    @trains.delete(train)
  end

end
