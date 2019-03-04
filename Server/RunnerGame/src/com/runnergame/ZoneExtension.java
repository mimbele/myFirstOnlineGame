package com.runnergame;

import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.extensions.SFSExtension;

public class ZoneExtension extends SFSExtension
{
    
    @Override
    public void init()
    {
        addEventHandler(SFSEventType.USER_LOGIN, LoginEventHandler.class);
        addRequestHandler("ping", PingHandler.class);
    }
}
