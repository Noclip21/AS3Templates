package
{
	import def.*;
	import flash.geom.Point;
	
	public class Snake extends Main
	{

		public function Snake()
		{
			var point :Point = new Point(0,0);
			
			var stg :Screen = new Screen(this);
				stg.cam = point;
				
			var obj :SnakeObject = new SnakeObject(stg,100,100,20,15);
				obj.head.display = function()
				{
					if(Main.key.isDown(37)) // 37 <
						obj.head.x -= 8;
					if(Main.key.isDown(38)) // 38 ^
						obj.head.y -= 8;
					if(Main.key.isDown(39)) // 39 >
						obj.head.x += 8;
					if(Main.key.isDown(40)) // 40 \/
						obj.head.y += 8;
						
					if(Main.key.isDown(87)) // w
						point.y -= 8;
					if(Main.key.isDown(65)) // a
						point.x -= 8;
					if(Main.key.isDown(83)) // s
						point.y += 8;
					if(Main.key.isDown(68)) // d
						point.x += 8;
						
					if(Main.key.isDown(32)) // space
						new Projectile(stg,new Point(100,100),Utils.ang(new Point(100,100),stg.mouse));
				}
		}

	}
	
}
