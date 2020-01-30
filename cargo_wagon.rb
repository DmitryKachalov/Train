class CargoWagon < Wagon

  def initialize(place)
    super
    @type = :cargo
  end
end