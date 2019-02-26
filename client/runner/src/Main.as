package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import screens.InGame;
	import starling.core.Starling;
	import utils.ProgressBar;
	
	[SWF(frameRate="60",width="940", height="540", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var myStarling:Starling;
		private var progress:ProgressBar;
		public function Main()
		{

			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align 	= StageAlign.TOP_LEFT;
			
			progress = new ProgressBar(500, 40);
			stage.addChild(progress);
			loaderInfo.addEventListener(Event.COMPLETE, loader_eventCompleteHandler);
		}
		
		private function loader_eventCompleteHandler(e:Event):void 
		{
			progress.x = (stage.stageWidth - progress.width ) * 0.5;
			progress.y = (stage.stageHeight- progress.height ) * 0.5;
			loaderInfo.removeEventListener(Event.COMPLETE, loader_eventCompleteHandler);
			progress.ratio = 0.3;
			
			myStarling = new Starling(InGame, stage);
			myStarling.antiAliasing = 1;
			myStarling.addEventListener(Event.CONTEXT3D_CREATE, myStarling_contex3DCreateHandler);
					
			
		}
		
		private function myStarling_contex3DCreateHandler(e:*):void 
		{
			myStarling.removeEventListener(Event.CONTEXT3D_CREATE, myStarling_contex3DCreateHandler);
			progress.ratio = 0.6;
		}
	}
}
