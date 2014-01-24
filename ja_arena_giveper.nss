#include "ja_variables"
#include "aps_include"

string GetPersistentStringByName(string sPlayer, string sTag, string sVarName, string sTable="pwdata")
{

    sPlayer = SQLEncodeSpecialChars(sPlayer);
    sTag = SQLEncodeSpecialChars(sTag);


    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
               "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return "";
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }
}

void SetPersistentStringByName(string sPlayer, string sTag, string sVarName, string sValue, int iExpiration=0, string sTable="pwdata")
{
/*    string sPlayer = GetLocalString(oObject, "PLAYERNAME");
    string sTag = GetLocalString(oObject, "NAME");*/


    sPlayer = SQLEncodeSpecialChars(sPlayer);
    sTag = SQLEncodeSpecialChars(sTag);

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
                  "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);
    //WriteTimestampedLogEntry("SQL: "+sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
               "',expire=" + IntToString(iExpiration) + " WHERE player='"+ sPlayer +
               "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
               "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
               sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    if (GetGold(oPC) >= 250) {
        TakeGoldFromCreature(250, oPC);
        string sArena = GetLocalString(OBJECT_SELF, "TICKET_NAME");
        SetLocalString(oPC, v_ArenaPermission, sArena);
        /* Uprava pro hracskou arenu */
        if(sArena == "ry_karakv2") {
          string sPlayer = "Xantipa";
          string sTag = " Zoe";
          int igold = StringToInt(GetPersistentStringByName(sPlayer, sTag, "GOLD"));
          SetPersistentStringByName(sPlayer, sTag, "GOLD", IntToString(igold + 250));
        }
        /* ~ konec upravy */
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}
