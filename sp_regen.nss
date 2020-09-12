//::///////////////////////////////////////////////
//:: Regenerate
//:: NW_S0_Regen
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants the selected target 6 HP of regeneration
    every round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
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
    int iRegen = 6;
    int nMeta = GetMetaMagicFeat();
    int nLevel = GetCasterLevel(OBJECT_SELF);
    nLevel = GetThalieCaster(OBJECT_SELF,oTarget,nLevel);
    //Meta-Magic Checks
    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    if (nMeta == METAMAGIC_EMPOWER)
    {
        iRegen = 9;
    }

    effect eRegen = EffectRegenerate(iRegen, 6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eRegen, eDur);

    RemoveEffectsFromSpell(oTarget, SPELL_REGENERATE);
    RemoveEffectsFromSpell(oTarget, SPELL_MONSTROUS_REGENERATION);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REGENERATE, FALSE));
    //Apply effects and VFX
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nLevel)/2.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}
