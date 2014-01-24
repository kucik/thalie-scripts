//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT4
/*
  Default OnConversation event handler for NPCs.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"
#include "hss_inc_armour"

void main()
{
    // * if petrified, jump out
    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // * If dead, exit directly.
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
        return;
    }

    // See if what we just 'heard' matches any of our
    // predefined patterns
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();

    if (nMatch == -1)
    {
        // Not a match -- start an ordinary conversation
        if (GetCommandable(OBJECT_SELF))
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            BeginConversation();
        }
        else
        // * July 31 2004
        // * If only charmed then allow conversation
        // * so you can have a better chance of convincing
        // * people of lowering prices
        if (GetHasEffect(EFFECT_TYPE_CHARMED) == TRUE)
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            BeginConversation();
        }
    }
    /*>>>>>>>>>>>>>>>>>>__ARMOUR DESIGNER CODE__<<<<<<<<<<<<<<<<<<*/
                                  /*Heed*/

   HSS_ArmourOnConversationRoutine(nMatch);

                                  /*Heed*/
     /*>>>>>>>>>>>>>>>>>>__ARMOUR DESIGNER CODE__<<<<<<<<<<<<<<<<<<*/

}




