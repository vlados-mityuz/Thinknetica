require_relative 'instance_counter.rb'

class Route
  include InstanceCounter
  attr_reader :stations
  set_instance

  def initialize(starting_point, finishing_point)
    @stations = [starting_point, finishing_point]
    create_instance
  end

  def add_stop_point(point)
    @stations.insert(-2, point)
  end

  def delete_stop_point(point)
    @stations.delete(point)
  end
end