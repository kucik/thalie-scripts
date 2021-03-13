//::///////////////////////////////////////////////
//:: Invisibility
//:: NW_S0_Invisib.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature becomes invisibility
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);

    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);

    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int iConcealment = 30;

    effect eCover = EffectConcealment(iConcealment);
    effect eLink = EffectLinkEffects(eDur, eCover);
    eLink = EffectLinkEffects(eLink, eVis);

    int nDuration = GetHitDice(OBJECT_SELF);



    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, TurnsToSeconds(nDuration));
}

