require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'interface'

class Main

  attr_reader :user_stations

  def initialize(interface)
    @user_stations = []
    @user_trains = []
    @user_routes = []
    @user_carriages = []
    @interface = interface
  end

  def start
    action = @interface.start_menu
    case action
    when 1 then exit(0)
    when 2 then manage_station
    when 3 then manage_train
    when 4 then manage_route
    when 5 then manage_train_route
    else exit(0)
    end
  end

  private
  #################MANAGE STATION##############
  def manage_station
    action = @interface.station_menu
    case action
    when 1 then start
    when 2 then create_station
    when 3 then print_stations
    when 4 then delete_station
    else start
    end
    manage_station
  end

  def create_station
    @interface.create_station_title
    name = @interface.get_name
    station = Station.new(name)
    @user_stations << station
    puts "Станция #{@user_stations.last.name} создана"
  end

  def print_stations
    @user_stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  end

  def delete_station
    print_stations
    @interface.delete_station_number
    number = @interface.get_number
    @user_stations.delete_at(number)
  end

  ########################MANAGE TRAIN###########################

  def manage_train
    action = @interface.train_menu
    case action
    when 1 then start
    when 2 then create_train
    when 3 then print_trains
    when 4 then update_trains
    when 5 then delete_train
    else start
    end
    manage_train
  end

  def create_train
    @interface.create_train_title
    number = @interface.get_name
    action = @interface.train_type_menu
    case action
    when 1
      train = CargoTrain.new(number)
      @user_trains << train
      puts "Грузовой поезд No #{number} создан"
    when 2
      train = PassengerTrain.new(number)
      @user_trains << train
      puts "Пассажирский поезд No #{number} создан"
    else
      manage_train
    end
    manage_train
  end

  def update_trains
    @interface.update_train_title
    print_trains
    number = @interface.get_number
    action = @interface.wagon_menu
    case action
    when 2
      # Добавляем вагон с проверкой на тип
      wagon = @user_trains[number].type == :cargo ? CargoWagon.new : PassengerWagon.new
      @user_trains[number].add_wagon(wagon)
      puts 'Вагон добавлен'
    when 3
      @user_trains[number - 1].remove_wagon
      puts 'Вагон удален'
    else manage_train
    end
    manage_train
  end

  def print_trains(show_all_trains = true)
    @user_trains.each_with_index do |train, index|
      message = "#{index + 1}. Номер поезда #{train.number}, Тип поезда: #{train.type}, Количесво вагонов: #{train.wagons.size} "
      message += "Маршрут: #{train.route}" if train.route
      puts message if show_all_trains || train.route
    end
  end

  def delete_train
    print_trains
    @interface.delete_train_title
    number = @interface.get_number
    @user_trains.delete_at(number)
  end

  ########################MANAGE ROUTE###########################

  def manage_route
    action = @interface.route_menu

    case action
    when 1 then start
    when 2 then create_route
    when 3 then print_route
    when 4 then update_route
    when 5 then delete_route
    else start
    end
    manage_route
  end

  def create_route
    print_stations
    loop do
      @interface.create_first_station
      station_first = @interface.get_number
      @interface.create_last_station
      station_last = @interface.get_number
      # Проверяем что станция первая не ровна последней
      if station_first != station_last
        route = Route.new(@user_stations[station_first], @user_stations[station_last])
        @user_routes << route
        puts "Maршрут #{route.name} создан"
        break
      else
        puts 'Начальная и конечная станция должна отличаться'
      end
    end
  end

  def print_route
    @user_routes.each_with_index do |route, index|
      puts "#{index + 1}. Маршрут: #{route.name}"
    end
  end

  def update_route
    puts 'Выберите порядковый номер маршрута который хотите изменить'
    print_route
    number_route = @interface.get_number
    action = @interface.route_station_menu
    route = @user_routes[number_route]
    case action
    when 2
      print_stations
      loop do
        @interface.station_list
        number_station = @interface.get_number
        station = @user_stations[number_station]
        # Проверяем есть ли станция на маршруте, если нет то добавляем в маршрут
        if !route.stations.find { |current| current == station }
          route.add_station(station)
          puts "Маршрут #{route.name} обновлен"
          break
        else
          puts "Станция #{station.name} уже есть на маршруте"
        end
      end
    when 3
      # Удаляем станцию с маршрута
      route.print
      @interface.station_delete_list
      number_station = @interface.get_number
      station = @user_stations[number_station]
      route.delete_station(station)
      puts "Станция #{station.name} удалена"
    else manage_route
    end
    manage_route
  end

  def delete_route
    print_route
    route_delete_list
    number = @interface.get_number
    route = @user_routes[number]
    @user_routes.delete(route)
    puts "Маршрут #{route.name} удален"
  end

  ########################MANAGE TRAIN ROUTE###########################

  def manage_train_route
    action = @interface.train_route_menu

    case action
    when 1 then start
    when 2 then assign_route
    when 3 then train_movement
    else start
    end
    manage_train_route
  end

  def assign_route
    # Выбор поезда
    @interface.train_list
    print_trains
    number_train = @interface.get_number
    train = @user_trains[number_train]
    # Выбор маршрута
    @interface.route_list
    print_route
    number_route = @interface.get_number
    route = @user_routes[number_route]
    #Назначение поезду маршрута
    train.accept_route(route)
    puts train
    puts "Поезд № #{train.number}, маршрут #{route.name}"
  end

  def train_movement
    puts 'Выберите поезд с маршрутом'
    print_trains(false)
    number = @interface.get_number
    @interface.train_route
    train = @user_trains[number]
    puts "поезд находится на станции #{train.current_station.name}"

    action = @interface.train_move_menu
    case action
    when 2 then train.forward_train
    when 3 then train.backward_train
    else manage_train_route
    end
    puts "поезд находится на станции #{train.current_station.name}"
    manage_train_route
  end
end



Main.new(Interface.new).start







