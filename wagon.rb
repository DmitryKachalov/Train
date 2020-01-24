require_relative './module/manufacturer'

class Wagon
  include Manufacturer

  attr_reader :type
end
