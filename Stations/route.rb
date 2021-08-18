require_relative 'instance_counter'

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
  rescue StandardError
    false
  end

  def add_stop_point(point)
    @stations.insert(-2, point)
  end

  def delete_stop_point(point)
    @stations.delete(point)
  end

  protected

  def validate!
    return unless starting_point == finishing_point
      raise 'Нельзя указать одну и ту же станцию в качестве стартовой и конечной точки'
  end
end
