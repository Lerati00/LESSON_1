require_relative "carriage.rb"

class CargoCarriage < Carriage
  ZERO_ERROR = "Не может быть нулем"
  OVERLOADED = "Перегружен"

  attr_reader :volume, :taking_volume

  def initialize(volume)
    @type = "Cargo"
    @volume = volume
    validate!
    @taking_volume = 0.0
  end

  def valide?
    validate!
    true
  rescue
    false
  end

  def take_volume(volume)
    raise OVERLOADED if taking_volume + volume > self.volume
    @taking_volume += volume   
  end

  def free_volume
    volume - taking_volume
  end

  private

  def validate!
    raise ZERO_ERROR if volume <= 0 || volume.nil?
  end
  
end
