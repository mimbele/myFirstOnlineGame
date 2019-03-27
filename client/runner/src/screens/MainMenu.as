package screens
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	import screens.InGame;
	//import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import feathers.controls.Button;
	import feathers.controls.TextCallout;
	import feathers.themes.MinimalMobileTheme;
	
	public class MainMenu extends Screen
	{
		public static var instance:MainMenu = null;
		private var bgImage:Image;
		private var inGame:InGame;
		private var findButton:Button;
		private var aboutButton:Button;
		public function MainMenu()
		{			
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			instance = this;			
		}
	
				
		override protected function initialize():void
		{
			super.initialize();
		}
		
				
		
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
			
			bgImage = new Image(Assets.getTexture("mainMenu_bg"));
			this.addChild(bgImage);
			
			findButton = new Button();
			findButton.label = "FIND OPPONENT";
			this.addChild(findButton);
					
			
			findButton.validate();
			findButton.x = (stage.stageWidth - findButton.width) / 2;
			findButton.y = (stage.stageHeight - findButton.height) / 2;
			
			aboutButton = new Button();
			aboutButton.label = "ABOUT";
			aboutButton.x = (stage.stageWidth - aboutButton.width) / 2;
			aboutButton.y = findButton.y + findButton.height + 20;
			this.addChild(aboutButton);
			
			aboutButton.addEventListener(Event.TRIGGERED, aboutBtn_clickHandler);
			
			findButton.addEventListener(Event.TRIGGERED, findBtn_clickHandler);
			NetworkManager.getInstance().addEventListener("1", function()
			{
				findButton.label = "CANCEL";
				findButton.validate();
				findButton.x = (Main.GLOBAL_STAGE.stageWidth - findButton.width) / 2;
			});
			NetworkManager.getInstance().addEventListener("2", function()
			{
				findButton.label = "FIND OPPONENT";
				findButton.validate();
				findButton.x = (Main.GLOBAL_STAGE.stageWidth - findButton.width) / 2;
			});
			
		}
		
		private function aboutBtn_clickHandler(e:Event):void 
		{
			GameHolder.getInstance().navigator.pushScreen(GameHolder.ABOUT);
		}
		
		private function onResponse(e:SFSEvent):void
		{
			var cmd:String = e.params["cmd"] as String;
			if (cmd == "start_game")
			{
				GameHolder.getInstance().navigator.pushScreen(GameHolder.IN_GAME);
				NetworkManager.getInstance().sfs.removeEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
			}
		}
		
		private function findBtn_clickHandler(e:Event):void
		{
			if (NetworkManager.getInstance().in_queue)
				NetworkManager.getInstance().CancelFind();
			else
				NetworkManager.getInstance().FindOpponent();
		}
	}
}