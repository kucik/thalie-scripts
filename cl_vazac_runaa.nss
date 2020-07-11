void main()
{
    object oTarget = GetEnteringObject();
    effect eDamage = EffectDamage(d6(20));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);

}
