package
{
	import def.*;
	import flash.display.MovieClip;
	
	public class SnakeHead extends SnakeBody
	{

		public function SnakeHead(defParent		:MovieClip,
								  posx			:Number,
								  posy			:Number,
								  snakeObject	:SnakeObject,
								  defHp			:Number)
		{
			super(defParent,posx,posy,snakeObject,defHp);
			gotoAndStop('head');
		}
		override public function die()
		{
			var body = SnakeBody(this).snake.body;
			
			var neck :SnakeBody = SnakeBody(this);
			for(var i=0; i<body.length; i++)
				if(body[i] != this)
				{
					neck = body[i];
					break;
				}
			if(neck != this)
			{
				hp = neck.hp;
				neck.die();
			}else{
				snake.removeBodyPart(this);
				BaseMc(this).kill();
			}
		}

	}
	
}
