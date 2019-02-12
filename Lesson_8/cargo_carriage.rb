require_relative 'carriage.rb'

class CargoCarriage < Carriage
  def initialize(volume)
    super
    @type = :cargo
  end

end
