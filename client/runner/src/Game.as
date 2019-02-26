package 
{
	import screens.InGame;
	import screens.Loading;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author mimbele
	 */
	public class Game extends Sprite
	{
		private var inGameScene:InGame;
		private var loadingScene:Loading;
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void{
						
			inGameScene = new InGame();
			this.addChild(inGameScene);
			
			loadingScene = new Loading();
			this.addChild(loadingScene);
			
			inGameScene.disposeTemporarily();
			loadingScene.initialize();
		}
		
	}

}