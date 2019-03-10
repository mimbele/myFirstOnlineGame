package com.runnergame;

import com.smartfoxserver.v2.core.ISFSEvent;
import com.smartfoxserver.v2.core.SFSEventParam;
import com.smartfoxserver.v2.db.IDBManager;
import com.smartfoxserver.v2.entities.data.ISFSArray;
import com.smartfoxserver.v2.entities.data.ISFSObject;
import com.smartfoxserver.v2.entities.data.SFSObject;
import com.smartfoxserver.v2.exceptions.SFSErrorCode;
import com.smartfoxserver.v2.exceptions.SFSErrorData;
import com.smartfoxserver.v2.exceptions.SFSException;
import com.smartfoxserver.v2.exceptions.SFSLoginException;
import com.smartfoxserver.v2.extensions.BaseServerEventHandler;
import com.smartfoxserver.v2.extensions.ExtensionLogLevel;

import java.sql.SQLException;

public class LoginEventHandler extends BaseServerEventHandler
{
    private String generateRandomToken()
    {
        StringBuilder token = new StringBuilder();
        for (int i = 0; i < 16; i++)
        {
            token.append((char)('a'+(int)(Math.random()*28)));
        }
        return token.toString();
    }
    @Override
    public void handleServerEvent(ISFSEvent event) throws SFSException
    {
        String name = (String) event.getParameter(SFSEventParam.LOGIN_NAME);
        SFSObject inData = (SFSObject) event.getParameter(SFSEventParam.LOGIN_IN_DATA);
        ISFSObject outData = (ISFSObject) event.getParameter(SFSEventParam.LOGIN_OUT_DATA);
        trace("LOOGIIIN");
        IDBManager db = getParentExtension().getParentZone().getDBManager();
        String sql = "SELECT * FROM users WHERE username='"+name+"'";
        ISFSArray res = null;
        try
        {
            res = db.executeQuery(sql, new Object[]{});
        }
        catch (SQLException e)
        {
            trace(ExtensionLogLevel.WARN, "SQL Failed: " + e.toString());
        }
        // user exists
        if (res != null && res.size() > 0)
        {
            ISFSObject usr = res.getSFSObject(0);
            String authtoken = inData.getUtfString("authtoken");
            if (!usr.getUtfString("authtoken").equals(authtoken)) // invalid
            {
                SFSErrorData errData = new SFSErrorData(SFSErrorCode.LOGIN_BAD_PASSWORD);
                errData.addParameter(authtoken);
                throw new SFSLoginException("Invalid token", errData);
            }
        }
        else // register user
        {
            String authtoken = generateRandomToken();
            sql = "INSERT INTO users (username, authtoken) VALUES ('"+name+"', '"+authtoken+"')";
    
            try {
                db.executeUpdate(sql, new Object[] {});
            } catch (SQLException e) { e.printStackTrace(); }
    
            outData.putUtfString("authtoken", authtoken);
        }
    }
}