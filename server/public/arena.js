$(function(){
  function Arena(arena_selector, data){
    var arena = $(arena_selector);
    arena.canvas();

    // walls
    var walls = $.grep(data['objects'], function(obj){
      return obj.type == 'WallElement';
    });
    
    $.each(walls, function(i, wall) {
      arena.beginPath()
        .moveTo([wall.x, wall.y])
        .rect([wall.x, wall.y], { 'width': 1, 'height': 1 }, {'fillStyle': 'rgba( 0, 0, 0, 1.0)'})
        .closePath()
        .fill();
    });
    
    var bots = $.grep(data['objects'], function(obj){
      return obj.type.substr(-3) == 'Bot';
    });
    
    // bots
    $.each(bots, function(i, bot){
      var color = Math.floor(255 / 100.0 * parseInt(bot.stats.health));
      arena
        .beginPath()
        .moveTo( [bot.x, bot.y] )
        .arc(
          [bot.x, bot.y],
          {
            'radius': 10,
            'startAngle': bot.direction-15,
            'endAngle': bot.direction+15
          },
          {'fillStyle': 'rgba(' + color + ',' + color + ',' + color + ', 1.0)'}
          )
        .lineTo( [bot.x, bot.y] )
        .closePath()
        .fill();
    });
    
    var bullets = $.grep(data['objects'], function(obj){
      return obj.type == 'Bullet';
    });
    
    // bullets
    $.each(bullets, function(i, bullet){
      point0 = [bullet.x-2, bullet.y-2]; // FIXME: implement scaling of objects
      arena
        .beginPath()
        .moveTo( point0 )
        .rect(
          point0,
          { 'width': 4, 'height': 4},
          {'fillStyle': 'rgba( 255, 0, 0, 1.0)'}
          )
        .closePath()
        .fill();
    });
  }
  
  function Polling(){
    $.getJSON('/arena', function(data){
      Arena('#arena', data);
    });
  }
  
  Polling();
  pollingTimer = setInterval(Polling, 200);
});