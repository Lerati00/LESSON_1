module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send(:include, InstaceMethods)
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, param = nil)
      @validations ||= []
      @validations << { name: name, type: type, param: param }
    end
  end

  module InstaceMethods
    NIL_ERROR = 'Значение не может быть пустым'.freeze
    TYPE_ERROR = 'Значение не является объектом заданного класса'.freeze
    INVALID_FORMAT = 'Значение имеет неправильный формат'.freeze
    ZERO_ERROR = 'Не может быть нулем'.freeze
    EQUALS_ERROR = 'Значения не должны быть эквивалентны'.freeze

    def valid?
      validate!
      true
    rescue StandartError
      false
    end

    protected

    def validate_type(value, type)
      raise TYPE_ERROR unless value.is_a?(type)
    end

    def validate_presence(value, _)
      raise NIL_ERROR if value.nil? || value.to_s.empty?
    end

    def validate_zero(value, _)
      raise ZERO_ERROR if value.nil? || value.to_s.to_f <= 0
    end

    def validate_equals(value, value_)
      raise EQUALS_ERROR if value == instance_variable_get("@#{value_}")
    end

    def validate_format(value, regexp)
      raise INVALID_FORMAT if value.to_s !~ regexp
    end

    def validate!
      self.class.validations.each do |options|
        value = instance_variable_get("@#{options[:name]}")
        method = "validate_#{options[:type]}"
        send(method, value, options[:param])
      end
    end
  end
end
