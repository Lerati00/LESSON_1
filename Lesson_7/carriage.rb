require_relative "manufacturer.rb"

class Carriage
  ZERO_ERROR = "Не может быть нулем"
  OVERLOADED = "Перегружен"

  include Manufacturer
  attr_accessor :train
  attr_reader :type, :total, :busy
  
  def initialize(total)
    @type = "Not speсified"
    @total = total
    validate!
    @busy = 0
  end

  def valide?
    validate!
    true
  rescue
    false
  end

  def free_volume
    total - busy
  end

  private

  def validate!
    raise ZERO_ERROR if total <= 0 || total.nil?
  end


end
