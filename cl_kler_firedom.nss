//::///////////////////////////////////////////////
//:: Vzduch - domena
//:: cl_kler_airdom
//::///////////////////////////////////////////////
/*
    Prida 100% imunitu na elektrinu.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:://////////////////////////////////////////////
#include "nw_i0_spells"

#include "x2_inc_spellhook"

void main()
{

    object oTarget = GetSpellTargetObject();
    //Declare major variables
    int nDuration = GetAbilityModifier(ABILITY_CHARISMA)+5;
    effect eElem = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);

    //Link Effects
    effect eLink = EffectLinkEffects(eElem, eDur);
    effect eRay = EffectBeam(VFX_BEAM_FIRE_W, OBJECT_SELF, BODY_NODE_HAND);


    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}

