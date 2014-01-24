//::///////////////////////////////////////////////
//:: cl_cern_clopro
//:://////////////////////////////////////////////
/*
   Tajemny vybuch cernokneznika - paprsek.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

#include "X0_I0_SPELLS"
//:://////////////////////////////////////////////


void main()
{

    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly = EffectPolymorph(107);

    //Apply the VFX impact and effects
    AssignCommand(oTarget, ClearAllActions()); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, TurnsToSeconds(10));
}

