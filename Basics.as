package
{
	/*
	* def package
	* Contains
	*
	* Utils.as
	* Screen.as
	* Particle.as
	* Main.as
	* KeyObjext.as
	* Camera.as
	* BaseMc.as
	*
	*/
	
	import def.*;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	public class Basics extends Main
	{
		
		
		public function Basics()
		{
			
			/*
			* Screen.as
			* 
			* Inherited from BaseMc, put the game sprites in there.
			*/
			
			
				// Examples
			
			
			var screen :Screen = new Screen(this);
			
			addEventListener(Event.ENTER_FRAME,function()
			{
				screen.mousemsg.text = 'Mouse position: '+screen.mouse; // screen mouse position (point)
			});
			
			
			
			
			/*
			* Main.as
			* 
			* Refers to important game variables as static values.
			* The main script should inherit the Main class, exactly
			* like this script.
			*/
			
			
				// Examples
				
				
			screen.stagemsg.text = 'Stage size: '+Main.width+' '+Main.height; // Stage w and h
			
			addEventListener(Event.ENTER_FRAME,function()
			{
					// see 
					// http://people.uncw.edu/tompkinsj/112/FlashActionScript/keyCodes.htm
				if(Main.key.isDown(37)) screen.keymsg.text = 'Arrow left';
				if(Main.key.isDown(38)) screen.keymsg.text = 'Arrow up';
				if(Main.key.isDown(39)) screen.keymsg.text = 'Arrow right';
				if(Main.key.isDown(40)) screen.keymsg.text = 'Arrow down';
			});
			
			
			
			/*
			* Utils.as
			*
			* Useful funcitons
			*/
			
			
				// Examples
				
				
			addEventListener(Event.ENTER_FRAME,function()
			{
				var point :Point =		new Point(screen.distmsg.x+98,screen.distmsg.y+10);
				var dist  :Number =		Utils.dist(point,screen.mouse);						// distance
				var ang	  :Number = 	Utils.ang(point,screen.mouse);						// angle (radians)
				var line1 :Array = 		Utils.lAt(point,screen.mouse);						// line
				var line2 :Array =		Utils.lAt(new Point(point.x+40,point.y+10),
												  new Point(point.x+20,point.y+40));		// line
				var itsc  :Boolean = 	Utils.segIntersec(line1,line2);						// segment intersection
				var g 	  :Graphics	=	screen.graphics;
				
				
				g.clear();
				
				g.lineStyle(1,0xFF0000,1);
				g.moveTo(point.x,point.y);
				g.lineTo(point.x+100,point.y);
				
				g.lineStyle(1,0xEEEEEE,1);
				g.moveTo(point.x,point.y);
				g.lineTo(screen.mouseX,screen.mouseY);
				
				if(itsc) g.lineStyle(1,0x00FF00,1);
				else	 g.lineStyle(1,0x00AA00,1);
				g.moveTo(line2[0].x,line2[0].y);
				g.lineTo(line2[1].x,line2[1].y);
				
				
				screen.distmsg.text = "Distance from X: "+Math.round(dist*100)/100;
				screen.angmsg.text = 'Angle: '+Math.round(ang*180/Math.PI)+'º';
			});
			
			
			
			/*
			* BaseMc.as
			*
			* Movieclip with some useful fuctions
			*/
			
			
				// Examples
				
				
			var basemc :BaseMc = new BaseMc(screen,50,150);
				screen.cam = basemc; // setting screen cam to track basemc
				basemc.display = function(){ basemc.rotation = Utils.ang(basemc,screen.mouse)*180/Math.PI; } // adding a listener
			
			Main.stage.addEventListener(MouseEvent.MOUSE_DOWN,function()
			{
				basemc.move(screen.mouse,0.1,function(){ basemc.blink(); }); // moving to point
			});

		}
	}
	
}
