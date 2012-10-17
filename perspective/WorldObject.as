package perspective
{
	import def.*;
	import perspective.*;
	import flash.display.MovieClip;

	public class WorldObject extends Particle
	{
		public static var objects :Array;
		
		var worldMap :WorldMap;
		
		public function WorldObject(defParent 			:WorldMap,
									posz 				:Number = 0,
									posx 				:Number = 0,
									posy 				:Number = 0,
									defDynamicZ			:Boolean = false,
									parentsToAnimation  :Number = 0,
									callback 			:Function = null)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			
			super(WorldMap(defParent).getLayer(posz),posx,posy,parentsToAnimation,callback);
			
			worldMap = defParent;
			if(posz > worldMap.maxZ) posz = worldMap.maxZ;
			z = posz;
			worldMap.objects[z].push(this);
			
			if(defDynamicZ) BaseMc(this).display = SenarioObject_DynamicZ_display;
			else			BaseMc(this).display = SenarioObject_display
			BaseMc(this).destructor = ScenarioObject_destructor;
		}
		function ScenarioObject_destructor()
		{
			Utils.removeObject(this,objects);
		}
		function SenarioObject_display()
		{
			var array = worldMap.objects[z];
			var layer = worldMap.getLayer(z);
			
			for(var i=0; i<array.length; i++)
			if(layer.getChildIndex(this) < layer.getChildIndex(array[i]) &&
				y > array[i].y)
			layer.swapChildren(this,array[i]);
		}
		function SenarioObject_DynamicZ_display()
		{
			SenarioObject_display();
			
			if(z < worldMap.maxZ)
			{
				var array = worldMap.objects[z+1];
				
				for(var i=0; i<array.length; i++)
				if(hitTestObject(array[i]))
				{
					Utils.removeObject(this,worldMap.objects[z]);
					MovieClip(worldMap.getLayer(z)).removeChild(this);
					MovieClip(worldMap.getLayer(z+1)).addChild(this);
					array.push(this);
					z++;
					break;
				}
			}
			
			if(z > 0)
			{
				var ground = false;
				{
					var array = worldMap.objects[z];
					for(var i=0; i<array.length; i++)
						if(this != array[i])
						if(hitTestObject(array[i]))
						{
							ground = true;
							break;
						}
				}
				if(!ground)
				{
					Utils.removeObject(this,worldMap.objects[z]);
					MovieClip(worldMap.getLayer(z)).removeChild(this);
					MovieClip(worldMap.getLayer(z-1)).addChild(this);
					worldMap.objects[z-1].push(this);
					z--;
				}
			}
		}
	}
	
}