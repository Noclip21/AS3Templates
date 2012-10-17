package def
{
	import flash.utils.*;
	import flash.display.MovieClip;
	import flash.display.MorphShape;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.geom.Point;
	
	public class Utils extends MovieClip
	{
		
		
		
		
		// spatial functions
		
		
			// returns distance between two given movieclips
		public static function dist(a :Object,b :Object)
		{
			return Math.sqrt(Math.pow(a.x - b.x,2) + Math.pow(a.y - b.y,2));
		}
		
			// returns angle between two given movieclips
		public static function ang(a :Object,b :Object)
		{
			var angulo = Math.atan((a.y - b.y)/(a.x - b.x));
			if(!angulo) angulo = 0;
			
			if(a.x < b.x)
				return angulo;
			else
				return Math.PI + angulo;
		}
		
			// returns an array storing given 2 points representing a line segment
		public static function lAt(a :Point,b :Point)
		{
			return new Array(a,b);
		}
		
			// returns if point is left to line
		public static function left(p :Point,line :Array)
		{
			if(line[0].y == line[1].y)
				return p.y < line[0].y && p.y < line[1].y;
				
			if(line[0].x == line[1].x)
				return p.x < line[0].x;
			
			var a = (line[1].y - line[0].y)/(line[1].x - line[0].x);
			var b = line[0].y - a*line[0].x;
			var x = (p.y - b)/a;
			
			if(p.x < x)
				return true;
			return false;
		}
		
			// returns intersection of two given line segments
		public static function segIntersec(l1 :Array,l2 :Array)
		{
			return	left(l1[0],l2) != left(l1[1],l2) &&
					left(l2[0],l1) != left(l2[1],l1);
		}
		
		
		
		
		// array functions
		
		
			// returns id of object in an array given the two
		public static function getID(item,array)
		{
			for(var i=0;i<array.length;i++)
				if(array[i] == item)
					return  i;
			return null;
		}
		
			// removes an object from an array given the two
		public static function removeObject(target,array)
		{
			array.splice(getID(target,array),1);
		}
		
			// returns class of given movieclip
		public static function getClass(obj)
		{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		
		
		
		// number and array funcitons
		
		
			// returns averange value given a array
		public static function averange(array)
		{
			var n = 0;
			for(var i=0; i<array.length; i++)
				n += array[i];
			return n/array.length;
		}
		
			// returns highest number of a given array
		public static function max(array)
		{
			var n = array[0];
			for(var i=0; i<array.length; i++)
				if(n < array[i])
					n = array[i];
			return n;
		}
		
			// returns smaller number of a given array
		public static function min(array)
		{
			var n = array[0];
			for(var i=0; i<array.length; i++)
				if(n > array[i])
					n = array[i];
			return n;
		}
		
			// initialize given array with given default value and length
		public static function init(array,len,def = 0)
		{
			for(var i=0; i<len; i++)
				array[i] = def;
		}
		
			// copy given array
		public static function copy(array :Array)
		{
			var copy = new Array();
			for(var i=0; i<array.length; i++)
				copy.push(array[i]);
			return copy;
		}
		
			/*
			* pile up an element at the end of an array
			* moving the subsequent values in order to
			* not change length
			*/
		public static function pile(array,val)
		{
			for(var i=0; i<array.length-1; i++)
				array[i] = array[i+1];
			array[array.length-1] = val;
		}
		
			// returns random number given a range
		public static function random(from,to)
		{
			return Math.random()*(to-from) + from;
		}
		
			// returns given number positive or negative
		public static function randSig(n)
		{
			if(Math.round(random(1,0)) == true)
				return n;
			else
				return -n;
		}
			// returns rgb object given hexadecimal value
		public static function hexToRGB(hex :Number)
		{
			var rgbObj:Object = {
				red: ((hex & 0xFF0000) >> 16),
				green: ((hex & 0x00FF00) >> 8),
				blue: ((hex & 0x0000FF))
			};
		 
			return rgbObj;
		}
		
		
		
		
		// movieclip animation
		
		
			// changes alpha of a given movieclip with a given value and a max and min range
		public static function alph(target :Object,min :Number,max :Number,val :Number)
		{
			if(val > 0)
			{
				if(target.alpha + val <= max)
					target.alpha += val;
				else
					target.alpha = max;
			}else{
				if(target.alpha + val >= min)
					target.alpha += val;
				else
					target.alpha = min;
			}
		}
		
			// returns relatice difference between two given numbers and easy
		public static function difFactor(a,b,easy = 0)
		{
			return (a - b)*easy;
		}
		
		
		
		
		// sound functions
		
		
			/*
			* returns timestamp of the sound computed
			* spectrum sound in a array 512 length with float
			* numbers from 0 to 2.0
			*/
		public static function readSpecStereo()
		{
			var spec = new Array();
				var bytes:ByteArray = new ByteArray();
					SoundMixer.computeSpectrum(bytes,true);
				for(var i=0; i<512; i++)
					spec.push(Math.abs(bytes.readFloat()));
			
			return spec;
		}
		
			// returns left input of given stereo spectrum
		public static function leftSpec(spec)
		{
			return spec.slice(0,256);
		}
		
			// returns right input of given stereo spectrum
		public static function rightSpec(spec)
		{
			return spec.slice(256,512);
		}
		
			/*
			* returns timestamp of the sound computed
			* spectrum sound in a array 256 length with float
			* numbers from 0 to 2.0
			*/
		public static function readSpecMono()
		{
			var spec = readSpecStereo();
					
			var mono = new Array();
			var left = leftSpec(spec);
			var right = rightSpec(spec);
			for(var i=0; i<256; i++)
				mono.push((left[i] + right[i])/2);
				
			return mono;
		}

	}
	
}
