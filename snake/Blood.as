package
{
	import def.*;
	import flash.display.MovieClip;
	
	public class Blood extends Particle
	{

		public function Blood(defParent :MovieClip,posx :Number,posy :Number)
		{
			super(defParent,posx,posy,0,function()
			{
				Particle(this).animation.stop();
				BaseMc(this).fade(-0.1,0,function()
				{
					BaseMc(this).kill();
				});
			});
		}

	}
	
}
