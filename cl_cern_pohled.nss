//::///////////////////////////////////////////////
//:: cl_cern_pohled
//:://////////////////////////////////////////////
/*
  Cernokneznik - pohled dabla
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
//#include "sh_classes_inc"
#include "x2_inc_spellhook"


void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSight1 = EffectSeeInvisible();
    effect eSight2 = EffectUltravision();
    effect eLink = EffectLinkEffects(eVis, eSight1);
    eLink = EffectLinkEffects(eLink, eSight2);
    eLink = EffectLinkEffects(eLink, eDur);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(24));
}

