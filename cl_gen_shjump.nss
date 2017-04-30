void main()
{
    object oPC = OBJECT_SELF;
    if(GetStealthMode(oPC)==STEALTH_MODE_ACTIVATED)
    {
        location lTarget = GetSpellTargetLocation();
        effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
        AssignCommand(OBJECT_SELF,DelayCommand(0.5,ActionJumpToLocation(lTarget)));
    }
    else
    {
        SendMessageToPC(oPC,"Nelze pouzit - nejsi v modu ukryti.");
    }
}
