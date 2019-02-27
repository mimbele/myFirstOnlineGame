package
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.utils.Timer;
	import screens.InGame;
	import screens.MainMenu;
	import starling.core.Starling;
	import utils.ProgressBar;
	import starling.animation.DelayedCall;
	import flash.events.TimerEvent;
	
	[SWF(frameRate="60",width="940", height="540", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var myStarling:Starling;
		private var progress:ProgressBar;
		public function Main()
		{

			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			stage.align = StageAlign.TOP_LEFT;
			
			progress = new ProgressBar(500, 40);
			progress.x = (stage.stageWidth - progress.width ) * 0.5;
			progress.y = (stage.stageHeight- progress.height);
			stage.addChild(progress);
			loaderInfo.addEventListener(Event.COMPLETE, loader_eventCompleteHandler);
		}
		
		private function loader_eventCompleteHandler(e:Event):void 
		{
			loaderInfo.removeEventListener(Event.COMPLETE, loader_eventCompleteHandler);
			progress.ratio = 0.1;
			
			myStarling = new Starling(MainMenu, stage);
			myStarling.antiAliasing = 1;
			myStarling.addEventListener(Event.CONTEXT3D_CREATE, myStarling_contex3DCreateHandler);
		}
		
		private function myStarling_contex3DCreateHandler(e:*):void 
		{
			myStarling.removeEventListener(Event.CONTEXT3D_CREATE, myStarling_contex3DCreateHandler);
			progress.ratio = 0.5;
			
			connect();
		}
		
	
		
		private function connect():void
		{
			NetworkManager.getInstance().Connect("192.168.14.200", 9933);
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.CONNECTION, function (e):void{progress.ratio = 0.75; });
			NetworkManager.getInstance().sfs.addEventListener(SFSEvent.LOGIN, onLogin);
		}
		
		private function onLogin(e:SFSEvent):void 
		{
			progress.ratio = 1;
			var timer:Timer = new Timer(1, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function (e):void {myStarling.start(); stage.removeChild(progress); });
			timer.start();
			
			NetworkManager.getInstance().sfs.removeEventListener(SFSEvent.LOGIN, onLogin);
		}
	}
}
