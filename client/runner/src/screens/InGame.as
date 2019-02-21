package screens 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import objects.backGround;

	import Assets;
	/**
	 * ...
	 * @author mimbele
	 */
	public class InGame extends Sprite
	{
		private var bgPlayer:backGround;
		private var bgOpponent:backGround;
		public function InGame() 
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			
			bgPlayer = new backGround(true);
			bgOpponent = new backGround(false);
			this.addChild(bgPlayer);
			this.addChild(bgOpponent);
			
			
		}
	}

}