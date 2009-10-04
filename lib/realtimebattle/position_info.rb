class PositionInfo
  attr_accessor :position, :direction
  
  def initialize(x = 1, y = 1, direction = 0)
    self.position = [x, y]
    self.direction = direction
    @helper = GeometryHelper.new
  end
  
  def x
    position[0]
  end
  
  def y
    position[1]
  end
  
  def rotate(angle)
    self.direction = (direction + angle)
    self.direction -= 360 if direction > 180
    self.direction += 360 if direction < -180
  end
  
  def move(distance)
    self.position = @helper.advance x, y, distance, direction
  end
end
