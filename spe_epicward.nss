//::///////////////////////////////////////////////
//:: Epic Ward
//:: X2_S2_EpicWard.
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the caster invulnerable to damage
    (equals damage reduction 50/+20)
    Lasts 1 round per level

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: Aug 12, 2003
//:://////////////////////////////////////////////


#include "nw_i0_spells"

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
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    effect eDur = EffectVisualEffect(495);
    effect eProt = EffectDamageReduction(30, DAMAGE_POWER_PLUS_TWENTY,50*iCasterLevel);
    effect eLink = EffectLinkEffects(eDur, eProt);
    eLink = EffectLinkEffects(eLink, eDur);

    // * Brent, Nov 24, making extraodinary so cannot be dispelled
    eLink = ExtraordinaryEffect(eLink);

    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(24));

}
