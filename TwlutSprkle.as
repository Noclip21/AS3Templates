package
{
	
	import def.*;
	import armory.*;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class TwlutSprkle extends BaseMc
	{
		var world 	:Screen;
		var vel 	:Number;
		var maxVel  :Number;
		
		public var grip 	:MovieClip;
		public var weapon	:Weapon;
		
		
		public function TwlutSprkle(defParent :Screen,posx :Number = 0,posy :Number = 0)
		{
			super(MovieClip(defParent),posx,posy);
			
			world = defParent;
			vel = 1;
			maxVel = 10;
			grip = new MovieClip();
				addChild(grip);
			
			weapon = new Weapon(grip,new Point(100,0),world);
			
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
				
				
			grip.rotation = Utils.ang(this,world.mouse)*180/Math.PI;
			if(Main.key.isDown(32)) //space
				weapon.shoot();
			
		}
	}
	
}
