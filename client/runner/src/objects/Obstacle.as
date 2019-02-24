package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Obstacle extends Sprite
	{
		private var ObstacleImage:Image;
		
		public function Obstacle()
		{
			super();
			
			ObstacleImage = new Image(Assets.getTexture("obstacle"));
			//ObstacleImage.x = ObstacleImage.texture.width * 0.5;
			//ObstacleImage.y = ObstacleImage.texture.height * 0.5;
			this.addChild(ObstacleImage);
		}
	}
}