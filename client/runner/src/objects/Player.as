package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Player extends Sprite
	{
		private var playerImage:Image;
		private var _isPlayer:Boolean; //true=player, false=opponent
		private var inGame:InGame;
		private var playerTexture:Texture;
		private var playerTexture_crouching:Texture;
		
		public function Player(inGame:InGame, isPlayer:Boolean)
		{
			super();
			_isPlayer = isPlayer;
			this.inGame = inGame;
			
			if (isPlayer){
				playerTexture = Assets.getTexture("player");
				playerTexture_crouching = Assets.getTexture("player_crouch");
			} else {
				playerTexture = Assets.getTexture("opponent");
				playerTexture_crouching = Assets.getTexture("opponent_crouch");
			}
			
			playerImage = new Image(playerTexture);
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			if (isPlayer)
				inGame.addEventListener("stateChange", inGame_stateChangeHandler);
			
		}
		
		
		private function inGame_stateChangeHandler(e:Event):void 
		{
			if (inGame.state == 2){ //crouching
				playerImage.texture = playerTexture_crouching;
				this.y = 30;
				
			} else if(inGame.state == 0) {
				playerImage.texture = playerTexture;
				this.y = 0.0;
			}
			
			playerImage.readjustSize();
			
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