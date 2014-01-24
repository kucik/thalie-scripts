int StartingConditional()
{
    int iPay = GetLocalInt(OBJECT_SELF,"SH_DLG_PAY_05");
    if (iPay==0) return FALSE;
    int iResult;
    iResult = (GetGold()>= iPay);
    return iResult;
}
