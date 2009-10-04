class Bot
  
  def initialize
    @step = 0
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
  
end