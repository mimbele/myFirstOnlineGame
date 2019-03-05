package 
{
	import flash.geom.Point;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Parhamic
	 */
	
	public class TouchHandler
	{
		private var touchStart:Point;
		private var dragging:Boolean;
		private var stage:Stage;
		public function TouchHandler(stage:Stage) 
		{
			this.stage = stage;
			touchStart = new Point();
			dragging = false;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.W)
				stage.dispatchEventWith("SWIPE_UP");
			else if(e.keyCode == Keyboard.S)
				stage.dispatchEventWith("SWIPE_DOWN");
		}
		
		public function Update(touch:Touch):void
		{
			if (touch.phase == TouchPhase.BEGAN)
			{
				touchStart.x = touch.globalX;
				touchStart.y = touch.globalY;
				dragging = true;
			}
			else if (touch.phase == TouchPhase.ENDED)
				dragging = false;
			
			if (dragging)
			{
				var diffx = touch.globalX - touchStart.x;
				var diffy = touch.globalY - touchStart.y;
				if (Math.abs(diffy) < 15)
				{
					if (diffx > 20)
					{
						stage.dispatchEventWith("SWIPE_RIGHT");
						dragging = false;
					}
					else if (diffx < -20)
					{
						stage.dispatchEventWith("SWIPE_LEFT");
						dragging = false;
					}
				}
				else if (Math.abs(diffx) < 15)
				{
					if (diffy > 20)
					{
						stage.dispatchEventWith("SWIPE_DOWN");
						dragging = false;
					}
					else if (diffy < -20)
					{
						stage.dispatchEventWith("SWIPE_UP");
						dragging = false;
					}
				}
			}
		}
	}

}