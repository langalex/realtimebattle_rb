class ObjectInfo  
  attr_accessor :position, :direction, :health
  
  def initialize(x = 1, y = 1, direction = 0)
    self.position = [x, y]
    self.direction = direction
    self.health = 100
    @helper = GeometryHelper.new
  end
  
  def hit(damage)
    @health -= damage
  end
  
  def damage
    0
  end
  
  def dead?
    health <= 0
  end
  
  def speed
    1
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
  
  def move
    self.position = @helper.advance x, y, speed, direction
  end
  
  def stats
    {:health => health}
  end
end
