package screens 
{
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Parhamic
	 */
	public class GameHolder extends Drawers
	{
		public function GameHolder()
		{
			new MetalWorksMobileTheme();
			super();
			
			if(_instance){
				throw new Error("Singleton... use getInstance()");
			} 
			_instance = this;
		}
		static const IN_GAME:String = "inGame";
		static const MAIN_MENU:String = "mainMenu";
		static const GAME_OVER:String = "gameOver";
		public static var _instance:GameHolder;
		
		
		public var navigator:StackScreenNavigator;
		private var _menu:MainMenu;
		
		override protected function initialize():void
		{
			super.initialize();
			this.navigator = new StackScreenNavigator();
			this.content = this.navigator;
			
			var inGame:StackScreenNavigatorItem = new StackScreenNavigatorItem(InGame);
			inGame.addPopEvent(Event.COMPLETE);
			this.navigator.addScreen(IN_GAME, inGame);
			
			var gameOver:StackScreenNavigatorItem = new StackScreenNavigatorItem(GameOver);
			gameOver.addPopEvent(Event.COMPLETE);
			this.navigator.addScreen(GAME_OVER, gameOver);
			
			this._menu = new MainMenu();
			var mainMenuItem:StackScreenNavigatorItem = new StackScreenNavigatorItem(MainMenu);
			this.navigator.addScreen(MAIN_MENU, mainMenuItem);
			this.navigator.rootScreenID = MAIN_MENU;
			
			
			
			//this._menu.addEventListener(Event.CHANGE, mainMenu_ChangeHandler);
		}
			
		public static function getInstance():GameHolder{
			if(!_instance){
				_instance = new GameHolder();
			} 
			return _instance;
		}
		
	}
	
	
	

}