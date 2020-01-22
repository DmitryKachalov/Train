class Station
  attr_reader :name, :trains #getter
  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
  end

  def self.all
    @@all
  end

  def trains_type(type)
    @trains.select { |train| train.type == type }
  end

  #def trains_type_count(type)
  #  trains_type(type).size
  #end

  def add_train(train)
    @trains.push(train)
  end

  def remove_train(train)
    @trains.delete(train)
  end
end
