package def
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Screen extends BaseMc
	{
		public static var objects :Array;
		
		var _screenW :Number;
		var _screenH :Number;
		var _cam 	 :Camera;
		
		
		public function get screenW(){ return _screenW;  				}
		public function get screenH(){ return _screenH;  				}
		public function get cam()	 { return _cam;		 				}
		public function get camDel() { return _cam.delay; 				}
		public function get mouse()	 { return new Point(mouseX,mouseY); }
		
		public function set camDel(n){ _cam.delay = n; }
		public function set cam(n)
		{
			if(_cam) _cam.kill();
			_cam = new Camera(this,n);
		}
											   
											   
		public function Screen(defParent :MovieClip,w :Number = -1,h :Number = -1)
		{
			super(defParent);
			
			if(!objects) objects = new Array();
			objects.push(this);
			
			BaseMc(this).destructor = Screen_destructor;
			
			
			if(w < 0 || h < 0)
			{
				w = Main.width;
				h = Main.height;
			}
			
			_screenW = w;
			_screenH = h;
			
			var msk = new MovieClip();
				with(msk)
				{
					graphics.beginFill(0x333333);
					graphics.drawRect(0,0,w,h);
					graphics.endFill();
				}
			mask = msk;
		}
		function Screen_destructor()
		{
			if(_cam) _cam.kill();
			Utils.removeObject(this,objects);
		}
	}
	
}
