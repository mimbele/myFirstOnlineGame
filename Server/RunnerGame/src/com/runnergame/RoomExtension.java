package com.runnergame;

import com.smartfoxserver.v2.SmartFoxServer;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;

public class RoomExtension extends  SFSExtension
{
    public boolean GameStarted;
    @Override
    public void init()
    {
        addEventHandler(SFSEventType.USER_JOIN_ROOM, UserJoinHandler.class);
        GameStarted = false;
    }
}
