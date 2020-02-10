# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, *args)
      @validations ||= []
      @validations << { name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation.each do |name, args|
          val = instance_variable_get("@#{name}")
          send "validate_#{args[0]}", val, *args[1]
        end
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def validate_presence(val)
      raise 'Пустое значение' if val.nil? || val.empty?
    end

    def validate_type(val, type)
      raise 'Невалидный тип' if val.class != type
    end

    def validate_format(val, format)
      raise 'Неверный формат' if val !~ format
    end

    def validate_route(val)
      if val.first.class == 'Station' || val.last.class == 'Station'
        raise 'Неверный класс станции'
      end
      raise 'Одинаковые станции' if val.first == val.last
    end
  end
end
