class Bullet
  def step(contact_type, contact_distance)
    contact_distance > speed ? :move : :impact
  end
  
  def speed
    2
  end
end
