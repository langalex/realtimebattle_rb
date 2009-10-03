class Arena
  def initialize(bots, width, height)
    @bots = bots.inject({}) do |hash, bot|
      hash[bot] = BotInfo.new
      hash
    end
    @helper = GeometryHelper.new
    @wall_elements = initialize_wall(width, height)
  end
  
  def step
    @bots.keys.each do |bot|
      action = bot.step contact_type(bot), contact_distance(bot)
      perform_action bot, action
    end
  end
  
  def info_for(bot)
    @bots[bot]
  end
  
  private
  
  def initialize_wall(width, height)
    elements = []
    (0..width-1).each do |x|
      elements << [x,0] << [x, height-1]
    end
    (0..height-1).each do |y|
      elements << [0,y] << [width-1, y]
    end
    elements
  end
  
  def contact_distance(bot)
    step = 1
    begin
      new_x, new_y = @helper.advance info_for(bot).x, info_for(bot).y, step, info_for(bot).direction
      step += 1
    end while !wall?(new_x, new_y)
    distance_between(new_x - info_for(bot).x, new_y - info_for(bot).y)
  end
  
  def distance_between(delta_x, delta_y)
    Math.sqrt((delta_x * delta_x) + (delta_y * delta_y))
  end
  
  def contact_type(bot)
    :wall
  end
  
  def wall?(x, y)
    @wall_elements.find{|wall| wall == [x, y]}
  end
  
  def perform_action(bot, action)
    bot_info = @bots[bot]
    case action.first
    when :rotate
      bot_info.rotate action[1]
    when :move
      bot_info.move 1 unless wall?(*@helper.advance(bot_info.x, bot_info.y, 1, bot_info.direction))
    when :shoot
    end
  end
  
end