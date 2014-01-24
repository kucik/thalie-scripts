void main()
{
    object oPC = GetPCSpeaker();
    int iPay = GetLocalInt(OBJECT_SELF,"SH_DLG_PAY_05");
    string sAfterPayScript = GetLocalString(OBJECT_SELF,"SH_DLG_PAY_05_SCRIPT");
    if (GetGold()>= iPay)
    {
        TakeGoldFromCreature(iPay,oPC);
        ExecuteScript(sAfterPayScript,OBJECT_SELF);
    }

}
