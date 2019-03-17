package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author mimbele
	 */
	
	public class Particle extends Sprite
	{
		private var _speedX:Number;
		private var _speedY:Number;
		private var _spin:Number;
		
		private var image:Image;
		
		public function Particle()
		{
			super();
			
			image = new Image(Assets.getTexture("Particle"));
			image.x = image.width * 0.5;
			image.y = image.height * 0.5;
			this.addChild(image);
		}

		public function get spin():Number
		{
			return _spin;
		}

		public function set spin(value:Number):void
		{
			_spin = value;
		}

		public function get speedY():Number
		{
			return _speedY;
		}

		public function set speedY(value:Number):void
		{
			_speedY = value;
		}

		public function get speedX():Number
		{
			return _speedX;
		}

		public function set speedX(value:Number):void
		{
			_speedX = value;
		}

	}
}