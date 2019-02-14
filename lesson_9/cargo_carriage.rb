require_relative 'carriage.rb'

class CargoCarriage < Carriage
  validate :total, :zero

  def initialize(volume)
    super
    @type = :cargo
  end
end
