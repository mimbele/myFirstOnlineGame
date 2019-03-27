package objects
{
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	import feathers.controls.Screen;
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
		private var superPlayerTexture:Texture;
		private var superPlayerTexture_crouching:Texture;
		
		private var velY:Number;
		private var startingY:Number;
		private var _state:int;
		private var _nextAction:Function;
		private var _hasShield:Boolean;
		private var shieldTimeRemained:Number;
		private var damageEffectTime:Number;
		
		public function get hasShield():Boolean 
		{
			return _hasShield;
		}		
		
		public function get life():Number 
		{
			return _life;
		}
		

		private var _life:Number;
		
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
			_life = 3;
			_hasShield = false;
			shieldTimeRemained = 0;
			
			if (isMe){
				playerTexture = Assets.getTexture("player");
				playerTexture_crouching = Assets.getTexture("player_crouch");
				superPlayerTexture = Assets.getTexture("superPlayer");
				superPlayerTexture_crouching = Assets.getTexture("superPlayer_crouch");
			} else {
				playerTexture = Assets.getTexture("opponent");
				playerTexture_crouching = Assets.getTexture("opponent_crouch");
				superPlayerTexture = Assets.getTexture("superOpponent");
				superPlayerTexture_crouching = Assets.getTexture("superOpponent_crouch");
			}
			
			state = IDLE;
			velY = 0;
			startingY += 40;
			this.startingY = startingY;
			y = startingY;
			playerImage = new Image(playerTexture);
			
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
			if (state != JUMPING)
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
			if (_hasShield){
				shieldTimeRemained --;
				if (shieldTimeRemained < 0){
					_hasShield = false;
					shieldTimeRemained = 0;
				}
			}
			if (damageEffectTime > 0){
				if (damageEffectTime >= 50){ //camera shake
					inGame.x = int(Math.random() * damageEffectTime * 0.3);
					inGame.y = int(Math.random() * damageEffectTime * 0.3);
					if (damageEffectTime == 50){
						inGame.x = 0;
						inGame.y = 0;
					}
				}
				if (damageEffectTime < 20){
					playerImage.alpha = 1;
				} else if (damageEffectTime % 10 == 0){
					playerImage.alpha = (playerImage.alpha == 1) ? 0.3 : 1;
				}
				damageEffectTime --;
			}
			
		}
		
		public function crouch(e:Event):void 
		{
			crouchDuration = 0.6;
			state = CROUCHING;
			if (isMe)
			{
				var params:SFSObject = new SFSObject();
				NetworkManager.putTime(params);
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("crouch", params, null));
			}
		}
		
		public function jump(e:Event):void 
		{
			velY = -500;
			state = IDLE; // TODO: FIX THIS LATER, use: to change the texture
			state = JUMPING;
			if (isMe)
			{
				var params:SFSObject = new SFSObject();
				NetworkManager.putTime(params);
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("jump", params, null));
			}
		}
		
		public function TakeDamage(dmg):void
		{
			_life -= dmg;
			if (isMe){
				damageEffectTime = 80;
				playerImage.alpha = 0.3;
			}
		}
		
		public function Heal(heal):void
		{
			_life += heal;
		}
		
		public function ActivateShield(){
			_hasShield = true;
			shieldTimeRemained = 200;
			state = state;
		}
		
		
		private function stateChangeHandler(e:Event):void 
		{
			if (state == CROUCHING){
				if (hasShield)
					playerImage.texture = superPlayerTexture_crouching;
				else 
					playerImage.texture = playerTexture_crouching;
				
				velY = 0;
				y = startingY+30;
				
			} else if (state == IDLE) {
				if (hasShield)
					playerImage.texture = superPlayerTexture;
				else 
					playerImage.texture = playerTexture;
				
				y = startingY;
			}
			
			playerImage.readjustSize();
		}
	}
}