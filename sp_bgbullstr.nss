/////////////////////////////////////////////////
// Bull's Strength
//-----------------------------------------------
// Created By: Brenon Holmes
// Created On: 10/12/2000
// Description: This script changes someone's strength
// Updated 2003-07-17 to fix stacking issue with blackguard
/////////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "sh_deity_inc"

void main()
{


    // End of Spell Cast Hook

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eStr;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    nCasterLvl = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLvl);
    int nModify = d4()+1;
    float fDuration = TurnsToSeconds(nCasterLvl);
    int iBG = GetLevelByClass(31, OBJECT_SELF); // Heretic
    //Signal the spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BULLS_STRENGTH, FALSE));


    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);


    eStr = EffectAbilityIncrease(ABILITY_STRENGTH,nModify);
    effect eLink = EffectLinkEffects(eStr, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(iBG));

}
