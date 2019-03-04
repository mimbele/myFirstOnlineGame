package com.runnergame;

import com.smartfoxserver.v2.SmartFoxServer;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.core.SFSEventType;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.extensions.SFSExtension;

import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

public class RoomExtension extends  SFSExtension
{
    public boolean GameStarted;
    private ScheduledFuture<?> spawner;
    private int ticks;
    @Override
    public void init()
    {
        addEventHandler(SFSEventType.USER_JOIN_ROOM, UserJoinHandler.class);
        GameStarted = false;
        ticks = 0;
    }
    public void StartGame()
    {
        GameStarted = true;
        spawner = getApi().getSystemScheduler().scheduleAtFixedRate(new SpawnObstacles(), 0, 100, TimeUnit.MILLISECONDS);
    }
    public void destroy()
    {
        spawner.cancel(true);
    }
    class SpawnObstacles implements Runnable
    {
    
        @Override
        public void run()
        {
            if (ticks % 10 == 0)
            {
                SFSObject params = new SFSObject();
                params.putFloat("x", (float)Math.random() * 200);
                params.putFloat("speed", 400);
                params.putBool("isroof", Math.random() < 0.5f);
                params.putInt("user", (int)(Math.random()*2)+1);
                params.putLong("time", System.currentTimeMillis());
                try
                {
                    Thread.sleep(200);
                } catch (InterruptedException e)
                {
                    e.printStackTrace();
                }
                send("spawn_obstacle", params, getParentRoom().getPlayersList());
            }
            ticks++;
        }
    }
}
