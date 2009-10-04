class BulletInfo < ObjectInfo
  
  def hit(damage)
    @dead = true
  end
  
  def damage
    25
  end
  
  def dead?
    @dead
  end
  
  def speed
    2
  end

end