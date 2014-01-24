void main()
{
    object oPC = GetPCSpeaker();
    int iPay = GetLocalInt(OBJECT_SELF,"SH_DLG_PAY_03");
    string sAfterPayScript = GetLocalString(OBJECT_SELF,"SH_DLG_PAY_03_SCRIPT");
    if (GetGold(oPC)>= iPay)
    {
        TakeGoldFromCreature(iPay,oPC);
        ExecuteScript(sAfterPayScript,OBJECT_SELF);
    }

}
