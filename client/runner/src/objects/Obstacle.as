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
		
		public function Obstacle(inGame:InGame, isRoof:Boolean, speed:Number, x, y)
		{
			super();
			
			gameRef = inGame;
			obSpeed = speed;
			this.x = x;
			this.y = y;
			
			if (isRoof){
				ObstacleImage = new Image(Assets.getTexture("roofObstacle"));
				this.y -= 190;
			}else{
				ObstacleImage = new Image(Assets.getTexture("obstacle"));
				this.y += 100;
			}

			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		private function this_enterFrameHandler(e:Event):void 
		{
			this.x -= obSpeed * gameRef.deltaTime;
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