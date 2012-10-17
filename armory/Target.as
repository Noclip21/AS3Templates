package armory
{
	import def.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class Target extends BaseMc
	{
		public static var objects :Array;
		
		var hp 		:Number;
		var hitbox  :Array;
		var dmgArr	:Array;
		
		
		public function get hitboxes()
		{
			var array :Array = new Array();
			for(var i=0; i<hitbox.length; i++)
			{
				array.push(Utils.lAt(new Point(hitbox[i][0].x+x,hitbox[i][0].y+y),new Point(hitbox[i][1].x+x,hitbox[i][1].y+y)));
			}
			return array;
		};
		public function set hitboxes(a :Array)
		{
			if(a.length == 2) hitbox.push(a);
			else			  hitbox.length = 0;
		}
		
		
		public function Target(defParent :MovieClip,posx :Number,posy :Number,hitpoints :Number = 1)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			
			super(defParent,posx,posy);
			
			BaseMc(this).destructor = Target_destructor;
			
			hitbox = new Array();
			hitbox.push(Utils.lAt(new Point(-width/2,-height/2),new Point(width/2,height/2)));
			hitbox.push(Utils.lAt(new Point(width/2,-height/2),new Point(-width/2,height/2)));
			
			hp = hitpoints;
		}
		function Target_destructor()
		{
			Utils.removeObject(this,objects);
		}
		
		function dmg(damage :Number)
		{
			if(damage >= hp) BaseMc(this).kill();
			else			 hp -= damage;
		}
	}
	
}
