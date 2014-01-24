void main()
{
    object oPCspeaker = GetPCSpeaker();
    object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
    int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
    SetLocalInt(oCheck,"DMSetNumber",iDMSetNumber-100);
}
