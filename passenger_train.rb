require_relative 'train'

class PassengerTrain < Train

  include Validation
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  def initialize(number)
    super
    @type = :passenger
    validate!
  end
end