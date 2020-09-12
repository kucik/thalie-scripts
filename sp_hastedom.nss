//::///////////////////////////////////////////////
//:: Haste
//:: NW_S0_Haste.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the targeted creature one extra partial
    action per round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 29, 2001
//:://////////////////////////////////////////////
// Modified March 2003: Remove Expeditious Retreat effects

#include "x0_i0_spells"

#include "x2_inc_spellhook"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();

    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect(647, oTarget) == TRUE)
    {
        RemoveSpellEffects(647, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect(SPELL_MASS_HASTE, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_MASS_HASTE, OBJECT_SELF, oTarget);
    }


    effect eHaste = EffectHaste();
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 5 + GetAbilityModifier(ABILITY_CHARISMA);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
    //Check for metamagic extension
    // Apply effects to the currently selected target.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


