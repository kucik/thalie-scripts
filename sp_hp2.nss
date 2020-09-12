
#include "x2_inc_spellhook"
#include "sh_deity_inc"

void main()
{
    // End of Spell Cast Hook

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eHP;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    float fDuration = TurnsToSeconds(3);

    //Set the ability bonus effect
    eHP = EffectTemporaryHitpoints(GetMaxHitPoints());
    effect eLink = EffectLinkEffects(eHP, eDur);

    //Appyly the VFX impact and ability bonus effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
