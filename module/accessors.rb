# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*args)

    args.each do |arg|
      instance_variable_set("@#{arg}_history", [])
      define_method("#{arg}=".to_sym) do |value|
        instance_variable_set("@#{arg}", value)
        history = instance_variable_get("@#{arg}_history")
        history << value
        instance_variable_set("@#{arg}_history", history)
      end
      define_method("#{arg}_history") { instance_variable_get("@#{arg}_history") }
    end
  end

  def strong_attr_accessor(arg, klass)
    arg_var = "@#{arg}".to_sym
    define_method(arg) { instance_variable_get(arg_var) }
    define_method("#{arg}=".to_sym) do |value|
      raise "Types don't match" unless value.is_a?(klass)

      instance_variable_set(arg_var, value)
    end
  end
end
