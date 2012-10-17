package
{
	import def.*;
	import flash.display.MovieClip;
	
	public class SnakeObject
	{
		public static var objects :Array;
		
		public var head :SnakeHead;
		var body :Array;
		
		
		public function SnakeObject(defParent 	:MovieClip,
									posx 		:Number = 0,
									posy 		:Number = 0,
									size 		:Number = 5,
									hp   		:Number = 5)
		{
			if(!objects) objects = new Array();
			objects.push(this);
			body = new Array();
			
			head = new SnakeHead(defParent,posx,posy,this,hp);
			
			body.push(head);
			for(var i=0; i<size; i++)
			{
				body.push(new SnakeBody(defParent,posx,posy,this,hp,i+1));
			}
		}
		public function die()
		{
			var origin = MovieClip(head);
			var ang = Math.random()*Math.PI;
			var q = Utils.random(3,6);
			var dist = 100;
			for(var i=0; i<q; i++)
			{
				new Blood(origin.parent,origin.x+Math.cos(ang)*dist,origin.y+Math.sin(ang)*dist);
				ang += 2*Math.PI/q;
			}
			Utils.removeObject(this,objects);
			for(var i=0; i<body.length; i++)
				body[i].die();
			delete this;
		}
		function appendGap(id :Number)
		{
			for(var i=id; i<body.length; i++)
				SnakeBody(body[i]).id = i-1;
		}
		public function removeBodyPart(obj :SnakeBody)
		{
			appendGap(obj.id+1);
			Utils.removeObject(obj,body);
			if(body.length <= 0) die();
		}

	}
	
}
