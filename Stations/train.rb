require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'

class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :trains_list
  attr_reader :number, :type, :current_speed, :current_station, :route, :cargo
  @@trains_list = []
  set_instance

  def initialize (number)
    @number = number
    @current_speed = 0
    @carriages = []
    @type = type
    create_instance
  end

  def self.find(searched_number)
    @@trains_list.find { |train| train.number == searched_number }
  end

  def add_train_to_list(train)
    @@trains_list << train
  end

  def increase_speed(value)
    @current_speed += value
  end

  def self.show_list
    @@trains_list
  end

  def self.instances_of_trains
    self.instances_count
  end

  def stop
    @current_speed = 0
  end

  def add_carriage(carriage)
    if carriage.type == @type
      if current_speed == 0
        @carriages << carriage
      else
        puts "Поезд движется!"
      end
    else
      puts 'Типы не совпадают'
    end
  end

  def put_away_carriage
    if @carriages.length != 0
      if current_speed == 0
        @carriages.pop
      else
        puts "Поезд движется!"
      end
    else
      puts 'У поезда нет вагонов!'
    end
  end

  def start_moving(route)
    @current_station = route.stations.first
    @current_station.get_train(self)
    @route = route
  end

  def move_forward(route)
    @current_station.send_train(self)
    @current_station = next_station(route)
    @current_station.get_train(self)
  end

  def move_backward(route)
    @current_station.send_train(self)
    @current_station = previous_station(route)
    @current_station.get_train(self)
  end

  def previous_station(route)
    if route.stations.index(@current_station) != 0
      route.stations[route.stations.index(@current_station) - 1]
    else
      puts 'Поезд на первой станции'
    end
  end

  def next_station(route)
    route.stations[route.stations.index(@current_station) + 1]
  end
end

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = 'passenger'
    add_train_to_list(self)
  end
end

class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = 'cargo'
    add_train_to_list(self)
  end
end