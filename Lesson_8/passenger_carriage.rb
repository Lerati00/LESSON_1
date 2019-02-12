require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  def initialize(number_places)
    super(number_places)
    @type = :passenger
  end

  def take_place
    super(1)
  end
end
