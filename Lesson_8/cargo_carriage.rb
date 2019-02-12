require_relative "carriage.rb"

class CargoCarriage < Carriage

  def initialize(volume)
    super(volume)
    @type = "Cargo"
  end

  def take_volume(volume)
    raise OVERLOADED if busy + volume > total
    @busy += volume   
  end

end
