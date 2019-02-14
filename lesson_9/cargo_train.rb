require_relative 'train.rb'

class CargoTrain < Train
  validate :number, :presence
  validate :number, :format,   NUMBER_FORMAT
  validate :number, :type,     String

  def initialize(number)
    super
    @type = 'Cargo'
  end

  def add_carriage(carriage = CargoCarriage.new)
    super
  end

  protected

  def attachable_carriage?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
