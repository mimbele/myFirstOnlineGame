package com.runnergame;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;

public class RoomExtension extends  SFSExtension
{
    
    @Override
    public void init()
    {
        addEventHandler(SFSEventType.USER_JOIN_ROOM, UserJoinHandler.class);
    }
}
