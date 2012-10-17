package
{
	
	import def.*;
	import perspective.*;
	
	
	public class Perspective extends Main
	{
		
		
		public function Perspective()
		{
			var world 	:WorldMap = 	new WorldMap(game,0.1,new DummyWorld());
			var ts 		:TwlutSprkle_perspective =	new TwlutSprkle_perspective(world);
			
			world.cam = ts;
		}
	}
	
}
