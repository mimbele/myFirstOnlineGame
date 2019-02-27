package screens
{
	import screens.InGame;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainMenu extends Sprite
	{
		private var bgImage:Image;		
		private var inGame:InGame;
		private var findBtn:Button;
		
		public function MainMenu()
		{
			super();
			
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgImage = new Image(Assets.getTexture("mainMenu_bg"));
			this.addChild(bgImage);
			
			findBtn = new Button(Assets.getTexture("findBtn"), "FIND OPPONENT");
			this.addChild(findBtn);
			
			findBtn.x = (stage.stageWidth - findBtn.width) / 2;
			findBtn.y = (stage.stageHeight - findBtn.height) / 2;
			
			findBtn.addEventListener(Event.TRIGGERED, findBtn_trigerHandler);
			}
			
			private function findBtn_trigerHandler(e:Event):void 
			{
				trace("i'm trigerred");
			}
		

	}
}