require_relative 'train.rb'

class PassengerTrain < Train
  validate :number, :presence
  validate :number, :format,   NUMBER_FORMAT
  validate :number, :type,     String

  def initialize(number)
    super
    @type = 'Passenger'
  end

  def add_carriage(carriage)
    raise unless carriage.is_a?(PassengerCarriage)

    super
  end

  protected

  def attachable_carriage?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
