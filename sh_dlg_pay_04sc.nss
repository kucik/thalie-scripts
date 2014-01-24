int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPay = GetLocalInt(OBJECT_SELF,"SH_DLG_PAY_04");
    if (iPay==0) return FALSE;
    int iResult;
    iResult = (GetGold(oPC)>= iPay);
    return iResult;
}
