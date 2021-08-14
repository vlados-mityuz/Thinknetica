require_relative 'instance_counter.rb'

class Route
  include InstanceCounter
  attr_accessor :starting_point, :finishing_point
  attr_reader :stations

  def initialize(starting_point, finishing_point)
    @starting_point = starting_point
    @finishing_point = finishing_point
    @stations = [@starting_point, @finishing_point]
    validate!
    create_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_stop_point(point)
    @stations.insert(-2, point)
  end

  def delete_stop_point(point)
    @stations.delete(point)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Нельзя указать одну и ту же станцию в качестве стартовой и конечной точки" if starting_point == finishing_point 
  end
end