package objects
{
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	import screens.InGame;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.utils.getTimer;
	
	public class Obstacle extends Sprite
	{
		private var ObstacleImage:Image;
		private var gameRef:InGame;
		private var obSpeed:Number;
		
		private var startTime:Number;
		private var startX:Number;
		
		public var id:Number;
		
		
		public function Obstacle(inGame:InGame, id, isRoof:Boolean, speed:Number, x, y, startTime)
		{
			super();
			name = "obstacle";
			gameRef = inGame;
			obSpeed = speed;
			startX = x;
			this.id = id;
			this.y = y;
			this.startTime = startTime;
			
			if (isRoof){
				ObstacleImage = new Image(Assets.getTexture("roofObstacle"));
			}else{
				ObstacleImage = new Image(Assets.getTexture("obstacle"));
			}

			this.addChild(ObstacleImage);
			
			this.addEventListener(Event.ENTER_FRAME, this_enterFrameHandler);
			
			inGame.addChild(this);
		}
		
		private function this_enterFrameHandler(e:Event):void 
		{
			var now:Number = NetworkManager.getNow();
			this.x = startX - ((now - startTime) * obSpeed * 0.001);
			if (this.bounds.intersects(gameRef.player.bounds))
			{
				gameRef.removeChild(this);
				gameRef.player.TakeDamage(1);
				var params:SFSObject = new SFSObject();
				NetworkManager.putTime(params);
				params.putInt("damage", 1);
				params.putInt("obstacle", id);
				NetworkManager.getInstance().sfs.send(new PublicMessageRequest("take_damage", params));
			}
			
			if (this.x < -50)
			{
				gameRef.removeChild(this);	
			}
		}
	}
}