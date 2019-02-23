package 
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.LoginRequest;
	/**
	 * ...
	 * @author Parhamic
	 */
	public class NetworkManager 
	{
		public var sfs:SmartFox;
		private static var ins:NetworkManager = null;
		
		private var username:String = "";
		private var password:String = "";
		

		function NetworkManager() 
		{
			if (ins != null)
				throw new Error("Use .getInstance() instead");
			sfs = new SmartFox(false);
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
		}
		public function SetLoginInfo(username:String, password:String):void 
		{
			this.username = username;
			this.password = password;
		}
		public function Connect(host:String, port:int):void
		{
			sfs.connect(host, port);
		}
		function onConnection(evt:SFSEvent):void 
		{
			if (evt.params.success)
				sfs.send(new LoginRequest(username, password, "BasicExamples", new SFSObject()));
		}
		
		
		public static function getInstance():NetworkManager 
		{
			if (ins == null)
				ins = new NetworkManager();
			return ins;
		}
	}

}