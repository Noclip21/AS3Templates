package
{
	import def.*;
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class Projectile extends BaseMc
	{
		public static var objects :Array;
		
		var _damage  :Number;
		var _pierce	 :Number;
		var _ratius  :Number;
		var _speed	 :Number;
		var _angle   :Number;
		var _maxDist :Number;
		
		
		var origin  :Point;
		var dist	:Number;
		
		public function get damage() { return _angle;	 }
		public function get pierece(){ return _pierce;	 }
		public function get ratius() { return _ratius;	 }
		public function get speed()  { return _speed;	 }
		public function get angle()  { return _angle;	 }
		public function get maxDist(){ return _maxDist;  }
		

		public function set damage(n) { _damage = n;  }
		public function set pierece(n){ _pierce = n;  }
		public function set ratius(n) { _ratius = n;  }
		public function set speed(n)  { _speed = n;   }
		public function set angle(n)  { _angle = n;   }
		public function set maxDist(n){ _maxDist = n; }
		
		
		public function Projectile( defParent 	:MovieClip,
								   	pos			:Point,
							   		ang			:Number = 0,
							   		dmg			:Number = 1,
							   		sp			:Number = 50,
							   		pierc		:Number = 1,
							   		r			:Number = 0,
							   		maxD		:Number = 999)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			
			super(defParent,pos.x,pos.y);
			
			BaseMc(this).display =	  Projectile_display;
			BaseMc(this).destructor = Projectile_destructor;
			
			_damage	 = dmg;
			_pierce	 = pierc;
			_ratius	 = r;
			_speed	 = sp;
			_angle	 = ang;
			_maxDist = maxD;
			
			origin = pos;
				x = pos.x;
				y = pos.y;
				
			dist = 0;
		}
		function Projectile_destructor()
		{
			Utils.removeObject(this,objects);
		}
		
		function Projectile_display()
		{
			rotation = _angle*180/Math.PI;
			
			avelx = Math.cos(_angle)*_speed;
			avely = Math.sin(_angle)*_speed;
			
			
			for(var i=0; i<Target.objects.length; i++)
			{
				var target = Target.objects[i];
				
				var bTrace = new Array(new Point(x,y), new Point(x+avelx,y+avely));
				for(var j=0; j<Target(target).hitboxes.length; j++)
					if(Utils.segIntersec(bTrace,Target(target).hitboxes[j]))
					{
					   target.dmg(_damage);
					   _pierce--;
					   if(_pierce <= 0) BaseMc(this).kill(); break;
					}
			}
			
			
			dist += _speed;
			
			if(dist > _maxDist) BaseMc(this).kill();
		}
	}
	
}
