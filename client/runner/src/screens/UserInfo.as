package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
    import flash.text.TextFieldType;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author mimbele
	 */
	public class UserInfo extends Sprite
	{
		private var input:TextField;
		//private var confirmBtn:Shape;
		
		public function UserInfo() 
		{
			
			input = new TextField();
			input.width = 200;
			input.height = 40;
			input.type = TextFieldType.INPUT;
			input.border = true;
			input.background = true;
			
			var confirmBtn:Sprite = new Sprite();
			confirmBtn.graphics.beginFill(0xffffff);
			confirmBtn.graphics.drawRect(0, 0, 100, 30);
			confirmBtn.x = input.x + confirmBtn.width/2;
			confirmBtn.y = input.y + input.height + 50;
			confirmBtn.addEventListener(MouseEvent.CLICK, onClicked);
			confirmBtn.graphics.endFill();
			
			
			input.background = true;
			
			this.addChild(confirmBtn);
			this.addChild(input);
		}
		
		private function onClicked(e:MouseEvent):void 
		{
			var username = input.text;
			var up:UserPrefs = new UserPrefs();
			up.username = username;
			up.Save();
			if (NetworkManager.getInstance().TryToLogin())
			{
				parent.removeChild(this);
			}
		}
		
	}

}