object oPCspeaker =GetPCSpeaker();
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
SetLocalInt(oCheck,"Itemproperty",iDMSetNumber);
}
