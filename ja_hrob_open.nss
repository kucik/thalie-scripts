void main()
{
    object oWP = GetWaypointByTag("JA_HROB_STRAZCE");

    if(GetLocalInt( oWP, "JA_OPEN") == 10)
        return;

    if(GetLocalInt( oWP, "JA_OPEN") == 1){
        CreateObject( OBJECT_TYPE_CREATURE, "doomkghtboss002", GetLocation(oWP), TRUE );
        effect eSum = EffectVisualEffect( VFX_FNF_SUMMON_EPIC_UNDEAD );
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSum, GetLocation(oWP));
        SetLocalInt( oWP, "JA_OPEN", 10 );
    }
    else{
        SetLocalInt( oWP, "JA_OPEN", 1 );
    }
}
