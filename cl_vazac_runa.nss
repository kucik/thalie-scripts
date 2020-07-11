void main()
{
    object oPC = OBJECT_SELF;
    location lTargetLocation = GetSpellTargetLocation();
    int iCurrentPeriod = GetLocalInt(GetModule(), "TIME");
    int iLastUse =   GetLocalInt(oPC, "LAST_USE_RUNE");
    if (iCurrentPeriod <= (iLastUse+50))
    {
        SendMessageToPC(oPC,"Runu bude mozne pouzit az za "+IntToString((50-(iCurrentPeriod-iLastUse))*6) +" sekund.");
        return;
    }

    effect eRune = EffectAreaOfEffect(38,"cl_vazac_runaa");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eRune,lTargetLocation,TurnsToSeconds(20));
    SetLocalInt(oPC, "LAST_USE_RUNE",iCurrentPeriod);

}
