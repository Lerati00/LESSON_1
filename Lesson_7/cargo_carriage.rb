require_relative "carriage.rb"

class CargoCarriage < Carriage
  

  attr_reader :volume, :taking_volume

  def initialize(volume)
    super(volume)
    @type = "Cargo"
  end

  def take_volume(volume)
    raise OVERLOADED if busy + volume > total
    @busy += volume   
  end

end
