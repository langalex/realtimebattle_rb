
(function($) {
    
  // where can be 'under' (default), 'over', 'unshift', 'push' 
  $.fn.canvas = function( where) {   // reuse if where is not there
    //console.log( 'canvas, iterating DOM elements');
    $( this).each( function() {
      var $this = $( this);
      //console.log( 'canvas, working DOM element,', $this);
      
      var w = $this.width();
      var h = $this.height();
      //console.log( 'canvas, dimensions [w=' + w + ',h=' + h + ']');
      
      if ( ! where) where = 'under';
      //console.log( 'canvas, where to put is [' + where + ']');
      
      // first, remove all former canvas objects in this div
      $this.find( '.cnvsWrapper').remove();
      $this.find( '.cnvsCanvas').remove();
      var $canvas = $( '<canvas class="cnvsCanvas" style="position:absolute;top:0px;left:0px;width:100%;height:100%;" width="' + w + '" height="' + h + '"></canvas>');
      
      
      // if under or over, will have to wrap current contents
      if ( where == 'under' || where == 'over') { 
        $this.wrapInner( '<div class="cnvsWrapper" style="position:absolute;top:0px;left:0px;width:100%;height:100%;border:0px;padding:0px;margin:0px;"></div>');
      }
      if ( where == 'under' || where == 'unshift') {
        $this.prepend( $canvas);
      }
      if ( where == 'over' || where == 'push') {
        $this.append( $canvas);
      }
      
      // if in IE, initialize the canvas tag
      if ( $.browser.msie) {
        var canvas = G_vmlCanvasManager.initElement( $canvas.get( 0));
        $canvas = $(canvas);
      }
      
      this.cnvs = canvasObject( $canvas, w, h);
      return this;
    });
    return this;
  }
  $.fn.uncanvas = function() {
    $( this).each( function() {
      this.cnvs.getTag().remove();
      this.cnvs = null;
    });
    return this;
  }
  $.fn.hidecanvas = function() {
    $( this).each( function() {
      this.cnvs.getTag().hide();
    });
    return this;
  }
  $.fn.showcanvas = function() {
    $( this).each( function() {
      this.cnvs.getTag().show();
    });
    return this;
  }
  // call back with cnvs object, thus, allowing raw access
  $.fn.canvasraw = function( callback) {
    $( this).each( function() {
      if ( callback) eval( callback)( this.cnvs);
    });
  }
  // fills in the array with settings for each canvas
  // list( hash( 'width', 'height', 'tag' (jquery), 'context'))
  $.fn.canvasinfo = function( info) {
    $( this).each( function() {
      info[ info.length] = {};
      info[ info.length - 1].width = this.cnvs.w;
      info[ info.length - 1].height = this.cnvs.h;
      info[ info.length - 1].tag = this.cnvs.$tag;
      info[ info.length - 1].context = this.cnvs.c;
    });
  }
  
  // canvas operations (literaly the canvas functions)
  $.fn.style = function( style) {
    $( this).each( function() {
      this.cnvs.style( style);
      return this;
    });
    return this;
  }
  $.fn.beginPath = function() {
    $( this).each( function() {
      this.cnvs.beginPath();
      return this;
    });
    return this;
  }
  $.fn.closePath = function() {
    $( this).each( function() {
      this.cnvs.closePath();
      return this;
    });
    return this;
  }
  $.fn.stroke = function() {
    $( this).each( function() {
      this.cnvs.stroke();
      return this;
    });
    return this;
  }
  $.fn.fill = function() {
    $( this).each( function() {
      this.cnvs.fill();
      return this;
    });
    return this;
  }
  $.fn.moveTo = function( coord) {
    $( this).each( function() {
      this.cnvs.moveTo( coord);
      return this;
    });
    return this;
  }
  $.fn.arc = function( coord, settings, style) {
    $( this).each( function() {
      this.cnvs.arc( coord, settings, style);
      return this;
    });
    return this;
  }
  $.fn.arcTo = function( coord1, coord2, settings, style) {
    $( this).each( function() {
      this.cnvs.arcTo( coord1, coord2, settings, style);
      return this;
    });
    return this;
  }
  $.fn.bezierCurveTo = function( ref1, ref2, end, style) {
    $( this).each( function() {
      this.cnvs.bezierCurveTo( ref1, ref2, end, style); 
      return this;
    });
    return this;
  }
  $.fn.quadraticCurveTo = function( ref1, end, style) {
    $( this).each( function() {
      this.cnvs.quadraticCurveTo( ref1, end, style); 
      return this;
    });
    return this;
  }
  $.fn.clearRect = function( coord, settings) {
    $( this).each( function() {
      this.cnvs.clearRect( coord, settings); 
      return this;
    });
    return this;
  }
  $.fn.strokeRect = function( coord, settings, style) {
    $( this).each( function() {
      this.cnvs.fillRect( coord, settings, style); 
      return this;
    });
    return this;
  }
  $.fn.fillRect = function( coord, settings, style) {
    $( this).each( function() {
      this.cnvs.strokeRect( coord, settings, style); 
      return this;
    });
    return this;
  }
  $.fn.rect = function( coord, settings, style) {
    $( this).each( function() {
      this.cnvs.rect( coord, settings, style); 
      return this;
    });
    return this;
  }
  $.fn.lineTo = function( end, style) {
    $( this).each( function() {
      this.cnvs.lineTo( end, style); 
      return this;
    });
    return this;
  }
  
  // atomic operations
  $.fn.polygon = function( start, blocks, settings, style) {
    $( this).each( function() {
      this.cnvs.atomPolygon( start, blocks, settings, style);
    });
  }
  
  function canvasObject( $canvas, width, height) {
    var cnvs = {};
    cnvs.w = width;
    cnvs.h = height;
    cnvs.$tag = $canvas;
    cnvs.c = $canvas.get( 0).getContext( '2d');
    cnvs.laststyle = {    // default settings
      'fillStyle'          : 'rgba( 0, 0, 0, 0.2)',
      'strokeStyle'      : 'rgba( 0, 0, 0, 0.5)',
      'lineWidth'          : 5
    };
    
    // functions (all angles are in degrees)
    cnvs.getContext = function() { return this.c; }
    cnvs.getTag = function() { return this.$tag; }
    cnvs.deg2rad = function( deg) { 
      return 2 * 3.14159265 * ( deg / 360);
    }
    cnvs.style = function( style) {
      if ( style) this.laststyle = style;
      //console.log( 'cnvs.style, applying style,', this.laststyle);
      for ( var name in this.laststyle) this.c[ name] = this.laststyle[ name];
    }
    
    // raw canvas functions (see Apple reference)
    cnvs.beginPath = function() { this.c.beginPath(); }
    cnvs.closePath = function() { this.c.closePath(); }
    cnvs.stroke = function() { this.c.stroke(); }
    cnvs.fill = function() { this.c.fill(); }
    cnvs.moveTo = function( coord) { this.c.moveTo( coord[ 0], coord[ 1]); }
    cnvs.arc = function( coord, settings, style) { 
      // provide default settings
      settings = $.extend(
        {
          'radius'        : 50,
          'startAngle'    : 0,
          'endAngle'      : 360,
          'clockwise'    : true
        },
        settings
      );
      if ( style) this.style( style);
      this.c.arc( 
        coord[ 0], coord[ 1], settings.radius,
        this.deg2rad( settings.startAngle),
        this.deg2rad( settings.endAngle),
        settings.clockwise ? 1 : 0
      );
    }
    cnvs.arcTo = function( coord1, coord2, settings, style) { 
      // provide default settings
      settings = $.extend(
        {
          'radius'        : 50
        },
        settings
      );
      if ( style) this.style( style);
      this.c.arcTo(
        coord1[ 0], coord1[ 1], 
        coord2[ 0], coord2[ 1],
        settings.radius
      );
    }
    cnvs.bezierCurveTo = function( ref1, ref2, end, style) { 
      // provide default settings
      if ( style) this.style( style);
      this.c.bezierCurveTo(
        ref1[ 0], ref1[ 1],
        ref2[ 0], ref2[ 1],
        end[ 0], end[ 1]
      );
    }
    cnvs.quadraticCurveTo = function( ref1, end, style) { 
      // provide default settings
      if ( style) this.style( style);
      this.c.quadraticCurveTo(
        ref1[ 0], ref1[ 1],
        end[ 0], end[ 1]
      );
    }
    cnvs.clearRect = function( coord, settings, style) { 
      // provide default settings
      if ( ! coord) coord = [ 0, 0];
      settings = $.extend(
        {
          'width'      : this.w,
          'height'      : this.h
        },
        settings
      );
      this.c.clearRect(
        coord[ 0], coord[ 1], settings.width, settings.height
      );
    }
    cnvs.fillRect = function( coord, settings, style) { 
      // provide default settings
      settings = $.extend(
        {
          'width'      : 100,
          'height'      : 50
        },
        settings
      );
      if ( style) this.style( style);
      this.c.fillRect(
        coord[ 0], coord[ 1], settings.width, settings.height
      );
    }
    cnvs.strokeRect = function( coord, settings, style) { 
      // provide default settings
      settings = $.extend(
        {
          'width'      : 100,
          'height'      : 50
        },
        settings
      );
      if ( style) this.style( style);
      this.c.strokeRect(
        coord[ 0], coord[ 1], settings.width, settings.height
      );
    }
    cnvs.rect = function( coord, settings, style) { 
      // provide default settings
      settings = $.extend(
        {
          'width'      : 100,
          'height'      : 50
        },
        settings
      );
      if ( style) this.style( style);
      this.c.rect(
        coord[ 0], coord[ 1], settings.width, settings.height
      );
    }
    cnvs.lineTo = function( end, style) { 
      if ( style) this.style( style);
      this.c.lineTo( end[ 0], end[ 1]);
    }
    
    // extra (atomic) actions, fix some of canvas's shortcoming
    cnvs.path = function( blocks) {
      for ( var i = 0; i < blocks.length; i++) {
        var arg1 = null;
        var arg2 = null;
        var arg3 = null;
        var arg4 = null;
        if ( blocks[ i].length >= 2) arg1 = blocks[ i][ 1];
        if ( blocks[ i].length >= 3) arg2 = blocks[ i][ 2];
        if ( blocks[ i].length >= 4) arg3 = blocks[ i][ 3];
        if ( blocks[ i].length >= 5) arg4 = blocks[ i][ 4];
        if ( blocks[ i][ 0] == 'moveTo') this.moveTo( arg1);
        if ( blocks[ i][ 0] == 'arc') this.arc( arg1, arg2, arg3);
        if ( blocks[ i][ 0] == 'arcTo') this.arcTo( arg1, arg2, arg3, arg4);
        if ( blocks[ i][ 0] == 'bezierCurveTo') this.bezierCurveTo( arg1, arg2, arg3, arg4);
        if ( blocks[ i][ 0] == 'quadraticCurveTo') this.quadraticCurveTo( arg1, arg2, arg3);
        if ( blocks[ i][ 0] == 'lineTo') this.lineTo( arg1, arg2);
      }
    }
    cnvs.atomPolygon = function( start, blocks, settings, style) {
      settings = $.extend(
        {
          'fill'          : false,
          'stroke'      : true,
          'close'      : false
        },
        settings
      );
      this.style( style);
      if ( settings.stroke) {    // fill first
        this.beginPath();
        this.moveTo( start);
        this.path( blocks);
        if ( settings.close) {
          this.moveTo( start);
          this.closePath();
        }
        this.c.fillStyle = 'rgba( 0, 0, 0, 0)';
        this.stroke();
      }
      this.style( style);
      if ( settings.fill) {    // fill first
        this.beginPath();
        this.moveTo( start);
        this.path( blocks);
        if ( settings.close) {
          this.moveTo( start);
          this.closePath();
        }
        this.c.strokeStyle = 'rgba( 0, 0, 0, 0)';
        this.fill();
      }
      this.style( style);
    }
    
    return cnvs;
  }
  
})( jQuery)