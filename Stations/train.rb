require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :trains_list
  attr_reader :number, :type, :current_speed, :current_station, :route, :cargo, :carriages

  @@trains_list = []
  NUMBER_FORMAT = /^[а-яa-z\d]{3}-?[а-яa-z\d]{2}/i

  def initialize(number)
    @number = number.to_s
    @current_speed = 0
    @carriages = []
    @type = type
    create_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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
    instances_count
  end

  def stop
    @current_speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if current_speed.zero?
  end

  def put_away_carriage
    @carriages.pop if !@carriages.empty? && current_speed.zero?
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

  def return_carriage(&block)
    @carriages.each do |carriage|
      block.call(carriage)
    end
  end

  protected

  def validate!
    raise 'Номер не соответствует формату' if number !~ NUMBER_FORMAT
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
