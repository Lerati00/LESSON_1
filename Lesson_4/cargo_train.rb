require_relative "train.rb"

class CargoTrain < Train
  
  def initialize(number)
    super
    @type = "Cargo"
  end

  def add_carriage
     return unless @type == "Cargo" && speed == 0
     @carriages = CargoCarriage.new
  end

end
