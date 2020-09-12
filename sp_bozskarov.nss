//::///////////////////////////////////////////////
//:: Shield
//:: x0_s0_shield.nss

#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{
    if (GetLevelByClass(CLASS_TYPE_MONK)>0) return;
    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    int nMetaMagic = GetMetaMagicFeat();

    int iBonus = GetAbilityModifier(ABILITY_WISDOM);
    effect eArmor = EffectACIncrease(iBonus);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);

    effect eLink = EffectLinkEffects(eArmor, eDur);


    int nDuration = 5 + GetAbilityModifier(ABILITY_CHARISMA);

    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}



