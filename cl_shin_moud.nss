//::///////////////////////////////////////////////
//:: cl_shin_moud
//:://////////////////////////////////////////////
/*
   Shinobiho moudrost
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_classes_const"
void main()
{
     //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);



    int nRaise = 4;
    int nDuration = GetLevelByClass(CLASS_TYPE_SHINOBI)+10;

     //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_WISDOM, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_OWLS_WISDOM, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}
