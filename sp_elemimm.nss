#include "sh_deity_inc"


void main()
{





    //Declare major variables
    int nDuration = 5 + GetAbilityModifier(ABILITY_CHARISMA);
    effect ef;
    if (GetHasDomain(OBJECT_SELF, DOMAIN_VZDUCH))
    {
        ef = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100);
    }
    if (GetHasDomain(OBJECT_SELF, DOMAIN_ZEME))
    {
        ef = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100);
    }
    if (GetHasDomain(OBJECT_SELF, DOMAIN_OHEN))
    {
        ef = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,100);
    }
    if (GetHasDomain(OBJECT_SELF, DOMAIN_VODA))
    {
        ef = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100);
    }


    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 985, FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(ef, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = ExtraordinaryEffect(eLink);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
}
