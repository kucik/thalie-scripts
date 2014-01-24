int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPrice = GetLocalInt(oPC, "JA_RESSURECT_PRICE");
    return  (GetGold(oPC) >= iPrice);
}
