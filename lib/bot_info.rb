class BotInfo
  attr_accessor :position, :direction
  
  
  def initialize
    self.position = [1,1]
    self.direction = 0
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