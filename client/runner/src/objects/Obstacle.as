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
		private var isRoofObstacle:Boolean; // 30% chance of being roof obstacle
		
		public function Obstacle(inGame:InGame, speed:Number)
		{
			super();
			
			gameRef = inGame;
			obSpeed = speed;
			
			if (Math.random() < 0.3){
				ObstacleImage = new Image(Assets.getTexture("roofObstacle"));
				isRoofObstacle = true;
				this.x = gameRef.stage.stageWidth;
				this.y = gameRef.stage.stageHeight - this.height - 250;
				trace(ObstacleImage.y, this.y);
			}else{
				ObstacleImage = new Image(Assets.getTexture("obstacle"));
				isRoofObstacle = false;
				this.x = gameRef.stage.stageWidth;
				this.y = gameRef.stage.stageHeight - this.height - 60;
			}
			this.x = gameRef.stage.stageWidth;

			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		private function this_enterFrameHandler(e:Event):void 
		{
			this.x -= obSpeed * gameRef.elapsed;
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