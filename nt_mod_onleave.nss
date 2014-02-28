#include "ja_lib"
#include "ku_exp_time"
#include "tc_constants"
#include "ku_ether_inc"

void main()
{
  object oPC = GetExitingObject();
 /* DM */
  if(GetIsDM(oPC)) {
   string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
   SetLocalInt(OBJECT_SELF,"DM_LAST_LOGOUT_"+Player,ku_GetTimeStamp());
   AssignCommand(oPC, JumpToLocation(GetStartingLocation()));
   return;
 }

 ku_StoreXPToDB(oPC);


 /*if(GetIsDM(oPC)){
    WriteTimestampedLogEntry("DM just left");
    return;
 } */

 //WriteTimestampedLogEntry("onleave: "+GetName(oPC)+" is pc?:"+IntToString(GetIsPC(oPC)));

 SavePlayer(oPC);

//Alchymie
    object oSoulStone = GetSoulStone(oPC);
    int iAlchemyXP = GetLocalInt(oSoulStone, TC_XP_PREFIX  + IntToString(TC_ALCHEMY));

    if( iAlchemyXP != 0)
    {
        SetPersistentInt(oPC, TC_XP_PREFIX + IntToString(TC_ALCHEMY),iAlchemyXP);
    }
//~Alchymie

// Save XP and GOLD to DB
 SetPersistentInt(oPC,"XP_BACKUP",GetXP(oPC));
 SetPersistentInt(oPC,"GOLD_BACKUP",GetGold(oPC));
 SetLocalInt(oSoulStone,"LOGED_OUT",1);
//~Save XP and GOLD to DB

 int iID = GetLocalInt(oPC, "JA_DUMP_ID");
 string sql = "DELETE FROM dump WHERE id="+IntToString(iID)+";";
 SQLExecDirect(sql);
 ku_EtherealClientLeave(oPC);
}

