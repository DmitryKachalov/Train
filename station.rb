class Station
  attr_reader :name, :trains #getter

  def initialize(name)
    @name = name
    @trains = []
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
