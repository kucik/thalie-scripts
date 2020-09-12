#include "ja_inc_frakce"
#include "sh_effects_const"

void __teleportMeToWorld(object oPC, location lLoc) {

  // Doubleclick block
  if(GetLocalInt(oPC,"ku_teleport_ran")) {
    DeleteLocalInt(oPC,"ku_teleport_ran");
    return;
  }

  // checkif teleport failed
  if(GetLocalInt(oPC,"ku_teleport_send")) {
    // So make log and send him to startplace
    WriteTimestampedLogEntry("ERROR: Failedto send player "+GetPCPlayerName(oPC)+" with char "+GetName(oPC)+" to loc '"+NWNX_LocationToString(lLoc)+"'.");
    // and send player to CHRAM
    object wpRaise = GetWaypointByTag(GetLocalString(oPC, "CHRAM"));
    AssignCommand(oPC, JumpToObject(wpRaise));
    DeleteLocalInt(oPC,"ku_teleport_send");
    return;
  }

  // First try to jump. Nothing special so far


  // Mark PC to catch doubleclick
  SetLocalInt(oPC,"ku_teleport_ran",TRUE);
  DelayCommand(1.0,DeleteLocalInt(oPC,"ku_teleport_ran"));

  // Mark PCto know we tried teleport
  SetLocalInt(oPC, "ku_teleport_send", TRUE);
  DelayCommand(30.0,DeleteLocalInt(oPC,"ku_teleport_send"));


  //Try to jump
  AssignCommand(oPC,ActionJumpToLocation(lLoc));
}

void main()
{
    object oPC = GetLastUsedBy();
    object oSoul = GetSoulStone(oPC);
    int iPlayed = GetLocalInt(oSoul, "PLAYED");
    location lLoc;
    //Test na 30. level
    int iHD = GetHitDice(oPC);
    if (iHD>30)
    {
       SendMessageToPC(oPC,"Do sveta jsou pousteny jen postavy s urovni do 30.");
       return;
    }
    if (GetLocalInt(oSoul,AKTIVNI_RAGE) == 1)
    {
       SendMessageToPC(oPC,"Postavy se zapnutou zurivosti nebudou pusteny do sveta. Pozadej o DM relevel");
       return;
    }
    if (GetLocalInt(oSoul,AKTIVNI_POSTOJ_OBRANCE) == 1)
    {
       SendMessageToPC(oPC,"Postavy se zapnutym postojem nebudou pusteny do sveta. Pozadej o DM relevel");
       return;
    }



    if(iPlayed)
    {
        lLoc = GetPersistentLocation(oPC, "LOCATION");
        if (GetIsObjectValid(GetAreaFromLocation(lLoc)))
        {
            if (GetTag(GetAreaFromLocation(lLoc))=="th_vitejte")
            {
                if (Subraces_GetIsCharacterFromUnderdark(oPC))
                {
                    object oWP = GetObjectByTag("CHRAM_XIAN_CHARAS");
                    AssignCommand(oPC,ActionJumpToObject(oWP));

                }
                else
                {
                    object oWP = GetObjectByTag("CHRAM_JUANA_KARATHA");
                    AssignCommand(oPC,ActionJumpToObject(oWP));
                }
            }
            //AssignCommand(oPC,ActionJumpToLocation(lLoc));
            __teleportMeToWorld(oPC, lLoc);
        }
        else
        {
            SendMessageToPC(oPC,"Vase postava neni schvalena, nepustim vas dale.");
        }
    }
    else
    {
        lLoc = GetLocation(GetObjectByTag("DST_thstart_isl1"));
    }
    AssignCommand(oPC,ActionJumpToLocation(lLoc));
}
