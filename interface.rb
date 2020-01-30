class Interface

  def start_menu
    puts "Выберите пункт меню"
    puts"[1] Выход"
    puts"[2] Управление станциями\n"
    puts"[3] Управление поездом\n"
    puts"[4] Управление маршрутами\n"
    puts"[5] Управление движением поездов\n"

    gets.to_i
  end

########### STATION MENU ###########

  def station_menu
    puts "[1] Отмена"
    puts "[2] Создать станцию"
    puts "[3] Показать список станцию"
    puts "[4] Показать поезд на станции"
    puts "[5] Удалить станцию"

    gets.to_i
  end

  def create_station_title
    puts "Введите название станции"
  end

  def get_name
    gets.chomp
  end

  def delete_station_number
    puts 'Введите номер станции для удаления'
  end

  def get_number
    gets.to_i - 1
  end

  def train_menu
    puts "[1] Отмена"
    puts "[2] Создать поезд"
    puts "[3] Показать список поездов"
    puts "[4] Изменить поезд"
    puts "[5] Удалить поезд"

    gets.to_i
  end

  def create_train_title
    puts 'Введите номер поезда'
  end

  def train_list
    puts 'Выберите поезд из списка'
  end

  def update_train_title
    puts 'Выберите порядковый номер поезда для изменения'
  end

  def delete_train_title
    puts 'Введите порядковый номер поезда для удаления'
  end

  def train_type_menu
    puts '[1] Грузовой поезд'
    puts '[2] Пассажирский поезд'
    puts '[3] Отмена'

    gets.to_i
  end

  def wagon_menu
    puts "[1] Отмена"
    puts "[2] Добавить вагон"
    puts "[3] Загрузить вагон"
    puts "[4] Удалить вагон"

    gets.to_i
  end

  def route_menu
    puts "[1] Отмена"
    puts "[2] Создать маршрут"
    puts "[3] Показать маршрут"
    puts "[4] Изменить маршрут"
    puts "[5] Удалить маршрут"

    gets.to_i
  end

  def create_first_station
    puts 'Введите порядковый номер первой станции'
  end

  def create_last_station
    puts 'Введите порядковый номер конечной станции'
  end

  def update_station_route
    puts 'Выберите порядковый номер маршрута который хотите изменить'
  end

  def station_list
    puts 'Выберите станцию из списка'
  end

  def station_delete_list
    puts 'Выберите станцию которую хотите удалить'
  end

  def route_delete_list
    puts 'Выберите маршрут который хотите удалить'
  end

  def route_list
    puts 'Выберите маршрут из списка'
  end

  def train_route
    puts 'Выберите поезд с маршрутом'
  end

  def route_station_menu
    puts "[1] Отмена"
    puts "[2] Добавить промежуточную станцию"
    puts "[3] Удалить промежуточную станцию"

    gets.to_i
  end

  def train_route_menu
    puts "[1] Отмена"
    puts "[2] Назначить маршрут поезду"
    puts "[3] Перемещение поезда по маршруту"

    gets.to_i
  end

  def train_move_menu
    puts '[1] Отмена'
    puts '[2] Движение вперед по маршруту'
    puts '[3] Движение назад по маршруту'

    gets.to_i
  end
end
