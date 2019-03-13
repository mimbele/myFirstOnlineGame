package screens
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import screens.InGame;
	//import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import feathers.controls.Button;
	import feathers.controls.TextCallout;
	import feathers.themes.MinimalMobileTheme;
	
	public class MainMenu extends Sprite
	{
		public static var instance:MainMenu = null;
		private var bgImage:Image;
		private var inGame:InGame;
		private var findButton:Button;
		
		public function MainMenu()
		{
			new MinimalMobileTheme();
			
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			instance = this;
			name = "MainMenu";
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
			
			bgImage = new Image(Assets.getTexture("mainMenu_bg"));
			this.addChild(bgImage);
			
			findButton = new Button();
			findButton.label = "FIND OPPONENT";
			this.addChild(findButton);
			
			findButton.validate();
			findButton.x = (stage.stageWidth - findButton.width) / 2;
			findButton.y = (stage.stageHeight - findButton.height) / 2;
			
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
		
		function onEnterFrame():void
		{
			//findBtn.label = NetworkManager.getInstance().in_queue ? "CANCEL" : "FIND OPPONENT";
			//findBtn.x = (stage.stageWidth - findBtn.width) / 2;
			//findBtn.y = (stage.stageHeight - findBtn.height) / 2;
		}
		
		private function onResponse(e:SFSEvent):void
		{
			var cmd:String = e.params["cmd"] as String;
			if (cmd == "start_game")
			{
				trace(parent.name + " - > MAIN MENU");
				parent.addChild(new InGame());
				removeFromParent(true);
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