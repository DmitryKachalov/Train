# frozen_string_literal: true

require_relative './module/instance_counter'
require_relative './module/validation'

class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^[a-z]{1,15}$/i.freeze

  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    @@all << self
    register_instance
    validate!
  end

  def self.all
    @@all
  end

  def each_train
    @trains.each { |train| yield train }
  end

  def trains_type(type)
    @trains.select { |train| train.type == type }
  end

  def add_train(train)
    @trains.push(train)
  end

  def remove_train(train)
    @trains.delete(train)
  end
end
