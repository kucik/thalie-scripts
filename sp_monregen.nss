//::///////////////////////////////////////////////
//:: Monstrous Regeneration
//:: X2_S0_MonRegen
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants the selected target 3 HP of regeneration
    every round.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 25, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 09, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "sh_deity_inc"

void main()
{


    //--------------------------------------------------------------------------
    // Spellcast Hook Code
    // Added 2003-06-20 by Georg
    // If you want to make changes to all spells, check x2_inc_spellhook.nss to
    // find out more
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook


    object oTarget = GetSpellTargetObject();

    /* Bug fix 21/07/03: Andrew. Lowered regen to 3 HP per round, instead of 10. */

    int iRegen = 3;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);


    int nMeta = GetMetaMagicFeat();
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel);
    int nLevel = (iCasterLevel/2)+1;

    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    if (nMeta == METAMAGIC_EMPOWER)
    {
        iRegen *= 2;
    }
    effect eRegen = EffectRegenerate(iRegen, 6.0);
    effect eLink = EffectLinkEffects(eRegen, eDur);
    // Stacking Spellpass, 2003-07-07, Georg   ... just in case
    RemoveEffectsFromSpell(oTarget, SPELL_REGENERATE);
    RemoveEffectsFromSpell(oTarget, SPELL_MONSTROUS_REGENERATION);


    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply effects and VFX
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}
