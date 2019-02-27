package 
{
	import flash.geom.Point;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Parhamic
	 */
	
	public class TouchHandler
	{
		private var touchStart:Point;
		private var dragging:Boolean;
		private var stage:Stage;
		public function TouchHandler(stage) 
		{
			this.stage = stage;
			touchStart = new Point();
			dragging = false;
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