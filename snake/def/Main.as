package def
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Main extends MovieClip
	{
		public static var gui	:MovieClip;
		public static var game	:MovieClip;
		public static var key	:KeyObject;
		
		
		static var _PAUSE	:Boolean;
		static var _TIME	:Number;
		static var _stage	:Object;
		
		
		public static function get PAUSE()	{ return _PAUSE; }
		public static function get TIME()	{ return _TIME;  }
		
		public static function set PAUSE(n)	 { _PAUSE = n;	 }
		public static function set TIME(n)	 { _TIME = n;	 }
		
		public static function get stage() { return _stage;				}
		public static function get width() { return _stage.stageWidth;  }
		public static function get height(){ return _stage.stageHeight; }
		public static function get mouseX(){ return _stage.mouseX;      }
		public static function get mouseY(){ return _stage.mouseY;      }
		public static function get mouse() { return new Point(_stage.mouseX,_stage.mouseY); }
		
		
		public function Main()
		{
			gui	 = new MovieClip();
			game = new MovieClip();
			key  = new KeyObject(stage);
		
				addChild(game);
				addChild(gui);
				
			_PAUSE 		= false;
			_TIME 		= 1.0;
			_stage		= stage;
		}
	}
	
}
