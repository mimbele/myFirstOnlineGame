package screens 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import starling.events.KeyboardEvent;
	import objects.Player;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import objects.backGround;
	import flash.utils.getTimer;

	import Assets;
	import TouchHandler;
	import objects.Obstacle;
	/**
	 * ...
	 * @author mimbele
	 */
	[Event(name = "stateChange", type = "starling.events.Event")]
	public class InGame extends Sprite
	{
		private var bgPlayer:backGround;
		private var bgOpponent:backGround;
		
		public function get player():Player 
		{
			return _player;
		}
		public function get deltaTime():Number{
			return elapsed;
		}
		
		private var _player:Player;
		private var opponent:Player;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		private var obstacleGap:Number;
		private var touchHandler:TouchHandler;
		
		public const GRAVITY:Number = 9.81;
		public const BG_SPEED:Number = 300;
		
		
		public function InGame() 
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
		}
		
		private function drawGame():void
		{
			timeCurrent = getTimer();
			touchHandler = new TouchHandler(stage);
			obstacleGap = 0;
			elapsed = 0;
			
			bgPlayer = new backGround(true, BG_SPEED, this);
			bgOpponent = new backGround(false, BG_SPEED, this);
			this.addChild(bgPlayer);
			this.addChild(bgOpponent);
			
			trace (NetworkManager.getInstance().sfs.mySelf.playerId);
			_player = new Player(this, true, stage.height-100);
			opponent = new Player(this, false, stage.height-350);
			this.addChild(player);
			this.addChild(opponent);
			
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			this.addEventListener(TouchEvent.TOUCH, this_touchHandler);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
		}
		
		private function onPublicMessage(evt:SFSEvent):void 
		{
			var sender:User = evt.params.sender;
         
			if (sender == NetworkManager.getInstance().sfs.mySelf)
				return;
			
			if (evt.params["message"] == "jump")
				opponent.jump(null);
			else if (evt.params["message"] == "crouch")
				opponent.crouch(null);
		}
		
		protected function this_touchHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
            {
                touchHandler.Update(touch);
            }
		}
		
		
		private function onGameTick(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;

			createObstacle();
		}
		
		private function createObstacle():void 
		{
			if (Math.random() < 0.03 && obstacleGap > 50){
				var obstacle:Obstacle = new Obstacle(this);
				obstacle.x = stage.stageWidth;
				obstacle.y = stage.stageHeight - obstacle.height - 10;
				
				obstacleGap = 0;
			} else{
				obstacleGap ++;
			}
		}
		
	}
	
}