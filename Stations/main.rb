require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'instance_counter'
require_relative 'manufacturer'

# rubocop:disable Metrics/ClassLength
class Controller
  def initialize
    @stations_list = []
    @routes = []
  end

  def choose_train(trains_list)
    puts 'Выберите поезд'
    trains_list.each_with_index { |train, index| puts "#{index + 1}: #{train.number}" }
    gets.to_i - 1
  end

  def choose_carriage_type
    puts 'Введите тип вагона (cargo, passenger)'
    gets.chomp
  end

  def choose_root(routes)
    puts 'Выберите маршрут:'
    routes.each_with_index { |route, index| puts "#{index + 1}: #{route.stations}" }
    gets.to_i - 1
  end

  def choose_station(stations_list)
    puts 'Выберите станцию'
    stations_list.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
    stations_list[gets.to_i - 1]
  end

  # rubocop:disable Layout/LineLength
  def retrun_carriage_list(train)
    carriage_index = 0
    train.return_carriage do |carriage|
      if carriage.type == 'passenger'
        puts "#{carriage_index + 1}: #{carriage.type}, #{carriage.occupied_seats} занято, #{carriage.return_free_seats} свободно"
      end
      if carriage.type == 'cargo'
        puts "#{carriage_index + 1}: #{carriage.type}, #{carriage.loaded_capacity} занято, #{carriage.free_capacity} свободно"
      end
      carriage_index += 1
    end
  end
  # rubocop:enable Layout/LineLength

  def stations_trains_list
    @stations_list.each do |station|
      puts "#{station.name}:"
      station.return_trains do |train|
        puts "#{train.number} - #{train.type}, #{train.carriages.length}"
        retrun_carriage_list(train)
      end
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength
  def menu
    loop do
      # rubocop:disable Layout/LineLength
      puts "Введите 1, чтобы создать станцию\nВведите 2, чтобы создать поезд\nВведите 3, чтобы создать маршрут\nВведите 4, чтобы управлять маршрутом"
      puts "Введите 5, чтобы назначить маршрут\nВведите 6, чтобы прицепить вагон к поезду\nВведите 7, чтобы отцепить вагон\nВведите 8, чтобы переместить поезд по маршруту"
      puts "Введите 9, чтобы просмотреть список станций и вывести список поездов\nВведите 10, чтобы занять место или объем в вагоне\nВведите 0, чтобы выйти"
      # rubocop:enable Layout/LineLength
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        new_station
      when 2
        new_train
      when 3
        new_route
      when 4
        control_route
      when 5
        set_route
      when 6
        add_carriage_to_train
      when 7
        set_off_carriage
      when 8
        move_train
      when 9
        stations_trains_list
      when 10
        load_capacity
      else
        puts 'Такой команды нет'
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/BlockLength

  protected

  # restricting access to writing data outside from menu

  def new_station
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations_list << Station.new(station_name)
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def new_train
    puts 'Введите номер поезда'
    train_number = gets.to_i
    puts 'Введите тип поезда (cargo, passenger)'
    train_type = gets.chomp
    case train_type
    when 'cargo'
      CargoTrain.new(train_number)
    when 'passenger'
      PassengerTrain.new(train_number)
    else
      puts 'Такого типа не существует'
    end
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def new_route
    puts 'Начальная точка'
    first_point = choose_station(@stations_list)
    puts 'Введите конечную точку маршрута'
    second_point = choose_station(@stations_list)
    @routes << Route.new(first_point, second_point)
  rescue RuntimeError => e
    puts e.inspect
    retry
  end

  def control_route
    route_index = choose_root(@routes)
    puts 'Введите 1 чтобы добавить станцию
    Введите 2 чтобы убрать станцию'
    choice_root = gets.to_i
    case choice_root
    when 1
      added_station = Station.new(choose_station(@stations_list).name)
      @routes[route_index].add_stop_point(added_station)
    when 2
      deleted_station = choose_station(@stations_list).name
      @routes[route_index].delete_stop_point(deleted_station)
    end
  end

  def set_route
    train_index = choose_train(Train.show_list)
    route_index = choose_root(@routes)
    Train.show_list[train_index].start_moving(@routes[route_index])
  end

  def add_carriage_to_train
    train_index = choose_train(Train.show_list)
    carriage_type = choose_carriage_type
    puts 'Укажите вместимость вагона'
    capacity = gets.to_i
    case capacity
    when 'cargo'
      new_carr = CargoCarriage.new(carriage_type, capacity)
    when 'passenger'
      new_carr = PassengerCarriage.new(carriage_type, capacity)
    end
    Train.show_list[train_index].add_carriage(new_carr)
  end

  def set_off_carriage
    train_index = choose_train(Train.show_list)
    Train.show_list[train_index].put_away_carriage
  end

  # rubocop:disable Metrics/AbcSize
  def load_capacity
    train_index = choose_train(Train.show_list)
    retrun_carriage_list(Train.show_list[train_index])
    carriage_index = gets.to_i - 1
    chosen_carriage = Train.show_list[train_index].carriages[carriage_index]
    case chosen_carriage.type
    when 'cargo'
      puts 'Укажите значение'
      value_choice = gets.to_i
      chosen_carriage.load_capacity(value_choice)
    when 'passenger'
      chosen_carriage.occupy_seat
    end
  end

  def move_train
    train_index = choose_train(Train.show_list)
    puts 'Введите 1 чтобы переместить поезд вперед
    Введите 2 чтобы переместить поезд назад'
    move_choice = gets.to_i
    case move_choice
    when move_choice == 1
      Train.show_list[train_index].move_forward(Train.show_list[train_index].route)
    when move_choice == 2
      Train.show_list[train_index].move_backward(Train.show_list[train_index].route)
    end
  end
end
# rubocop:enable Metrics/ClassLength, Metrics/AbcSize

controller = Controller.new
controller.menu
