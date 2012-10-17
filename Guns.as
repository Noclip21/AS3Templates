package
{
	import def.*;
	import armory.*;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	
	public class Guns extends Main
	{
		
		public function Guns()
		{
			var world :Screen = new Screen(game);
			
			var ts :TwlutSprkle = new TwlutSprkle(Screen(world));
				world.cam = ts;
		
			for(var i=0; i<30; i++)
			{
				var ang = (Math.PI*2/30)*i;
				var obj = new Target(world,
									 Math.cos(ang)*500,
									 Math.sin(ang)*500);
			}
		}
	}
	
}
