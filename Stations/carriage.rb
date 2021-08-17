require_relative 'manufacturer.rb'

class Carriage
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerCarriage < Carriage
  attr_reader :occupied_seats

  def initialize(type, seats)
    super type
    @seats = seats
    @occupied_seats = 0
  end

  def occupy_seat
    @occupied_seats += 1
  end

  def return_free_seats
    @seats - @occupied_seats
  end
end

class CargoCarriage < Carriage
  attr_reader :loaded_capacity

  def initialize(type, capacity)
    super type
    @capacity = capacity
    @loaded_capacity = 0
  end

  def load_capacity(volume)
    @loaded_capacity += volume
  end

  def free_capacity
    @capacity - @loaded_capacity
  end
end