package screens
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import screens.InGame;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainMenu extends Sprite
	{
		public static var instance:MainMenu = null;
		private var bgImage:Image;		
		private var inGame:InGame;
		private var findBtn:Button;
		
		
		public function MainMenu()
		{
			super();
			
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			instance = this;
			
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
			
			bgImage = new Image(Assets.getTexture("mainMenu_bg"));
			this.addChild(bgImage);
			
			findBtn = new Button(Assets.getTexture("btn"));
			this.addChild(findBtn);
			
			findBtn.x = (stage.stageWidth - findBtn.width) / 2;
			findBtn.y = (stage.stageHeight - findBtn.height) / 2;
			
			findBtn.addEventListener(Event.TRIGGERED, findBtn_clickHandler);
			NetworkManager.getInstance().FindOpponent(); // TODO: REMOVE
		}

		
		function onEnterFrame():void
		{
			findBtn.text = NetworkManager.getInstance().in_queue ? "CANCEL" : "FIND OPPONENT";
		}
		private function onResponse(e:SFSEvent):void 
		{
			var cmd:String = e.params["cmd"] as String;
			if (cmd == "start_game")
			{
				parent.addChild(new InGame());
				removeFromParent(false);
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