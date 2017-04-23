void main()
{
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
    AssignCommand(OBJECT_SELF,DelayCommand(2.0,ActionJumpToLocation(lTarget)));
    DelayCommand(1.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget));

}
