package armory
{
	import def.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	
	public class Weapon extends BaseMc
	{
		public static var objects :Array;


		var _type		:String;
		var _screen		:MovieClip;
		var _rate		:Number;
		var _projectile	:Class;
		
		var Pdmg	:Number;
		var Psp		:Number;
		var Ppierce	:Number;
		var Pr		:Number;
		var PmaxD	:Number;
		
		var locked	 	:Boolean;
		var cooldown 	:Boolean;
		var cooldownLst :Timer;
		 
		
		public function get lock()		{ return locked; 	  }
		public function get projectile(){ return _projectile; }
		
		public function set lock(n :Boolean)    { locked = n; 		}
		public function set projectile(n :Class){ _projectile = n;  }
		
		
		public function Weapon(grip 	:MovieClip,
							   pos		:Point,
							   screen	:MovieClip,
							   ratems	:Number = 100)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			
			super(grip,pos.x,pos.y);
			
			BaseMc(this).destructor = Weapon_destructor;
			
			_screen = 	  screen;
			_rate =	 	  ratems;
			_projectile = Class(Projectile);
			
			locked =	  false;
			cooldown =	  false;
			cooldownLst = new Timer(ratems,0);
		}
		function Weapon_destructor()
		{
			Utils.removeObject(this,objects);
		}
		
		function Wpos()
		{
			var point = new Point(x,y);
				point = parent.localToGlobal(point);
			return _screen.globalToLocal(point);
		}
		function Wang()
		{
			return parent.rotation*Math.PI/180;
		}
		
		
		public function shoot()
		{
			if(!cooldown && !locked && _projectile.ammo != 0)
			{
				new _projectile(_screen,Wpos(),Wang());
				
				cooldown = true;
				cooldownLst.addEventListener(TimerEvent.TIMER,function(){ cooldown = false; });
				cooldownLst.start();
			}
		}
		
	}
	
}
