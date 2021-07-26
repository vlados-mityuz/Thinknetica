class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def train_type(type)
    @trains.select{ |train| type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(starting_point, finishing_point)
    @stations = [starting_point, finishing_point]
  end

  def add_stop_point(point)
    @stations.insert(-2, point)
  end

  def delete_stop_point(point)
    @stations.delete(point)
  end
end

class Train
  attr_reader :number, :type, :carriage, :current_speed, :current_station, :route

  def initialize (number, type, carriage)
    @number = number
    @type = type
    @carriage = carriage
    @current_speed = 0
  end

  def increase_speed(value)
    @current_speed += value
  end

  def stop
    @current_speed = 0
  end

  def add_carriage
    if current_speed == 0
      @carriage += 1
    elsif
      puts "Поезд движется!"
    end
  end

  def put_away_carriage
    if current_speed == 0
      @carriage -= 1
    elsif
      puts "Поезд движется!"
    end
  end

  def start_moving(route)
    @current_station = route.stations.first
  end

  def move_forward(route)
    @current_station = route.stations[route.stations.index(@current_station) + 1]
  end

  def move_backward(route)
    @current_station = route.stations[route.stations.index(@current_station) - 1]
  end

  def previous_station(route)
    route.stations[route.stations.index(@current_station) - 1]
  end

  def next_station(route)
    route.stations[route.stations.index(@current_station) + 1]
  end
end