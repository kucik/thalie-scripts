int StartingConditional()
{
    object oPortal = GetNearestObjectByTag( "JA_CHRAM2_PORTAL" );

    int iAge   = GetLocalInt( oPortal, "JA_CHRAM2_AGE" );
    int iFirst = GetLocalInt( oPortal, "JA_CHRAM2_FIRST" );

    SetCustomToken( 9111, IntToString(iAge-iFirst) );
    SetCustomToken( 9112, FloatToString( IntToFloat(iAge) / IntToFloat(iFirst) ) );

    return TRUE;
}
