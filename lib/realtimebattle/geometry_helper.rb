class GeometryHelper
  def advance(x, y, distance, direction)
    [x + Math.cos(to_rad(direction)) * distance, y + Math.sin(to_rad(direction)) * distance].map{|x| x.round}
  end
  
  def distance_between(delta_x, delta_y)
    Math.sqrt((delta_x * delta_x) + (delta_y * delta_y))
  end
  
  
  private
  
  def to_rad(degree)
    degree * Math::PI/180
  end
end