package screens
{
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
		
		
		public function GameOver()
		{
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgImage = new Image(Assets.getTexture("gameOver_bg"));
			this.addChild(bgImage);
			
			backBtn = new Button(Assets.getTexture("btn"), "BACK TO MENU");
			this.addChild(backBtn);
			
			backBtn.x = (stage.stageWidth - backBtn.width) / 2;
			backBtn.y = (stage.stageHeight - backBtn.height) / 2;
			
			backBtn.addEventListener(Event.TRIGGERED, backBtn_clickHandler);
		}

		
		
		private function backBtn_clickHandler(e:Event):void 
		{
			trace("back btn clicked");
		}
	}
}