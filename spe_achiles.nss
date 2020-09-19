#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSpell = EffectSpellLevelAbsorption(9, 0);
    effect eSpell2 = EffectSpellFailure();
    //Link Effects
    effect eLink = EffectLinkEffects(eVis, eSpell);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eSpell2);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration,FALSE);
    if (nDuration>35)
    {
        nDuration = 35;
    }
    int nMetaMagic = GetMetaMagicFeat();
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GLOBE_OF_INVULNERABILITY, FALSE));

   //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

