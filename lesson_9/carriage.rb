require_relative 'manufacturer.rb'
require_relative 'validation.rb'
require_relative 'accessor.rb'
require_relative 'train.rb'

class Carriage
  include Manufacturer
  include Validation
  extend Accessor

  attr_reader :type, :total, :busy

  validate :total, :zero

  OVERLOADED = 'Перегружен'.freeze

  def initialize(total)
    @type = 'Not speсified'
    @total = total
    validate!
    @busy = 0
  end

  def free_volume
    total - busy
  end

  def take_volume(volume)
    raise OVERLOADED if busy + volume > total

    @busy += volume
  end
end
