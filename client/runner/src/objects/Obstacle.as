package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Obstacle extends Sprite
	{
		private var ObstacleImage:Image;
		private var gameRef:InGame;
		private var obSpeed:Number;
		
		public function Obstacle(inGame:InGame)
		{
			super();
			
			gameRef = inGame;
			obSpeed = inGame.speed;
			
			ObstacleImage = new Image(Assets.getTexture("obstacle"));
			//ObstacleImage.x = ObstacleImage.texture.width * 0.5;
			//ObstacleImage.y = ObstacleImage.texture.height * 0.5;
			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		private function this_enterFrameHandler(e:Event):void 
		{
			this.x -= obSpeed;
			
			
			
			if (this.bounds.intersects(gameRef.player.bounds))
			{
				gameRef.removeChild(this);
				
			}
			
			if (this.x < -50)
			{
				gameRef.removeChild(this);	
			}
		}
	}
}