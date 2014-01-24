//::///////////////////////////////////////////////
//:: Associate: On Spawn In
//:: NW_CH_AC9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////
// by to malo nastavit menu a zakladne spravanie mulice

#include "X0_INC_HENAI"

void main()
{
    SetAssociateListenPatterns();//Sets up the special henchmen listening patterns

    bkSetListeningPatterns();      // Goes through and sets up which shouts the NPC will listen to.

    SetAssociateState(NW_ASC_POWER_CASTING,FALSE);
    SetAssociateState(NW_ASC_HEAL_AT_50,FALSE);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS,FALSE);
    SetAssociateState(NW_ASC_DISARM_TRAPS,FALSE);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE); //User ranged weapons by default if true.
    SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    SetLocalInt(OBJECT_SELF, "X0_L_NOTALLOWEDTOHAVEINVENTORY", 10) ;
    SetAssociateStartLocation();
}


