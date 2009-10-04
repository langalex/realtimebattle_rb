class Arena
  def initialize(objects, width, height)
    @objects = objects.inject({}) do |hash, object|
      hash[object] = ObjectInfo.new
      hash
    end
    
    @width, @height = width, height
    @helper         = GeometryHelper.new
    @wall_elements  = initialize_wall(width, height)
  end
  
  def step
    @objects.keys.each do |object|
      action = object.step contact_type(object), contact_distance(object)
      perform_action object, action
    end
  end
  
  def info_for(object)
    @objects[object]
  end
  
  def objects
    @objects.keys
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
  
  def contact_distance(object)
    step = 1
    begin
      info = info_for(object)
      new_x, new_y = @helper.advance(
        info.x, info.y, step, info.direction
      )
      step += 1
      return 0 if out_of_bounds?(new_x, new_y)
    end while !wall?(new_x, new_y)
    distance_between(new_x - info_for(object).x, new_y - info_for(object).y)
  end
  
  def distance_between(delta_x, delta_y)
    Math.sqrt((delta_x * delta_x) + (delta_y * delta_y))
  end
  
  def contact_type(object)
    :wall
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
      bullet_info = ObjectInfo.new(info.x, info.y, info.direction)
      @objects[Bullet.new] = bullet_info
    when :impact
      @objects.delete object
    end
  end
end