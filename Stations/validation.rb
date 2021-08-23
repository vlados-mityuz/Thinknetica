module Validation
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, arg = "")
      self.validations ||= []
      validation_by_type = { type => { name: name, arg: arg } }
      validations << validation_by_type
    end
  end

  module InstanceMethods

    def validate!
      self.class.validations.each do |validation|
        validation.each do |name, type, args|
          value = variable_get(name)
          send(type, value, args)
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(value, arg)
      raise 'Значение отсутствует' if value.nil? || value.empty?
    end

    def format(value, name_format)
      raise 'Значение не соответствует установленному формату' if value !~ format
    end

    def type(value, class_type)
      raise 'Атрибут не соответствует классу' unless class_type.include? value
    end

    def variable_get(name)
      var_name = "@#{name}".to_s
      instance_variable_get(var_name)
    end
  end
end