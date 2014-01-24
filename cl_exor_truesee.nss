//::///////////////////////////////////////////////
//:: cl_exor_truesee
//:://////////////////////////////////////////////
/*
  Exorcista - prave videni
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_classes_inc"

void main()
{

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = 10+GetLevelByClass(CLASS_TYPE_EXORCISTA)+GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    effect eSight = EffectSeeInvisible();
    effect eSpot = EffectSkillIncrease(SKILL_SPOT,nDuration);
    effect eLink = EffectLinkEffects(eVis, eSight);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eSpot);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

