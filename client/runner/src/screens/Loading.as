package screens
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.ProgressBar;
	import Assets;
	
	public class Loading extends Sprite
	{
		private var bg:Image;
		private var progress:ProgressBar;
		
		public function Loading()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			bg = new Image(Assets.getTexture("loaging_bg"));
			this.addChild(bg);
			
			var progress:ProgressBar = new ProgressBar(600, 40);
			
			
			progress.x = stage.stageWidth / 2- 200;
			progress.y = stage.stageHeight / 2;
			this.addChild( progress );
			
		}
		
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
	}
}