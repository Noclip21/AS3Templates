package def
{
	import flash.display.MovieClip;
	
	public class Particle extends BaseMc
	{
		public static var objects :Array;
		
		var parents 	:Number;
		var Fcallback	:Function;
		
		public function get animation(){ return getParent(parents,MovieClip(this)); }
		
		
		public function Particle(defParent :MovieClip,posx :Number = 0,posy :Number = 0,parentsToAnimation :Number = 0,callback :Function = null)
		{
			super(defParent,posx,posy);
			
			if(!objects) objects = new Array();
			objects.push(this);
			
			BaseMc(this).display = 		Particle_display;
			BaseMc(this).destructor = 	Particle_destructor;
			
			parents = 	parentsToAnimation;
			Fcallback = callback;
		}
		function Particle_destructor()
		{
			Utils.removeObject(this,objects);
		}
		
		function getParent(deph :Number,refObj :MovieClip)
		{
			if(deph > 0 && refObj.getChildAt(0)) return getParent(deph-1,MovieClip(refObj.getChildAt(0)));
			else return refObj;
		}
		function Particle_display()
		{
			var mcListener = getParent(parents,MovieClip(this));
			
			if(mcListener.currentFrame == mcListener.totalFrames)
				if(Fcallback != null) Fcallback();
		}
	}
	
}
