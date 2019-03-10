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
    @Override
    public void init()
    {
        addEventHandler(SFSEventType.USER_JOIN_ROOM, UserJoinHandler.class);
        GameStarted = false;
    }
    public void StartGame()
    {
        GameStarted = true;
        spawner = getApi().getSystemScheduler().scheduleAtFixedRate(new SpawnObstacles(), 0, 100, TimeUnit.MILLISECONDS);
    }
    public void destroy()
    {
        if (spawner != null)
            spawner.cancel(true);
    }
    class SpawnObstacles implements Runnable
    {
        private int ticks;
        private int obstacles_count;
        private int spawnTurn;
        SpawnObstacles()
        {
            ticks = 0;
            spawnTurn = 1;
            obstacles_count = 0;
        }
        @Override
        public void run()
        {
            if (ticks % 7 == 0)
            {
                SFSObject params = new SFSObject();
                params.putFloat("x", (float)Math.random() * 200);
                params.putFloat("speed", 400);
                params.putBool("isroof", Math.random() < 0.5f);
                params.putInt("user", spawnTurn);
                params.putLong("time", System.currentTimeMillis());
                params.putInt("id", obstacles_count++);
                params.putUtfString("item", Math.random() < 0.5f ? (int)(Math.random()*2) < 1 ? "SHIELD" : "HEAL" : "");
                send("spawn_obstacle", params, getParentRoom().getPlayersList());
                
                spawnTurn = 3 - spawnTurn;
            }
            ticks++;
        }
    }
}
