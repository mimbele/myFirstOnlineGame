package utils
{
    import flash.display.BitmapData;
    import flash.display.Shape;
	import flash.display.Sprite;
	
    public class ProgressBar extends Sprite
    {
		private var fill:flash.display.Shape;
        public function ProgressBar(width:int, height:int)
        {
            init(width, height);
        }
        
        private function init(width:int, height:int):void
        {
            var scale:Number = 1;
            var padding:Number = height * 0.2;
            var cornerRadius:Number = padding * scale * 2;
            
            // create black rounded box for background
            
            var bgShape:Shape = new Shape();
            bgShape.graphics.beginFill(0x0, 1);
            bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
            bgShape.graphics.endFill();
            addChild(bgShape);
			
			fill = new Shape();
            fill.graphics.beginFill(0x00FF33, 1);
            fill.graphics.drawRoundRect(2, 2, width*scale-4, height*scale-4, cornerRadius, cornerRadius);
            fill.graphics.endFill();
			fill.scaleX = 0;
			addChild(fill);
			

		}
        
        public function get ratio():Number { return fill.scaleX; }
        public function set ratio(value:Number):void 
        { 
            fill.scaleX = Math.max(0.0, Math.min(1.0, value)); 
        }
    }
}

