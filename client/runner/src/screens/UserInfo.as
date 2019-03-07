package screens 
{
	import flash.display.Sprite;
	import flash.text.TextField;
    import flash.text.TextFieldType;

	
	/**
	 * ...
	 * @author mimbele
	 */
	public class UserInfo extends Sprite
	{
		private var input:TextField;
		public function UserInfo() 
		{
			input = new TextField();
			input.width = 100;
			input.height = 20;
			input.type = TextFieldType.INPUT;
			input.border = true;
			input.background = true;
			this.addChild(input);
			
		}
		
	}

}