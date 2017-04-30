void main()
{

    //Declare major variables
    object oPC=OBJECT_SELF;
    int iLevel  = GetHitDice(oPC);
    int iCon    = GetAbilityModifier(ABILITY_CONSTITUTION,oPC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    effect eKnockDown = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);

    effect eLink = EffectLinkEffects(eKnockDown, eDur);
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(iLevel+iCon));
}
