package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Obstacle extends Sprite
	{
		private var ObstacleImage:Image;
		private var inGame:InGame;
		private var obSpeed:Number;
		
		public function Obstacle(inGame:InGame, speed:Number)
		{
			super();
			
			ObstacleImage = new Image(Assets.getTexture("obstacle"));
			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.inGame = inGame;
			inGame.addChild(this);
			obSpeed = speed;
		}
		
		private function onEnterFrame(e:Event):void 
		{
			this.x -= obSpeed * inGame.deltaTime;
			if (this.bounds.intersects(inGame.player.bounds))
			{
				inGame.removeChild(this);
			}
			if (this.x < -50)
			{
				inGame.removeChild(this);	
			}
		}
	}
}