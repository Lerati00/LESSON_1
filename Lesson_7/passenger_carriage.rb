require_relative "carriage.rb"

class PassengerCarriage < Carriage

  def initialize(number_places)
    super(number_places)
    @type = "Passenger"
  end

  def take_place
    raise OVERLOADED if busy >= total
    @busy += 1
  end

end
