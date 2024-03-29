package objects 
{
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author mimbele
	 */
	public class Item extends Sprite
	{
		private var itemImage:Image;
		private var gameRef:InGame;
		private var type:String; // HEAL - SHIELD
		private var speed:Number;
		private var startTime:Number;
		private var startX:Number;
		private var id:Number;
		
		public function Item(inGame:InGame, id:Number, type:String, speed:Number, x, y, startTime) 
		{
			super();
			
			this.type = type;
			name = "item";
			gameRef = inGame;
			this.speed = speed;
			startX = x;
			this.id = id;
			this.y = y;
			this.startTime = startTime;
			
			if (type == "HEAL"){
				itemImage = new Image(Assets.getTexture("healItem"));
			}else if (type == "SHIELD"){
				itemImage = new Image(Assets.getTexture("shieldItem"));
			}

			this.addChild(itemImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		
		private function this_enterFrameHandler(e:Event):void 
		{
			var now:Number = NetworkManager.getNow();
			this.x = startX - ((now - startTime) * Obstacle.globalSpeed * 0.001);
			if (this.bounds.intersects(gameRef.player.bounds))
			{
				gameRef.removeChild(this);
				
				var itemEffect = new ParticleEffect(this.x - 20, this.y - 10);
				gameRef.addChild(itemEffect);

				if (type == "HEAL"){
					gameRef.player.Heal(1);

				}else if (type == "SHIELD"){
					gameRef.player.ActivateShield();
				}
				
				var params:SFSObject = new SFSObject();
				NetworkManager.putTime(params);
				params.putInt("item", id);
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("item_picked", params));
				
			}
			
			if (this.x < -50)
			{
				gameRef.removeChild(this);	
			}
		}
		
	}

}