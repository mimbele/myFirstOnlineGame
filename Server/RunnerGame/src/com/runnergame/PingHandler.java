package com.runnergame;


import com.smartfoxserver.v2.entities.User;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.BaseClientRequestHandler;

public class PingHandler extends BaseClientRequestHandler
{
    @Override
    public void handleClientRequest(User user, ISFSObject params)
    {
        SFSObject res = new SFSObject();
        res.putLong("time", System.currentTimeMillis());
        try
        {
            Thread.sleep(200);
        } catch (InterruptedException e)
        {
            e.printStackTrace();
        }
        send("ping", res, user);
    }
}