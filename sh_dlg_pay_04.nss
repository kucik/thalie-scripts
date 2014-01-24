void main()
{
    object oPC = GetPCSpeaker();
    int iPay = GetLocalInt(OBJECT_SELF,"SH_DLG_PAY_04");
    string sAfterPayScript = GetLocalString(OBJECT_SELF,"SH_DLG_PAY_04_SCRIPT");
    if (GetGold(oPC)>= iPay)
    {
        TakeGoldFromCreature(iPay,oPC);
        ExecuteScript(sAfterPayScript,OBJECT_SELF);
    }

}
