void main()
{

    //Declare major variables
    object oPC=OBJECT_SELF;
    int iLevel  = GetHitDice(oPC);
    int iCon    = GetAbilityModifier(ABILITY_WISDOM,oPC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eFear = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eMind = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eLink = EffectLinkEffects(eFear, eMind);
    eLink = EffectLinkEffects(eLink, eDur);
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(iLevel+iCon));
}
