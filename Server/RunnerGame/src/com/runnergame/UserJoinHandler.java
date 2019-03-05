package com.runnergame;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.entities.Room;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;

import java.util.concurrent.TimeUnit;

public class UserJoinHandler extends BaseServerEventHandler
{
    
    @Override
    public void handleServerEvent(ISFSEvent isfsEvent) throws SFSException
    {
        RoomExtension roomExt = (RoomExtension) getParentExtension();
        Room room = roomExt.getParentRoom();
        if (room.getPlayersList().size() == 1)
        {
            send("start_game", new SFSObject(), room.getPlayersList());
            roomExt.StartGame();
        }
    }
}
