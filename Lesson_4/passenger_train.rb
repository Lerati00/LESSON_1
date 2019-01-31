require_relative "train.rb"

class PassengerTrain < Train
  
  def initialize(number)
    super
    @type = "Passenger"
  end

  def add_carriage
    return unless @type == "Passenger" && speed == 0
    @carriages << PassengerCarriage.new 
  end

end
