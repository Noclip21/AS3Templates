package perspective
{
	import def.*;
	import perspective.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class WorldMap extends Screen
	{
		public var objects :Array;
		
		var _zCoef 		 :Number;
		var camRelPoint  :BaseMc;
		var _cam		 :WorldCamera;
		
		
		public function get maxZ() { return numChildren-1; }
		public function get zCoef(){ return _zCoef;				 }
		
		override public function set cam(n)
		{
			if(_cam) _cam.kill();
			_cam = new WorldCamera(this,n);
		}
		
		
		public function set zCoef(n :Number)
		{ 
			_zCoef = n;
			for(var i=0; i<numChildren; i++)
				getChildAt(i).scaleX = getChildAt(i).scaleY = 1 + i*_zCoef;
		}
		
		
		public function WorldMap(defParent :MovieClip,defzCoef :Number = 0.1,source :MovieClip = null)
		{
			super(defParent);
			objects = new Array();
			
			_zCoef = defzCoef;
			
			if(source) replaceItens(source);
			
			BaseMc(this).display =	  WorldMap_display;
			BaseMc(this).destructor = WorldMap_destructor;
		}
		function WorldMap_destructor()
		{
			for(var i=0; i<objects.length; i++)
			for(var j=0; j<objects[i].length; j++)
				BaseMc(objects[i][j]).kill();
				
			while(numChildren) removeChild(getChildAt(0));
		}
		public function getLayer(posz :Number)
		{
			if(posz >= numChildren || !numChildren)
			{
				var mc = addChild(new MovieClip());
				objects.push(new Array());
				posz = numChildren -1;
				mc.scaleX = mc.scaleY = 1 + posz*_zCoef;
			}
			return getChildAt(posz);
		}
		function replaceItens(source :MovieClip)
		{
			var array :Array = new Array();
			
			do{
				var mcLevel	   :MovieClip = MovieClip(source.getChildAt(0));
				var levelArray :Array = new Array();
				
				do{
					var obj = mcLevel.getChildAt(0);
						obj.x += mcLevel.x;
						obj.y += mcLevel.y;
						mcLevel.removeChild(obj);
						levelArray.push(obj);
				}while(mcLevel.numChildren);
				source.removeChild(mcLevel);
				
				array.push(levelArray);
				
			}while(source.numChildren);
			
			for(var i=0; i<array.length; i++)
			for(var j=0; j<array[i].length; j++)
			{
				var wrapper = new WorldObject(this,i,array[i][j].x,array[i][j].y);
					array[i][j].x = array[i][j].y = 0;
					MovieClip(wrapper).addChild(array[i][j]);
			}
				
				
			removeEventListener(Event.FRAME_CONSTRUCTED,replaceItens);
		}
		
		function WorldMap_display()
		{
			for(var i=0; i<numChildren; i++)
			{
				var layer = getChildAt(i);
					layer.x = x*i*_zCoef + screenW/2;
					layer.y = y*i*_zCoef + screenH/2;
			}
		}
	}
}
