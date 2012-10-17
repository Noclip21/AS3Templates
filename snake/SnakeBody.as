package
{
	import def.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class SnakeBody extends Target
	{
		public var id :Number;
		
		var snake :SnakeObject;
		
		
		public function SnakeBody(defParent 	:MovieClip,
								  posx			:Number,
								  posy			:Number,
								  snakeObject 	:SnakeObject,
								  defHp			:Number,
								  defId			:Number = 0)
		{
			super(defParent,posx,posy,defHp);
			gotoAndStop('body');
			
			id = 	defId;
			snake = snakeObject;
			
			if(id > 0) BaseMc(this).display =	SnakeBody_display;
			BaseMc(this).destructor = 			SnakeBody_destructor;
			
			var txt :TextField = new TextField();
				addChild(txt);
				txt.text = String(id);
		}
		function SnakeBody_destructor()
		{
			snake.removeBodyPart(this);
		}
		public function die()
		{
			new Blood(MovieClip(parent),x,y);
			BaseMc(this).kill();
		}
		override public function dmg(damage :Number)
		{
			BaseMc(this).blink();
			if(damage >= hp) die();
			else			 hp -= damage;
		}
		function SnakeBody_display()
		{
			var obj = snake.body[id-1];
			if(Utils.dist(obj,this) >= 50)
			{
				var ang = Utils.ang(obj,this);
				x = obj.x + Math.cos(ang)*50;
				y = obj.y + Math.sin(ang)*50;
			}
		}

	}
	
}
