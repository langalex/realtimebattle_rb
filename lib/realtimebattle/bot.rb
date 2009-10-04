class Bot
  attr_reader :health
  
  def initialize
    @step = 0
    @health = 100
  end
  
  def hit(damage)
    @health -= damage
  end
  
  def dead?
    health <= 0
  end
  
  # possible return value:
  # :move
  # [:rotate, degrees] # degrees must be 0..360
  # :shoot
  def step(contact_type, contact_distance)
    @step += 1
    if @step % 5 == 0
      [:rotate, 90]
    elsif @step % 3 == 0
      :shoot
    else
      :move
    end
  end
  
  def speed
    1
  end
  
  def stats
    {:health => health}
  end
end