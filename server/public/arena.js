$(function(){
  function Arena(arena_selector, data){
    var $arena = $(arena_selector);
    $arena.canvas();

    // walls
    $.each(data.walls, function(i, wall){
      $arena
        .style({'strokeStyle': 'rgba( 255, 0, 0, 1)', 'fillStyle': 'rgba( 255, 0, 0, 1)', 'lineWidth': 2});
      
      for (var point = 0; point < wall.length-1; point++){
        $arena
          .beginPath()
          .moveTo( wall[point] )
          .lineTo( wall[point+1] )
          .closePath()
          .stroke();
        
      }
    });
    
    bots = $.grep(data['objects'], function(obj){
      return obj.type == 'Bot';
    });
    
    // bots
    $.each(bots, function(i, bot){
      $arena
        .beginPath()
        .moveTo( [bot.x, bot.y] )
        .arc(
          [bot.x, bot.y],
          {
            'radius': 10,
            'startAngle': bot.direction-15,
            'endAngle': bot.direction+15
          }
          )
        .lineTo( [bot.x, bot.y] )
        .closePath()
        .fill();
    });
    
    bullets = $.grep(data['objects'], function(obj){
      return obj.type == 'Bullet';
    });
    
    // bullets
    $.each(bullets, function(i, bullet){
      point0 = [bullet.x-2, bullet.y-2]; // FIXME: implement scaling of objects
      $arena
        .beginPath()
        .moveTo( point0 )
        .rect(
          point0,
          { 'width': 4, 'height': 4 }
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
  pollingTimer = setInterval(Polling, 3000);
});