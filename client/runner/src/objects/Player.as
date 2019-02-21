package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Player extends Sprite
	{
		private var playerImage:Image;
		private var _isPlayer:Boolean; //true=player, false=opponent
		
		
		public function Player(isPlayer:Boolean)
		{
			super();
			_isPlayer = isPlayer;
			
			if (isPlayer){
				playerImage = new Image(Assets.getTexture("player"));
			} else {
				playerImage = new Image(Assets.getTexture("opponent"));
			}
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			playerImage.x = 75;
			
			if (_isPlayer){
				playerImage.y = stage.stageHeight - playerImage.height - 10;
			} else{
				playerImage.y = stage.stageHeight - playerImage.height - 10 - 250;
			}

		
			
			this.addChild(playerImage);
			
		}
		



	}
}