package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.utils.getTimer;
	
	public class Obstacle extends Sprite
	{
		private var ObstacleImage:Image;
		private var gameRef:InGame;
		private var obSpeed:Number;
		private var startTime:Number;
		private var startX:Number;
		
		
		public function Obstacle(inGame:InGame, isRoof:Boolean, speed:Number, x, y, startTime)
		{
			super();
			
			gameRef = inGame;
			obSpeed = speed;
			startX = x;
			this.y = y;
			this.startTime = startTime;
			
			if (isRoof){
				ObstacleImage = new Image(Assets.getTexture("roofObstacle"));
			}else{
				ObstacleImage = new Image(Assets.getTexture("obstacle"));
			}

			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		private function this_enterFrameHandler(e:Event):void 
		{
			var now:Number = NetworkManager.getNow();
			this.x = startX - ((now - startTime) * obSpeed * 0.001);
			if (this.bounds.intersects(gameRef.player.bounds))
			{
				gameRef.removeChild(this);
				gameRef.life --;
			}
			
			if (this.x < -50)
			{
				gameRef.removeChild(this);	
			}
		}
	}
}