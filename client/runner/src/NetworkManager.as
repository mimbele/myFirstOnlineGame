package
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;
	import com.smartfoxserver.v2.requests.RoomSettings;
	import com.smartfoxserver.v2.requests.CreateRoomRequest;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	
	/**
	 * ...
	 * @author Parhamic
	 */
	public class NetworkManager
	{
		public var sfs:SmartFox;
		public static var in_queue:Boolean = false;
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
		
		public function FindOpponent()
		{
			if (sfs.joinedRooms.length > 0) // already in queue
				return;
			var rooms:Array.<Room> = sfs.roomList;
			var joined = false;
			for (var room:Room in rooms)
			{
				if (false)
					continue;
				sfs.send(new JoinRoomRequest(room, null, sfs.lastJoinedRoom.id, false));
				joined = true;
			}
			if (!joined)
			{
				// Create room settings
				var roomSettings:RoomSettings = new RoomSettings(sfs.mySelf.name);
				roomSettings.maxUsers = 2;
				roomSettings.maxSpectators = 0;
				roomSettings.isGame = true;
				
				// Create new game room with above parameters and join it
				sfs.send(new CreateRoomRequest(roomSettings, true, sfs.lastJoinedRoom));
			}
		}
		public function CancelFind()
		{
			sfs.send (new LeaveRoomRequest(sfs.lastJoinedRoom));
			in_queue = false;
		}
		
		function onConnection(evt:SFSEvent):void
		{
			if (evt.params.success)
				sfs.send(new LoginRequest(username, password, "BasicExamples", new SFSObject()));
			sfs.removeEventListener(SFSEvent.CONNECTION, onConnection);
		}
		
		public static function getInstance():NetworkManager
		{
			if (ins == null)
				ins = new NetworkManager();
			return ins;
		}
	}

}