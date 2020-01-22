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

  def station_menu
    puts "[1] Отмена"
    puts "[2] Создать станцию"
    puts "[3] Показать список станцию"
    puts "[4] Удалить станцию"

    gets.to_i
  end

  def train_menu
    puts "[1] Отмена"
    puts "[2] Создать поезд"
    puts "[3] Показать список поездов"
    puts "[4] Изменить поезд"
    puts "[5] Удалить поезд"

    gets.to_i
  end

  def wagon_menu
    puts "[1] Отмена"
    puts "[2] Добавить вагон"
    puts "[3] Удалить вагон"

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

end
