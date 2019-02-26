package
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
 
	/**
	 * preloader of the application
	 */
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
	public class Preloader extends MovieClip
	{
		private const STARTUP_CLASS:String = "Main";
 
		public function Preloader()
		{
			trace("preloading");
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			stop();
		}
 
		private function onAddedToStage(event:Event):void
		{
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align 	= StageAlign.TOP_LEFT;
 
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
 
		private function onEnterFrame(event:Event):void
		{
			var bytesLoaded:int = root.loaderInfo.bytesLoaded;
			var bytesTotal:int  = root.loaderInfo.bytesTotal;
 
			trace("loading:"+bytesLoaded * 100+" % ");
 
			// update your progress bar here
 
			if( bytesLoaded >= bytesTotal )
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				run();
			}
		}
 
		private function run():void
		{
			trace("starting game");
			//trace (getDefinitionByName(STARTUP_CLASS));	
 
			nextFrame();
 
			var startupClass:Class = Main;
 
			var startupObject:DisplayObject = new startupClass(stage) as DisplayObject;
 
			addChildAt( startupObject, 0 );
 
		}
	}
}