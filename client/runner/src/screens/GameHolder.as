package screens 
{
	import starling.events.Event;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Parhamic
	 */
	public class GameHolder extends Sprite
	{
		
		public function GameHolder() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, onFrameEnter);
			name = "GAME HOLDER";
		}
		
		private function onFrameEnter(e:Event):void 
		{
			;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			this.addChild(new MainMenu());
		}
	}

}