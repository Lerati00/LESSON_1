require_relative "carriage.rb"

class PassengerCarriage < Carriage
  ZERO_ERROR = "Не может быть нулем"
  OVERLOADED = "Перегружен"

  attr_reader :number_places, :taking_places

  def initialize(number_places)
    @type = "Passenger"
    @number_places = number_places
    validate!
    @taking_places = 0
  end

  def valide?
    validate!
    true
  rescue
    false
  end

  def take_place
    raise OVERLOADED if taking_places >= number_places
    @taking_places += 1
  end

  def free_places
    number_places - taking_places
  end

  private

  def validate!
    raise ZERO_ERROR if number_places <= 0 || number_places.nil?
  end


end
