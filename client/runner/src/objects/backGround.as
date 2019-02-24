package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class backGround extends Sprite
	{
		private var image1:Image;
		private var image2:Image;
		private var _isPlayer:Boolean; //true=player, false=opponent
		
		private var _speed:Number;
		
		public function backGround(isPlayer:Boolean, speed:Number)
		{
			super();
			_isPlayer = isPlayer;
			_speed = speed;
			
			if (isPlayer){
				image1 = new Image(Assets.getTexture("bgPlayer"));
				image2 = new Image(Assets.getTexture("bgPlayer"));
			} else {
				image1 = new Image(Assets.getTexture("bgOpponent"));
				image2 = new Image(Assets.getTexture("bgOpponent"));
			}
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			image1.x = 0;
			image2.x = image2.width;
			
			if (_isPlayer){
				image1.y = stage.stageHeight - image1.height;			
				image2.y = image1.y;
			} else{
				image1.y = stage.stageHeight - image1.height*2;			
				image2.y = image1.y;
			}
		
			
			this.addChild(image1);
			this.addChild(image2);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame(event:Event):void
		{
			image1.x -= _speed;
			image2.x -= _speed;
			if (image1.x < -(stage.stageWidth)) {
				image1.x = 0;
				image2.x = image2.width;
			}
			
		}
		
		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

	}
}