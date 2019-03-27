package screens 
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	/**
	 * ...
	 * @author mimbele
	 */
	public class About extends Screen 
	{
		private var backBtn:Button;
		
		public function About() 
		{
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			backBtn = new Button();
			backBtn.label = "BACK";
			backBtn.validate();
			backBtn.x = (stage.stageWidth/2) - backBtn.width/2;
			backBtn.y = 500;
			this.addChild(backBtn);
			backBtn.addEventListener(Event.TRIGGERED, backBtn_clickHandler);
		}
		
		private function backBtn_clickHandler(e:Event):void 
		{
			GameHolder.getInstance().navigator.pushScreen(GameHolder.MAIN_MENU);
		}
		
	}

}