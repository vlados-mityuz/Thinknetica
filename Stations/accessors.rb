module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        method_name = "@#{method}"
        method_history = "@#{method}_history"
        define_method(method) { instance_variable_get(method_name) }
        define_method("#{method}_history") { instance_variable_get(method_history) }

        define_method("#{method}=") do |value|
          if instance_variable_get.nil?
            instance_variable_set(method_history, [instance_variable_get(method_name)])
          else
            instance_variable_get(method_history) << instance_variable_get(method_name)
          end
          instance_variable_set(method_name, value)
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}"
      define_method(name) { instance_variable_get(var_name) }
      define_method("@#{name}=") do |value|
        if value.is_a? type
          instance_variable_set(var_name, value)
        else
          raise TypeError
        end
      end
    end
  end
end