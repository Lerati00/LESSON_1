module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      raise TypeError, "[#{name}] не символ" unless name.is_a?(Symbol)

      define_method(name) { instance_variable_get("@#{name}") }

      define_method("#{name}_history") { instance_variable_get("@#{name}_history") }

      define_method("#{name}=") do |value|
        history = instance_variable_get("@#{name}_history")
        old_value = instance_variable_get("@#{name}")
        instance_variable_set("@#{name}", value)
        if history.nil?
          instance_variable_set("@#{name}_history", [])
        else
          instance_variable_get("@#{name}_history") << old_value
        end
      end
    end
  end

  def strong_attr_accessor(name, type)
    raise TypeError, "[#{name}] не символ" unless name.is_a?(Symbol)

    define_method(name) { instance_variable_get("@#{name}") }

    define_method("#{name}=") do |value|
      raise TypeError, 'Не совпадает тип значения' unless value.is_a?(type)

      instance_variable_set("@#{name}", value)
    end
  end
end
