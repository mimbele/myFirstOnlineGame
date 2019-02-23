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
	/**
	 * ...
	 * @author mimbele
	 */
	public class InGame extends Sprite
	{
		private var bgPlayer:backGround;
		private var bgOpponent:backGround;
		private var player:Player;
		private var opponent:Player;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		private var velY:Number;
		private var state:int;
		
		private static const GRAVITY:Number = 9.81;
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
			velY = 0;
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
			state = IDLE;
			bgPlayer = new backGround(true);
			bgOpponent = new backGround(false);
			this.addChild(bgPlayer);
			this.addChild(bgOpponent);
			
			player = new Player(true);
			opponent = new Player(false);
			this.addChild(player);
			this.addChild(opponent);
			
			this.addEventListener(TouchEvent.TOUCH, this_touchHandler);
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
		}
		
		protected function this_touchHandler(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
            {
                if(touch.phase == TouchPhase.BEGAN && state == IDLE)
                {
					state = JUMPING;
					velY = -400;
				}
            }
		}
		
		
		
		private function onGameTick(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;

			// adjust velocity
			player.y += velY * elapsed;
			// adjust gravity
			velY += GRAVITY * elapsed * 100;
			
			if (player.y >= 0)
			{
				player.y = 0.0;
				velY = 0.0;
				state = IDLE;
			}
		}
		
	}
	

}