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
		
		[Embed(source="../media/graphics/loading_bg.jpg")]
		public static const loaging_bg:Class;
		
		[Embed(source="../media/graphics/mainMenu_bg.jpg")]
		public static const mainMenu_bg:Class;
						
		[Embed(source="../media/graphics/lose_bg.jpg")]
		public static const lose_bg:Class;
		
		[Embed(source="../media/graphics/win_bg.jpg")]
		public static const win_bg:Class;
		
		[Embed(source="../media/graphics/backBtn.jpg")]
		public static const backBtn:Class;
		
		[Embed(source="../media/graphics/btn.png")]
		public static const btn:Class;
		
		[Embed(source="../media/graphics/player_crouch.png")]
		public static const player_crouch:Class;
		
		[Embed(source="../media/graphics/opponent_crouch.png")]
		public static const opponent_crouch:Class;
		
		[Embed(source="../media/graphics/opponent.png")]
		public static const opponent:Class;
		
		[Embed(source="../media/graphics/player.png")]
		public static const player:Class;
		
		[Embed(source="../media/graphics/superPlayer_crouch.png")]
		public static const superPlayer_crouch:Class;
		
		[Embed(source="../media/graphics/superOpponent_crouch.png")]
		public static const superOpponent_crouch:Class;
		
		[Embed(source="../media/graphics/superOpponent.png")]
		public static const superOpponent:Class;
		
		[Embed(source="../media/graphics/superPlayer.png")]
		public static const superPlayer:Class;
		
		[Embed(source="../media/graphics/obstacle.png")]
		public static const obstacle:Class;
		
		[Embed(source="../media/graphics/roofObstacle.png")] //50x210
		public static const roofObstacle:Class;
		
		[Embed(source="../media/graphics/redHeart.png")] //34x30
		public static const redHeart:Class;
		
		[Embed(source="../media/graphics/blueHeart.png")] //34x30
		public static const blueHeart:Class;
		
		[Embed(source="../media/graphics/HUD_bg.png")] //940x40
		public static const HUD_bg:Class;
		
		[Embed(source="../media/graphics/shieldItem.PNG")] //40x39
		public static const shieldItem:Class;
		
		[Embed(source="../media/graphics/healItem.png")] //34x30
		public static const healItem:Class;
		
		[Embed(source="../media/graphics/particle.png")] //34x30
		public static const Particle:Class;
		
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