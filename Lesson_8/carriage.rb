require_relative 'manufacturer.rb'

class Carriage
  include Manufacturer
  attr_accessor :train
  attr_reader :type, :total, :busy

  def initialize(total)
    @type = 'Not speсified'
    @total = total
    validate!
    @busy = 0
  end

  def valide?
    validate!
    true
  rescue StandardError
    false
  end

  def free_volume
    total - busy
  end

  def take_volume(volume)
    raise OVERLOADED if busy + volume > total
    @busy += volume
  end

  private

  ZERO_ERROR = 'Не может быть нулем'.freeze
  OVERLOADED = 'Перегружен'.freeze

  def validate!
    raise ZERO_ERROR if total <= 0 || total.nil?
  end
end
