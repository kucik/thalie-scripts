//::///////////////////////////////////////////////
//:: True Seeing
//:: NW_S0_TrueSee.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The creature can seen all invisible, sanctuared,
    or hidden opponents.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: [date]
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"
#include "sh_deity_inc"
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDark = EffectUltravision();
    effect eSkill = EffectSkillIncrease(SKILL_SPOT,12);
    effect eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eDark);
    eLink = EffectLinkEffects(eLink, eSkill);
    eLink= EffectLinkEffects(eLink,EffectSeeInvisible());

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));


    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    if (GetHasFeat(FEAT_EPIC_SPELL_FOCUS_DIVINATION))
    {
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTrueSeeing(), oTarget, RoundsToSeconds(3));
    }
}

