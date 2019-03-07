package 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Parhamic
	 */
	public class UserPrefs 
	{		
		public var username:String;
		public var authtoken:String;
		
		function UserPrefs()
		{
			username = "";
			authtoken = "";
		}
		
		public static function Load():UserPrefs
		{
			var _so = SharedObject.getLocal("runner-game");
			var up:UserPrefs = new UserPrefs();
			if (_so.data.username)
				up.username = _so.data.username;
			if (_so.data.authtoken)
				up.authtoken = _so.data.authtoken;
			return up;
		}
		public function Save()
		{
			var _so = SharedObject.getLocal("runner-game");
			_so.data.username = username;
			_so.data.authtoken = authtoken;
			_so.flush();
		}
	}

}