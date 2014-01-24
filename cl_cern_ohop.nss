//::///////////////////////////////////////////////
//:: cl_cern_ohop
//:://////////////////////////////////////////////
/*
   Cernokneznik - ohniva opona.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

#include "X0_I0_SPELLS"
//:://////////////////////////////////////////////

void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare Area of Effect object using the appropriate constant
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE,"cl_cern_ohopa","cl_cern_ohopc","****");
    //Get the location where the wall is to be placed.
    location lTarget = GetSpellTargetLocation();

    //Create the Area of Effect Object declared above.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(3));
}
