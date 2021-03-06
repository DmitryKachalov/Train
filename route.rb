# frozen_string_literal: true

require_relative './module/instance_counter'
require_relative './module/validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  validate :stations, :presence
  validate :stations, :route

  def initialize(start, finish, stations = nil)
    @stations = [start, finish]
    validate!
    stations&.each { |station| add_station(station) }
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) unless [start, finish].include? station
  end

  def print
    @stations.each_with_index do |station, index|
      unless station == start || station == finish
        puts "#{index}. #{station.name}"
      end
    end
  end

  def start
    @stations.first
  end

  def finish
    @stations.last
  end

  def name
    "#{start.name} - #{finish.name}"
  end
end
