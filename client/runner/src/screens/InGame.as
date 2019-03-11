package screens 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import objects.HUD;
	import objects.Item;
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
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;

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
		private var hud:HUD;
		
		public function get player():Player 
		{
			return _player;
		}

		public function get deltaTime():Number{
			return elapsed;
		}
		

		private var _player:Player;
		
		public function get opponent():Player 
		{
			return _opponent;
		}
		
		public function set opponent(value:Player):void 
		{
			_opponent = value;
		}
		
		private var _opponent:Player;
		
		private var backBtn:Button;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		private var obstacleGap:Number;
		private var touchHandler:TouchHandler;
		
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
			
			bgPlayer = new backGround(true, BG_SPEED, this);
			bgOpponent = new backGround(false, BG_SPEED, this);
			hud = new HUD(this);
			this.addChild(hud);
			this.addChild(bgPlayer);
			this.addChild(bgOpponent);
			
			
			backBtn = new Button(Assets.getTexture("btn"), "BACK");
			backBtn.addEventListener(Event.TRIGGERED, backBtn_clickHandler);
			backBtn.width = 100;
			backBtn.height = 50;
			backBtn.x = stage.stageWidth - backBtn.width - 10;
			backBtn.y = 50;
			this.addChild(backBtn);
			
			_player = new Player(this, true, stage.height-100);
			opponent = new Player(this, false, stage.height-350);
			this.addChild(player);
			this.addChild(opponent);
			
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			this.addEventListener(TouchEvent.TOUCH, this_touchHandler);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onResponse);
		}
		
		private function backBtn_clickHandler(e:Event):void 
		{
			backBtn.removeEventListener(Event.TRIGGERED, backBtn_clickHandler);
			trace("back btn clicked");
		}
		
		private function onResponse(evt:SFSEvent):void 
		{
			var cmd:String = evt.params["cmd"] as String;
			var params:SFSObject = evt.params["params"] as SFSObject;
			
			if (cmd == "spawn_obstacle")
			{
				var x = params.getFloat("x");
				var x2 = params.getFloat("item_x");
				var user = params.getInt("user");
				var speed = params.getFloat("speed");
				var isroof = params.getBool("isroof");
				var time = params.getLong("time");
				var id = params.getInt("id");
				var item = params.getUtfString("item");
				var isMine = user == NetworkManager.getInstance().sfs.mySelf.playerId;
				if (!isMine)
					time += NetworkManager.GLOBAL_DELAY;
				var y;
				if (isMine)
				
				{
					if (isroof)
						y = stage.stageHeight - 250;
					else
						y = stage.stageHeight - 60;
				}
				else
				{
					if (isroof)
						y = stage.stageHeight - 250 - 250;
					else
						y = stage.stageHeight - 60 -250;
				}
				var now:Number = NetworkManager.getNow();
				var obstacle:Obstacle = new Obstacle(this, id, isroof, speed, stage.stageWidth + x, y, time - NetworkManager.getInstance().ServerTimeDiff);
				
				if (isMine)
						y = stage.stageHeight - 100 - x2 * 0.3;
				else
					y = stage.stageHeight - 100 - 250 - x2 * 0.3;
				
				if (item == "HEAL")
				{
					var item:Item = new Item(this, id, "HEAL", speed, stage.stageWidth + x + x2 + 75, y, time - NetworkManager.getInstance().ServerTimeDiff);
				} else if (item == "SHIELD")
				{
					var item:Item = new Item(this, id, "SHIELD", speed, stage.stageWidth + x + x2 + 75, y, time - NetworkManager.getInstance().ServerTimeDiff);
				}
			}
		}
		
		private function onPublicMessage(evt:SFSEvent):void 
		{
			var sender:User = evt.params.sender;
         
			if (sender == NetworkManager.getInstance().sfs.mySelf)
				return;
			var params:SFSObject = evt.params["data"] as SFSObject;
			var time:Number = params.getLong("time");
			if (time == null || time == undefined)
				time = 0;
			var delay = time - (NetworkManager.getNow() + NetworkManager.getInstance().ServerTimeDiff);
			if (evt.params["message"] == "jump")
			{
				if (delay > 0)
				{
					var timer:Timer = new Timer(delay, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (e):void {opponent.jump(null);});
					timer.start();
				}
			}
			else if (evt.params["message"] == "crouch")
			{
				if (delay > 0)
				{
					var timer:Timer = new Timer(delay, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (e):void {opponent.crouch(null);});
					timer.start();
				}
			}
			else if (evt.params["message"] = "take_damage")
			{
				if (delay > 0)
				{
					var timer:Timer = new Timer(delay, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (e):void {
						opponent.TakeDamage(params.getInt("damage"));
						
						for (var i = 0; i < numChildren; i++)
						{
							if (getChildAt(i).name == "obstacle" && (getChildAt(i) as Obstacle).id == params.getInt("obstacle"))
							{
								removeChildAt(i);
								break;
							}
						}
					});
					timer.start();
				}
			}
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