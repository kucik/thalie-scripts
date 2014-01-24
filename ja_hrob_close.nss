void main()
{
    object oWP = GetWaypointByTag("JA_HROB_STRAZCE");

    if(GetLocalInt( oWP, "JA_OPEN") == 10)
        return;

    SetLocalInt(oWP, "JA_OPEN", 0);
}
