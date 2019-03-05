package objects
{
	import screens.InGame;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	/**
	 * ...
	 * @author mimbele
	 */
	public class HUD extends Sprite
	{
		private var bgImage:Image;	
		private var gameRef:InGame;
		private var yourHeartImage:Image;
		private var opponentHeartImage:Image;
		private var yourLifeText:TextField;
		private var opponentLifeText:TextField;
		private var textFormat:TextFormat;
		
		public function HUD(gameRef:InGame)
		{
			super();
			this.gameRef = gameRef;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgImage = new Image(Assets.getTexture("HUD_bg"));
			this.addChild(bgImage);
			
			yourHeartImage = new Image(Assets.getTexture("redHeart"));
			this.addChild(yourHeartImage);
			
			opponentHeartImage = new Image(Assets.getTexture("blueHeart"));
			this.addChild(opponentHeartImage);
			
			yourHeartImage.x = 10;
			yourHeartImage.y = 5;
			opponentHeartImage.x = this.width / 2;
			opponentHeartImage.y = 5;
			
			
			textFormat = new TextFormat("myFont", 24, 0x000000, "left", "top"); 
			yourLifeText = new TextField(100, 40, "X " , textFormat);
			opponentLifeText = new TextField(100, 40, "X " , textFormat);
			this.addChild(yourLifeText);
			this.addChild(opponentLifeText);
			
			yourLifeText.x = yourHeartImage.x + yourHeartImage.width + 3;
			opponentLifeText.x = opponentHeartImage.x + opponentHeartImage.width +3;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterframe);
		}
		
		private function onEnterframe(e:Event):void 
		{
			yourLifeText.text = "X " + gameRef.player.life;
			opponentLifeText.text = "X " + gameRef.opponent.life;
		}
	}
}