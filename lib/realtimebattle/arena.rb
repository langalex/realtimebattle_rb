class Arena
  def initialize(objects, width, height)
    @objects = {}
    @position_index = {}
    
    objects.each do |object|
      add_object object
    end

    initialize_wall(width, height).each do |wall|
      add_object wall, WallInfo.new(wall.x, wall.y)
    end
    
    @width, @height = width, height
    @helper         = GeometryHelper.new
  end
  
  def step
    objects.each do |object|
      contact, distance = find_contact object
      action = object.step contact_type(contact), distance
      perform_action object, action
      if info_for(object).dead?
        remove_object(object)
        next 
      end
    end
  end
  
  def info_for(object)
    @objects[object]
  end
  
  def objects
    @objects.keys
  end
  
  def add_object(object, info = nil)
    actual_info = info || ObjectInfo.new
    @position_index[[actual_info.x, actual_info.y]] = object
    @objects[object] = actual_info
  end
  
  private

  def remove_object(object)
    info = info_for(object)
    @position_index.delete([info.x, info.y])
    @objects.delete(object)
  end
  
  def move_object(object)
    info = info_for(object)
    @position_index.delete([info.x, info.y])
    info.move
    @position_index[[info.x, info.y]] = object
  end
  
  def collides_with(object)
    objects.find{|opponent| opponent != object && info_for(object).position == info_for(opponent).position} # XXX slow?
  end
  
  def initialize_wall(width, height)
    elements = []
    (0..width-1).each do |x|
      elements << WallElement.new(x, 0) << WallElement.new(x, height-1)
    end
    (1..height-2).each do |y|
      elements << WallElement.new(0, y) << WallElement.new(width-1, y)
    end
    elements
  end
  
  def contact_coordinates(object)
    step = 1
    begin
      info = info_for(object)
      new_x, new_y = @helper.advance(
        info.x, info.y, step, info.direction
      )
      step += 1
      return nil if out_of_bounds?(new_x, new_y)
    end while !object?(new_x, new_y)
    [new_x, new_y]
  end
  
  def contact_distance(object, x, y)
    @helper.distance_between(x - info_for(object).x, y - info_for(object).y)
  end
  
  def find_contact(object)
    coordinates = contact_coordinates object
    if coordinates
      [object_at(*coordinates), contact_distance(object, *coordinates)]
    end
  end
  
  def contact_type(object)
    object.class.name.downcase.to_sym
  end
  
  def object?(x, y)
    object_at x, y
  end
  
  def object_at(x, y)
    @position_index[[x, y]]
  end
  
  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x > @width || y > @height
  end
  
  def perform_action(object, action)
    info = info_for(object)
    case Array(action).first
    when :rotate
      info.rotate action[1]
    when :move
      info.speed.times do
        new_x, new_y = @helper.advance(info.x, info.y, 1, info.direction)
        unless object?(new_x, new_y)
          move_object object
        else
          opponent_info = info_for(object_at(new_x, new_y))
          info.hit(opponent_info.damage)
          opponent_info.hit(info.damage)
          return
        end
      end
    when :shoot
      bullet_info = BulletInfo.new(info.x, info.y, info.direction)
      add_object Bullet.new, bullet_info
    end
  end
end