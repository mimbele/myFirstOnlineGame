package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	
	public class Obstacle extends Sprite
	{
		private var inGame:InGame;
		private var ObstacleImage:Image;
		private var _speed:Number;
		
		public function Obstacle(inGame:InGame, speed:Number)
		{
			super();
			_speed = speed;
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			ObstacleImage = new Image(Assets.getTexture("obstacle"));
			this.addChild(ObstacleImage);
			
			ObstacleImage.x = ObstacleImage.texture.width * 0.5;
			ObstacleImage.y = ObstacleImage.texture.height * 0.5;
			
			this.inGame = inGame;
			this.inGame.addChild(this);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			this.x -= _speed;
			
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