package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	
	public class Weapon extends MovieClip
	{
		static var _weapon = [
							   ['type1',	'type2',	'type3'],	// weapon type
							   ['ammo1',	'ammo1',	'ammo2'],	// ammo type
							   [1,			2,			3],			// damage
							   [100,		100,		200]		// fire rate (ms)
							 ];
		
		
		var _type	:String;
		var grip 	:MovieClip;
		var screen	:MovieClip;
		var cooldown :Boolean;
		
		var cooldownLst :Timer;
		
		
		public static function ammo(type :String)  { return _weapon[1][Utils.getID(type,_weapon[0])]; }
		public static function rounds(type :String){ return Ammo.getAmmo(ammo(type));	 			  }
		public static function dmg(type :String)   { return _weapon[2][Utils.getID(type,_weapon[0])]; }
		public static function rate(type :String)  { return _weapon[3][Utils.getID(type,_weapon[0])]; }
							  
		
		public function Weapon(type :String,limb :MovieClip, world :MovieClip)
		{
			_type = type;
			grip = limb;
			screen = world;
			
			cooldown = false;
			cooldownLst = new Timer(rate(type),0);
		}
		
		
		function pos()
		{
			var point = new Point(x,y);
				point = parent.localToGlobal(point);
			return screen.globalToLocal(point);
		}
		function ang()
		{
			return grip.rotation*Math.PI/180;
		}
		
		
		public function shoot()
		{
			if(!cooldown && rounds(_type) > 0)
			{
				var bullet = new Projectile(pos(),ang(),dmg(_type));
					screen.addChild(bullet);
				
				Ammo.setAmmo(ammo(_type),-1);
				
				cooldown = true;
				cooldownLst.addEventListener(TimerEvent.TIMER,function(){ cooldown = false; });
				cooldownLst.start();
			}
		}
		
	}
	
}
