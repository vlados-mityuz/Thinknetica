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
    @trains.select{ |train|.type == type }
  end
end

class Route
  attr_reader :route

  def initialize(starting_point, finishing_point)
    @route = [starting_point, finishing_point]
  end

  def add_stop_point(point)
    @route.insert(-2, point)
  end

  def delete_stop_point(point)
    @route.delete(point)
  end
end

class Train
  attr_reader :number, :type, :carriage, :current_speed, :current_station

  def initialize(number, type, carriage)
    @number = number
    @type = type
    @carriage = carriage
    @current_speed = 0
    @train_route = []
    @current_route = []
    @current_station = ""
    @previous_station = @current_route[@train_route.length -1]
    @next_station = @current_route[@train_route.length + 1]
  end

  def increase_speed(value)
    @current_speed += value
  end

  def stop
    @current_speed = 0
  end

  def add_carriage
    if @current_speed == 0
      @carriage += 1
    else
      puts "Вагон движется!"
    end
  end

  def put_away_carriage
    if @current_speed == 0
      @carriage -= 1
    else
      puts "Вагон движется!"
    end
  end

  def start_moving(route)
    @train_route << route(0)
  end

  def get_route(route)
    @current_route = route
  end

  def move_forward
    @train_route << @current_route[@train_route.length + 1]
  end

  def move_backward
    if @train_route.length > 0
      @train_route.pop
    end
  end
end