//::///////////////////////////////////////////////
//:: cl_cern_pnesp
//:://////////////////////////////////////////////
/*
   Cernokneznik - projdi nespatren
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


    object oTarget = OBJECT_SELF;
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eInvis, eDur);
    //eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 885, FALSE)); //FEAT_CERNOKNEZNIK_INVOKACE3_PROJDI_NESPATREN
     //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(24));

}
