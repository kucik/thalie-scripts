#include "x2_inc_spellhook"
#include "x0_i0_spells"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(448);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,iCasterLevel,FALSE);
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(iCasterLevel*2, DAMAGE_BONUS_1d6, DAMAGE_TYPE_NEGATIVE);
    effect eDur = EffectVisualEffect(463);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    // 2003-07-07: Stacking Spell Pass, Georg
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(30));
}

