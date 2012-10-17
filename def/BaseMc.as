package def
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class BaseMc extends MovieClip
	{
		public static var objects :Array;
		
		var listeners	:Array;
		var destructors :Array;
		
		var _avel :Point;
		var _last :Point;
		var _pos  :Point;
		
		var key = Main.key;
		
		
		public function get avelx() { return _avel.x; }
		public function get avely() { return _avel.y; }
		public function get lastx() { return _last.x; }
		public function get lasty() { return _last.y; }
		public function get avel()	{ return _avel;  }
		public function get last()	{ return _last;  }
		public function get pos()	{ return _pos;   }
		
		
		public function set avelx(n :Number) { _avel.x = n; }
		public function set avely(n :Number) { _avel.y = n; }
		
		public function set avel(p :Point)	 { _avel.x = p.x; _avel.y = p.y;		}
		public function set pos(p :Point)	 { _pos.x = x = p.x; _pos.y = y = p.y;	}
		
		public function set display(f :Function)	{ listeners.push(f);	}
		public function set destructor(f :Function) { destructors.push(f);	}
		
		
		public function BaseMc(defParent :MovieClip = null,posx :Number = 0, posy :Number = 0,callback :Function = null)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			
			listeners =		new Array();
			destructors =	new Array();
			listeners.push(BaseMc_display);
			destructors.push(BaseMc_destructor);
			
			
			if(defParent) defParent.addChild(this);
			
			x = posx;
			y = posy;
			_avel = new Point(0,0);
			_last = new Point(x,y);
			_pos =  new Point(x,y);
			
			
			addEventListener(Event.ENTER_FRAME,_display);
			
			fadeOn = moveOn = false;
			
			if(callback != null) callback();
		}
		
		function BaseMc_display()
		{
			_last.x = x;
			_last.y = y;
			
			x += _avel.x*Main.TIME;
			y += _avel.y*Main.TIME;
			
			_pos.x = x;
			_pos.y = y;
		}
		function _display(e :Event)
		{
			for(var i=listeners.length-1; i>=0; i--)
				listeners[i]();
		}
		function BaseMc_destructor()
		{
			Utils.removeObject(this,objects);
			removeEventListener(Event.ENTER_FRAME,_display);
			if(parent)	parent.removeChild(this);
			this.stop();
			delete this;
		}
		public function kill()
		{
			for(var i=destructors.length-1; i>=0; i--)
				destructors[i]();
		}
		
		
		/***********************/
		
			// ANIMATION
		
		
		var fadeOn		 :Boolean;
		var fadeOffset	 :Number;
		var fadeFlag	 :Number;
		var fadeCallback :Function;
		
			public function fade(offset		:Number = -0.05,
								 flag		:Number = 0,
								 callback	:Function = null)
			{
				if(!fadeOn && offset != 0 &&
				   (offset > 0 && flag > alpha) ||
				   (offset < 0 && flag < alpha))
				{
					fadeOn = 		true;
					fadeOffset = 	offset;
					fadeFlag = 		flag;
					fadeCallback = 	callback;
					addEventListener(Event.ENTER_FRAME,fadeLst);
				}
			}
			function fadeLst(e :Event)
			{
				alpha += fadeOffset;
				if((fadeOffset < 0 && alpha <= fadeFlag) ||
				   (fadeOffset > 0 && alpha >= fadeFlag))
				{
					fadeOn = false;
					alpha = fadeFlag;
					removeEventListener(Event.ENTER_FRAME,fadeLst);
					if(fadeCallback != null) fadeCallback();
				}
			}
		
		
		// --
		
		var moveOn 		 :Boolean;
		var movePoint 	 :Point;
		var moveEasy 	 :Number;
		var moveCallback :Function;
		
			public function move(point 		:Point = null,
								 easy 		:Number = 0.5,
								 callback 	:Function = null)
			{
				if(!moveOn && easy != 0)
				{
					if(!point) point = new Point(0,0);
					moveOn = 		true;
					movePoint = 	point;
					moveEasy = 		easy;
					moveCallback =  callback;
					addEventListener(Event.ENTER_FRAME,moveLst);
				}
			}
			function moveLst(e :Event)
			{
				x += Utils.difFactor(movePoint.x,x,moveEasy);
				y += Utils.difFactor(movePoint.y,y,moveEasy);
				if(Utils.dist(pos,movePoint) <= 1)
				{
					moveOn = false;
					x = movePoint.x;
					y = movePoint.y;
					removeEventListener(Event.ENTER_FRAME,moveLst);
					if(moveCallback != null) moveCallback();
				}
			}
		
		
		// --
		var resizeOn		:Boolean;
		var resizeSize		:Point;
		var resizeEasy		:Number;
		var resizeCallback  :Function;
		
			public function resize(W		:Number = 100,
								   H		:Number = 100,
								   easy		:Number = 0.5,
								   callback :Function = null)
			{
				if(!resizeOn)
				{
					resizeOn = 		true;
					resizeSize =	new Point(W,H);
					resizeEasy = 	easy;
					resizeCallback = callback;
					addEventListener(Event.ENTER_FRAME,resizeLst);
				}
				
			}
			function resizeLst(e :Event)
			{
				width +=  Utils.difFactor(resizeSize.x,width,resizeEasy);
				height += Utils.difFactor(resizeSize.y,height,resizeEasy);
				if(Utils.dist(new Point(width,height),resizeSize) <= 1)
				{
					resizeOn = false;
					width =  resizeSize.x;
					height = resizeSize.y;
					removeEventListener(Event.ENTER_FRAME,resizeLst);
					if(resizeCallback != null) resizeCallback();
				}
				
			}
			
		// --
		
		var blinkColor		:uint;
		var blinkAlpha		:Number;
		var blinkFadeCoef	:Number;
		var blinkCallback	:Function;
		
			public function blink(color 	:uint = 0xffffff,
								  alphaVal	:Number = 1,
								  fadeCoef	:Number = -0.1,
								  callback	:Function = null)
			{
				if(fadeCoef < 0)
				{
					blinkColor =	color;
					blinkAlpha =	alphaVal;
					blinkFadeCoef = fadeCoef;
					blinkCallback = callback;
					
					removeEventListener(Event.ENTER_FRAME,blinkLst);
					addEventListener(Event.ENTER_FRAME,blinkLst);
				}
			}
			public function color(hex :uint, alphaVal :Number)
			{
				var rgb = Utils.hexToRGB(hex);
				
				var color :ColorTransform = new ColorTransform();
					color.redMultiplier = color.greenMultiplier = color.blueMultiplier = 1 - alphaVal;
					color.redOffset = 	rgb.red*alphaVal;
					color.greenOffset = rgb.green*alphaVal;
					color.blueOffset = 	rgb.blue*alphaVal;
					
				transform.colorTransform = color;
			}
			function blinkLst(e :Event)
			{
				color(blinkColor,blinkAlpha);
				blinkAlpha += blinkFadeCoef;
				if(blinkAlpha < 0)
				{
					color(blinkColor,0);
					removeEventListener(Event.ENTER_FRAME,blinkLst);
					if(blinkCallback != null) blinkCallback();
				}
			}
	}
}
