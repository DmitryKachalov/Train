require_relative 'train'

class CargoTrain < Train
  include Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super
    @type = :cargo
    validate!
  end
end