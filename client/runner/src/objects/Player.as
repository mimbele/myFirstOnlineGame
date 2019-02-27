package objects
{
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Player extends Sprite
	{
		public var speed:Number;
		private var playerImage:Image;
		private var isMe:Boolean;
		private var inGame:InGame;
		private var playerTexture:Texture;
		private var playerTexture_crouching:Texture;
		
		private var velY:Number;
		private var _state:int;
		
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
		private var crouchDuration:Number;
		
		private const IDLE:int = 0;
		private const JUMPING:int = 1;
		private const CROUCHING:int = 2;
		
		
		public function Player(inGame:InGame, isMe:Boolean)
		{
			super();
			this.isMe = isMe;
			this.inGame = inGame;
			speed = 400;
			
			if (isMe){
				playerTexture = Assets.getTexture("player");
				playerTexture_crouching = Assets.getTexture("player_crouch");
			} else {
				playerTexture = Assets.getTexture("opponent");
				playerTexture_crouching = Assets.getTexture("opponent_crouch");
			}
			
			state = IDLE;
			velY = 0;
			playerImage = new Image(playerTexture);
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener("stateChange", stateChangeHandler);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			inGame.stage.addEventListener("SWIPE_UP", jump);
			inGame.stage.addEventListener("SWIPE_DOWN", crouch);
			
			playerImage.x = 75;
			
			if (isMe){
				playerImage.y = stage.stageHeight - playerImage.height - 10;
			} else{
				playerImage.y = stage.stageHeight - playerImage.height - 10 - 250;
			}
			this.addChild(playerImage);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			// adjust velocity
			y += velY * inGame.deltaTime;
			// adjust gravity
			velY += inGame.GRAVITY * inGame.deltaTime * 150;
			
			if (y >= 0 && state != CROUCHING)
			{
				y = 0.0;
				velY = 0.0;
				state = IDLE;
			}
			if (state == CROUCHING){
				crouchDuration -= inGame.deltaTime;
				velY = 0.0;
				if (crouchDuration <= 0){
					state = IDLE;
				}
			}
		}
		
		private function crouch(e:Event):void 
		{
			if (!isMe)
				return;
			if (state == IDLE)
			{
				crouchDuration = 0.6;
				state = CROUCHING;
			}
		}
		
		private function jump(e:Event):void 
		{
			if (!isMe)
				return;
			if (state == IDLE)
			{
				velY = -500;
				state = JUMPING;
			}
		}

		private function stateChangeHandler(e:Event):void 
		{
			if (!isMe)
				return;
			if (state == CROUCHING){
				playerImage.texture = playerTexture_crouching;
				y = 30;
				
			} else if(state == IDLE) {
				playerImage.texture = playerTexture;
				y = 0.0;
			}
			
			playerImage.readjustSize();
			
		}
	}
}