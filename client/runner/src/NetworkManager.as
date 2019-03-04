package
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.requests.LeaveRoomRequest;
	import com.smartfoxserver.v2.requests.RoomExtension;
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
		public var in_queue:Boolean = false;
		public var ServerTimeDiff:Number;
		private static var ins:NetworkManager = null;
		
		private var username:String = "";
		private var password:String = "";
		
		function NetworkManager()
		{
			if (ins != null)
				throw new Error("Use .getInstance() instead");
		}
		
		public function SetLoginInfo(username:String, password:String):void
		{
			this.username = username;
			this.password = password;
		}
		
		public function Connect(host:String, port:int):void
		{
			sfs = new SmartFox(false);
			sfs.connect(host, port);
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
		}
		
		public function FindOpponent()
		{
			if (!sfs.isConnected)
				return;
			if (sfs.joinedRooms.length > 0) // already in queue
				return;
			var rooms:Array.<Room> = sfs.roomList;
			var joined = false;
			for each(var room in rooms)
			{
				if (false)
					continue;
				sfs.send(new JoinRoomRequest(room, null, sfs.lastJoinedRoom ? sfs.lastJoinedRoom.id : null, false));
				joined = true;
				break;
			}
			if (!joined)
			{
				// Create room settings
				var roomSettings:RoomSettings = new RoomSettings(sfs.mySelf.name);
				roomSettings.maxUsers = 2;
				roomSettings.maxSpectators = 0;
				roomSettings.extension = new RoomExtension("Runner", "com.runnergame.RoomExtension");
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
			sfs.removeEventListener(SFSEvent.CONNECTION, onConnection);
			if (evt.params.success)
			{
				sfs.send(new LoginRequest(username, password, "BasicExamples", new SFSObject()));
				sfs.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoin);
			}
		}
		
		function onRoomJoin(evt:SFSEvent)
		{
			in_queue = true;
		}
		
		public static function getInstance():NetworkManager
		{
			if (ins == null)
				ins = new NetworkManager();
			return ins;
		}
		public static function getNow():Number
		{
			return (new Date()).time;
		}
	}

}