void main()
{
    object oPCspeaker = GetPCSpeaker();
    object oArea =GetArea(oPCspeaker);
    object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
    int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
    SetFogColor(FOG_TYPE_ALL,iDMSetNumber,oArea);
}
