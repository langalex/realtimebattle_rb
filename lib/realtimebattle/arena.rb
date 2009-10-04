class Arena
  def initialize(objects, width, height)
    @objects = objects.inject({}) do |hash, object|
      hash[object] = PositionInfo.new
      hash
    end
    
    @width, @height = width, height
    @helper         = GeometryHelper.new
    @wall_elements  = initialize_wall(width, height)
  end
  
  def step
    @objects.keys.each do |object|
      obstacle = next_obstacle(object)
      step_arguments = [obstacle_type(obstacle), distance_to_obstacle(obstacle, object)]
      step_arguments << obstacle if object.is_a?(Bullet)
      action = object.step *step_arguments
      perform_action object, action
    end
  end
  
  def position_for(object)
    @objects[object]
  end
  
  def objects
    @objects.keys
  end
  
  def object_at(x, y)
    objects.select { |object|
      position_for(object).x == x && position_for(object).y == y
    }.first
  end
  
  def next_obstacle(object)
    step = 1
    begin
      info = position_for(object)
      new_x, new_y = @helper.advance(
        info.x, info.y, step, info.direction
      )
      step += 1
      if obstacle = object_at(new_x, new_y)
        return obstacle
      end
    end until wall?(new_x, new_y)
    :wall
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
  
  def distance_to_wall(object)
    step = 1
    begin
      info = position_for(object)
      new_x, new_y = @helper.advance(
        info.x, info.y, step, info.direction
      )
      step += 1
      return 0 if out_of_bounds?(new_x, new_y)
    end while !wall?(new_x, new_y)
    distance_between(new_x - position_for(object).x, new_y - position_for(object).y)
  end
  
  def distance_between(delta_x, delta_y)
    Math.sqrt((delta_x * delta_x) + (delta_y * delta_y))
  end
  
  def distance_to_obstacle(obstacle, object)
    return distance_to_wall(object) if obstacle == :wall
    distance_between(position_for(obstacle).x - position_for(object).x, position_for(obstacle).y - position_for(object).y)
  end
  
  def obstacle_type(obstacle)
    obstacle.is_a?(Symbol) ? obstacle : obstacle.class.name.downcase.to_sym
  end
  
  def wall?(x, y)
    @wall_elements.find { |wall| wall == [x, y] }
  end
  
  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x > @width || y > @height
  end
  
  def perform_action(object, action)
    info = @objects[object]
    
    case Array(action).first
    when :rotate
      info.rotate action[1]
    when :move
      new_x, new_y = @helper.advance(info.x, info.y, object.speed, info.direction)
      info.move object.speed unless wall?(new_x, new_y)
    when :shoot
      bullet_info = PositionInfo.new(info.x, info.y, info.direction)
      @objects[Bullet.new] = bullet_info
    when :impact
      @objects.delete object
    when :hit
      action[1].hit object.damage
      @objects.delete object
    end
  end
end