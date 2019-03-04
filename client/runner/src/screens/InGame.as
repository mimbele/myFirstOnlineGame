package screens 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
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
		
		public function get life():Number 
		{
			return _life;
		}
		
		public function set life(value:Number):void 
		{
			_life = value;
		}
		private var _player:Player;
		private var opponent:Player;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		private var obstacleGap:Number;
		private var touchHandler:TouchHandler;
		private var _life:Number;
		
		public const GRAVITY:Number = 9.81;
		public const BG_SPEED:Number = 300;
		private static const OBSTACLE_SPEED:Number = 400;
		
		
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
			life = 4;
			
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
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
		}
		
		private function onResponse(evt:SFSEvent):void 
		{
			var cmd:String = evt.params["cmd"] as String;
			var params:SFSObject = evt.params["params"] as SFSObject;
			
			if (cmd == "spawn_obstacle")
			{
				var x = params.getFloat("x");
				var user = params.getInt("user");
				var speed = params.getFloat("speed");
				var isroof = params.getBool("isroof");
				var time = params.getLong("time");
				trace("SPAWNING " + user + " " + isroof);
				var isMine = user == NetworkManager.getInstance().sfs.mySelf.playerId;
				var y;
				if (isMine)
				{
					if (isroof)
						y = stage.height - 250;
					else
						y = stage.height - 60;
				}
				else
				{
					if (isroof)
						y = 50;
					else
						y = 250;
				}
				y = stage.height - 170;
				var now:Number = NetworkManager.getNow();
				trace (now);
				trace (time - NetworkManager.getInstance().ServerTimeDiff);
				var obstacle:Obstacle = new Obstacle(this, isroof, speed, stage.width+x, y, time - NetworkManager.getInstance().ServerTimeDiff);
			}
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
		}
		
	}
	
}