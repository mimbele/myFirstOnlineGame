package objects
{
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
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
		private var startingY:Number;
		private var _state:int;
		private var _nextAction:Function;
		
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
		
		
		public function Player(inGame:InGame, isMe:Boolean, startingY:Number)
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
			this.startingY = startingY;
			playerImage = new Image(playerTexture);
			y = startingY;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener("stateChange", stateChangeHandler);
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (isMe)
			{
				inGame.stage.addEventListener("SWIPE_UP", onSwipeUp);
				inGame.stage.addEventListener("SWIPE_DOWN", onSwipeDown);
			}
			
			playerImage.x = 75;
			
			this.addChild(playerImage);
		}
		
		private function onSwipeDown(e:Event):void 
		{
			if (state == IDLE)
				crouch(null);
			else
				_nextAction = crouch;
		}
		
		private function onSwipeUp(e:Event):void 
		{
			if (state == IDLE)
				jump(null);
			else
				_nextAction = jump;
		}
		
		private function onEnterFrame(e:Event):void 
		{
			// adjust velocity
			y += velY * inGame.deltaTime;
			// adjust gravity
			velY += inGame.GRAVITY * inGame.deltaTime * 150;
			
			if (y >= startingY && state != CROUCHING)
			{
				y = startingY;
				velY = 0.0;
				state = IDLE;
				if (_nextAction)
				{
					_nextAction(null);
					_nextAction = null;
				}
			}
			if (state == CROUCHING){
				crouchDuration -= inGame.deltaTime;
				velY = 0.0;
				if (crouchDuration <= 0){
					state = IDLE;
				}
			}
		}
		
		public function crouch(e:Event):void 
		{
			if (state == IDLE)
			{
				crouchDuration = 0.6;
				state = CROUCHING;
			}
			if (isMe)
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("crouch", new SFSObject(), null));
		}
		
		public function jump(e:Event):void 
		{
			if (state == IDLE)
			{
				velY = -500;
				state = JUMPING;
			}
			if (isMe)
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("jump", new SFSObject(), null));
		}

		private function stateChangeHandler(e:Event):void 
		{
			if (state == CROUCHING){
				playerImage.texture = playerTexture_crouching;
				y = startingY+30;
				
			} else if(state == IDLE) {
				playerImage.texture = playerTexture;
				y = startingY;
			}
			
			playerImage.readjustSize();
		}
	}
}