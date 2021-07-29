require_relative 'train.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'carriage.rb'

stations_list = []
trains_list = []
routes = []

def choose_train(trains_list)
  puts 'Выберите поезд'
  trains_list.each_with_index { |train, index| puts "#{index + 1}: #{train.number}" }
  train_index = gets.to_i - 1
  return train_index
end

def choose_carriage_type
  puts 'Введите тип вагона (cargo, passenger)'
  carriage_type = gets.chomp
  return carriage_type
end

def choose_root(routes)
  puts 'Выберите маршрут:'
  routes.each_with_index { |route, index| puts "#{index + 1}: #{route.stations}" }
  route_index = gets.to_i - 1  
  return route_index
end

def choose_station(stations_list)
  puts 'Выберите станцию'
  stations_list.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
  chosen_station = stations_list[gets.to_i - 1]
  return chosen_station
end

loop do
  puts 'Введите 1, чтобы создать станцию
  Введите 2, чтобы создать поезд
  Введите 3, чтобы создать маршрут
  Введите 4, чтобы управлять маршрутом
  Введите 5, чтобы назначить маршрут
  Введите 6, чтобы прицепить вагон к поезду
  Введите 7, чтобы отцепить вагон
  Введите 8, чтобы переместить поезд по маршруту
  Введите 9, чтобы просмотреть список станций и вывести список поездов
  Введите 0, чтобы выйти'
  choice = gets.to_i

  if choice == 0
    break
  elsif choice == 1
    puts 'Введите название станции'
    station_name = gets.chomp
    stations_list << Station.new(station_name)
  elsif choice == 2
    puts 'Введите номер поезда'
    train_number = gets.to_i
    puts 'Введите тип поезда (cargo, passenger)'
    train_type = gets.chomp
    if train_type == 'cargo'
      trains_list << CargoTrain.new(train_number)
    elsif train_type == 'passenger'
      trains_list << PassengerTrain.new(train_number)
    else
      puts 'Такого типа не существует'
    end
  elsif choice == 3
    puts 'Начальная точка'
    first_point = choose_station(stations_list)
    puts 'Введите конечную точку маршрута'
    second_point = choose_station(stations_list)
    routes << Route.new(first_point, second_point)
  elsif choice == 4
    route_index = choose_root(routes)
    puts 'Введите 1 чтобы добавить станцию
    Введите 2 чтобы убрать станцию'
    choice_root = gets.to_i
    if choice_root == 1
      added_station = choose_station(stations_list).name
      routes[route_index].add_stop_point(added_station)
    elsif choice_root == 2
      deleted_station = choose_station(stations_list).name
      routes[route_index].delete_stop_point(deleted_station)
    end
  elsif choice == 5
    train_index = choose_train(trains_list)
    route_index = choose_root(routes)
    trains_list[train_index].start_moving(routes[route_index])
  elsif choice == 6
    train_index = choose_train(trains_list)
    carriage_type = choose_carriage_type
    new_carr = Carriage.new(carriage_type)
    trains_list[train_index].add_carriage(new_carr)
  elsif choice == 7
    train_index = choose_train(trains_list)
    trains_list[train_index].put_away_carriage
  elsif choice == 8
    train_index = choose_train(trains_list)
    puts 'Введите 1 чтобы переместить поезд вперед
    Введите 2 чтобы переместить поезд назад'
    move_choice = gets.to_i
    if move_choice == 1
      trains_list[train_index].move_forward(trains_list[train_index].route)
    elsif move_choice == 2
      trains_list[train_index].move_backward(trains_list[train_index].route)
    end
  elsif choice == 9
    puts 'Выберите станцию'
    chosen_station = choose_station(stations_list).trains
    puts chosen_station
  end
end