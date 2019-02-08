require_relative "carriage.rb"

class PassengerCarriage < Carriage
  ZERO_ERROR = "Не может быть нулем"
  OVERLOADED = "Перегружен"

  attr_reader 

  def initialize(number_places)
    super(number_places)
    @type = "Passenger"
  end

  def take_place
    raise OVERLOADED if busy >= total
    @busy += 1
  end

end
