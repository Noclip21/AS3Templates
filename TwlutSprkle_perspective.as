package
{
	import def.*;
	import armory.*;
	import perspective.*;
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	
	public class TwlutSprkle_perspective extends WorldObject
	{
		var world 	:Screen;
		var vel 	:Number;
		var maxVel  :Number;
		
		
		public function TwlutSprkle_perspective(defParent	:WorldMap,
												posz 		:Number = 0,
												posx 		:Number = 0,
												posy 		:Number = 0)
		{
			super(defParent,posz,posx,posy,true);
				  
			world = defParent;
			vel = 1;
			maxVel = 10;
			
			BaseMc(this).display = TwlutSprkle_display;
		}
		function TwlutSprkle_display()
		{
			if(Main.key.isDown(65) || Main.key.isDown(87) ||
			   Main.key.isDown(68) || Main.key.isDown(83))
			{
				if(Main.key.isDown(65)) avelx -= vel; // a
				if(Main.key.isDown(87)) avely -= vel; // w
				if(Main.key.isDown(68)) avelx += vel; // d
				if(Main.key.isDown(83)) avely += vel; // s
				
			}else{
				avelx *= 0.90;
				avely *= 0.90;
			}
			
			
			if(Math.abs(avelx) > maxVel)
				if(avelx > 0)	avelx = maxVel;
				else			avelx = -maxVel;
			if(Math.abs(avely) > maxVel)
				if(avely > 0)	avely = maxVel;
				else			avely = -maxVel;
			
		}
	}
	
}
