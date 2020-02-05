# frozen_string_literal: true

require_relative './module/manufacturer'
require_relative './module/instance_counter'
require_relative './module/validation'
class Train
  include InstanceCounter
  include Manufacturer

  NUMBER_FORMAT = /\w{3}-?\w{2}/.freeze

  attr_reader :number, :speed, :type, :wagons
  @@trains = {}

  def initialize(number)
    @number = number.to_s
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def each_wagon
    @wagons.each { |wagon| yield wagon }
  end

  def decrease_speed(value)
    @speed -= value.abs
    @speed = 0 if @speed.negative?
  end

  def increase_speed(value)
    @speed += value.abs
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && @type == wagon.type
  end

  def remove_wagon
    @wagons.pop if @speed.zero?
  end

  def accept_route(route)
    @route = route
    @route.stations.first.add_train(self)
    @current_station_index = 0
  end

  def route
    @route&.name
  end

  def forward_train
    return unless next_station

    current_station.remove_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def backward_train
    return unless prev_station

    current_station.remove_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def free_place
    get_place('free')
  end

  def occupied_place
    get_place('occupied')
  end

  protected

  def get_place(which)
    place = 0
    each_wagon { |wagon| place += wagon.send("#{which}_place") }
    place
  end

  # методы вспомогательные
  def next_station
    return if @current_station_index >= @route.stations.size - 1

    @route.stations[@current_station_index + 1]
  end

  def prev_station
    return if @current_station_index.zero?

    @route.stations[@current_station_index - 1]
  end
end
