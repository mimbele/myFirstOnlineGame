package 
{
	import screens.InGame;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author mimbele
	 */
	public class Game extends Sprite
	{
		private var screenInGame:InGame;
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void{
						
			screenInGame = new InGame();
			this.addChild(screenInGame);
		}
		
	}

}