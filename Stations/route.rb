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