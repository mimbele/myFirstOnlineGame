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
		
		private var isJumping:Boolean = false;
		private var jumpTarget:Number; //the "y" value we want to go when jumping. set in touch handler
		
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
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
			
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
			if (isJumping){
				return;
			}
			var touch:Touch = e.getTouch(stage);
			if(touch)
            {
                if(touch.phase == TouchPhase.BEGAN && player.y == 0)
                {
					jumpTarget = -175;
					isJumping = true;
				}
            }
		}
		
		
		
		private function onGameTick(event:Event):void
		{
			timePrevious = timeCurrent;
			timeCurrent = getTimer();
			elapsed = (timeCurrent - timePrevious) * 0.001;
			
			if (isJumping){
				
				if (jumpTarget == -175){
					
					player.y += (jumpTarget - player.y) * elapsed * 5;
					if (player.y - jumpTarget < 20){
						jumpTarget = 0;
					}
				} 
				else if (jumpTarget == 0){
					
					player.y += (jumpTarget - player.y) * elapsed * 5;
					if (Math.abs(player.y - jumpTarget) < 5){
						player.y = 0;
						isJumping = false;
					}
					
				}
			}
		}
		
	}
	

}