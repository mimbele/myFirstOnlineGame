package screens
{
	import objects.Player;
	import screens.InGame;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author mimbele
	 */
	public class GameOver extends Sprite
	{
		private var bgImage:Image;		
		private var backBtn:Button;
		private var opponent:Player;
		private var me:Player;
		private var hasWon:Boolean;
		private var gameRef:InGame;
		
		
		public function GameOver( me:Player, opponent:Player, hasWon:Boolean) // me and opponent refrences are for showing score
		{
			super();
			this.me = me;
			this.opponent = opponent;
			this.hasWon = hasWon;
			//gameRef = inGame;
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			//this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (hasWon){
				bgImage = new Image(Assets.getTexture("win_bg"));
				this.addChild(bgImage);
				
				backBtn = new Button(Assets.getTexture("btn"), "WIN AGAIN");
				this.addChild(backBtn);
			} else{
				bgImage = new Image(Assets.getTexture("lose_bg"));
				this.addChild(bgImage);
				
				backBtn = new Button(Assets.getTexture("btn"), "TRY AGAIN");
				this.addChild(backBtn);
			}
			
			
			
			backBtn.x = (stage.stageWidth - backBtn.width) / 2;
			backBtn.y = (stage.stageHeight - backBtn.height) / 2 + 200;
			
			backBtn.addEventListener(Event.TRIGGERED, backBtn_clickHandler);
		}

		
		
		private function backBtn_clickHandler(e:Event):void 
		{
			backBtn.removeEventListener(Event.TRIGGERED, backBtn_clickHandler);
			trace("back btn clicked");
			parent.addChild(new InGame());
			removeFromParent(this);
		}
	}
}