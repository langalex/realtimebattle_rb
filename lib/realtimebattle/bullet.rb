class Bullet
  def step(obstacle_type, obstacle_distance, obstacle=nil)
    obstacle_distance > speed ? :move : crash_action(obstacle_type, obstacle)
  end
  
  def speed
    2
  end
  
  def damage
    25
  end
  
  private
  
  def crash_action(obstacle_type, obstacle=nil)
    obstacle_type == :wall ? :impact : [:hit, obstacle]
  end
  
end
