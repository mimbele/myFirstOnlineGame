package screens 
{
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
		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			if (_state == value)
				return;
			_state = value;
			dispatchEventWith("stateChange");
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
		
		public function get elapsed():Number 
		{
			return _elapsed;
		}
		
		private var _elapsed:Number;
		private var obstacleGap:Number;
		private var touchHandler:TouchHandler;
		
		private var velY:Number;
		private var _state:int; //0,1,2
		private var crouchDuration:Number;
		private var _life:Number;
		
		private static const GRAVITY:Number = 9.81;
		private static const BG_SPEED:Number = 400;
		private static const OBSTACLE_SPEED:Number = 400;
		
		private static const IDLE:int = 0;
		private static const JUMPING:int = 1;
		private static const CROUCHING:int = 2;
		
		
		
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
			velY = 0;
			obstacleGap = 0;
			state = IDLE;
			_elapsed = 0;
			life = 4;
			
			bgPlayer = new backGround(true, BG_SPEED, this);
			bgOpponent = new backGround(false, BG_SPEED, this);
			this.addChild(bgPlayer);
			this.addChild(bgOpponent);
			
			_player = new Player(this, true);
			opponent = new Player(this, false);
			this.addChild(player);
			this.addChild(opponent);
			
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			this.addEventListener(TouchEvent.TOUCH, this_touchHandler);
		}
		
		protected function this_touchHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
            {
                touchHandler.Update(touch);
				stage.addEventListener("SWIPE_UP", jump);
				stage.addEventListener("SWIPE_DOWN", crouch);
            }
		}
		
		private function crouch(e:Event):void 
		{
			if (state == IDLE)
			{
				crouchDuration = 0.6;
				state = CROUCHING;
			}
		}
		
		private function jump(e:Event):void 
		{
			if (state == IDLE)
			{
				velY = -500;
				state = JUMPING;
			}
		}
		
		
		
		private function onGameTick(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			_elapsed = (timeCurrent - timePrevious) * 0.001;

			// adjust velocity
			player.y += velY * elapsed;
			// adjust gravity
			velY += GRAVITY * elapsed * 150;
			
			if (player.y >= 0 && state!=CROUCHING)
			{
				player.y = 0.0;
				velY = 0.0;
				state = IDLE;
			}
			if (state == CROUCHING){
				crouchDuration -= elapsed;
				velY = 0.0;
				if (crouchDuration <= 0){
					state = IDLE;
				}
			}
			createObstacle();
		}
		
		private function createObstacle():void 
		{
			if (Math.random() < 0.03 && obstacleGap > 50){
				var obstacle:Obstacle = new Obstacle(this, OBSTACLE_SPEED);
				
				
				
				obstacleGap = 0;
			} else{
				obstacleGap ++;
			}
		}
		
	}
	
}