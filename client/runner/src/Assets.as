package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="../media/graphics/bgPlayer.png")] //940*250
		public static const bgPlayer:Class;
		
		[Embed(source="../media/graphics/bgOpponent.png")] //940*250
		public static const bgOpponent:Class;
		
		[Embed(source="../media/graphics/player.png")]
		public static const player:Class;
		
		[Embed(source="../media/graphics/opponent.png")]
		public static const opponent:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../media/fonts/IMPACT.TTF", fontFamily="myFont", mimeType="application/x-font", embedAsCFF="false")]
		public static var MyFont:Class;
		
		
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}