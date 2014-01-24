//**///////////////////////////////////////////////////////////////////////////
//** LOCK(NESS) v1.0 - onExit script
//**///////////////////////////////////////////////////////////////////////////
//**
//** This script must be installed on the onExit event. Do NOT forget to
//** assign the "lock_onenter" script to the onEnter event !!!
//**
//**///////////////////////////////////////////////////////////////////////////
//** Last modification: 08/01/2005
//** Created by Firya'nis & Ex Tempus.
//**///////////////////////////////////////////////////////////////////////////
/*
 * rev. 24.01.2008 Kucik - vzhled spectry v podsveti
 * rev. 26.01.2008 Kucik - opravy
 */
#include "lock_inc"
#include "sh_classes_inc"
void main()
{
    object oArea = OBJECT_SELF;
    object oPC = GetExitingObject();

    if (!(GetIsPC(oPC) || GetIsDMPossessed(oPC) || GetIsDM(oPC))) return;


    ApplyIndoorHidePenalty(oPC,FALSE);

    /* Natavovani timeru pro vypnuti AI a uklizeni lokace */
    if(!ku_GetIsPCInLocation(OBJECT_SELF)) {
      SetLocalInt(OBJECT_SELF,"ku_last_exit",ku_GetTimeStamp());
      DelayCommand(600.0,ku_SleepArea(OBJECT_SELF));
    }

    ExecuteScript(GetLocalString(OBJECT_SELF, "onexit"), OBJECT_SELF);

    if( (GetTag(OBJECT_SELF)=="Sferamrtvych") && (GetAppearanceType(oPC)==APPEARANCE_TYPE_SPECTRE) && GetIsPC(oPC) && !GetIsDM(oPC) && !GetIsDMPossessed(oPC)){
      SetCreatureAppearanceType(oPC,GetLocalInt(GetSoulStone(oPC),"KU_PC_ALIVE_APPEARANCE"));
      DeleteLocalInt(GetSoulStone(oPC),"KU_PC_ALIVE_APPEARANCE");
      OnLvlupClassSystem(oPC);
    }


    if(GetLocalString(OBJECT_SELF, "ARENA") != ""){//jedna se o arenu
        ExecuteScript("ja_arena_exit", OBJECT_SELF);
        return;
    }

    if(GetLocalInt(OBJECT_SELF, "JA_MESTO") == 1) return; //je mesto - nezadouci spawn

    int TIMER = GetLocalInt(oArea, "LOCK_TIMER");

    // S'active uniquement si la creature qui sort est un DM ou un PJ.
    if (GetIsPC(oPC))
    {

        location lLoc = Location(OBJECT_SELF, Vector(0.0, 0.0, 0.0), 0.0); // Point 0 dans la zone
        object oMore = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, lLoc);
        if (oMore == oPC) oMore = GetNearestCreatureToLocation(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, lLoc, 2);
        float fDelay = 360.0; // 360 seconds * 5 = 30 mins
        if( GetLocalInt( OBJECT_SELF, "JA_LOCK_LONGSPAWN" ) )
            fDelay *= 2.0f;

        //LOCK_Debug("********* Lock_onexit lancé... **********");

        // S'active uniquement s'il ne reste plus de joueur dans la zone.
        if (oMore == OBJECT_INVALID || GetArea(oMore) != OBJECT_SELF) // comme ca on est vraiment sur... <_<
        {
            if (TIMER <= 0){  // -1 ou 0 -> on lance le TIMER
                LOCK_InitCleaningTimer(oArea, fDelay);
//                SpeakString("InitCleaningTimer", TALKVOLUME_SHOUT);
            }
/*            else {            // sinon, le TIMER est deja lance, donc on le remet a 0
                LOCK_ResetCleaningTimer(oArea);
            }*/

        }

    } // Fin GetIsPC(oPC)


}


