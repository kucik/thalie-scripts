void main()
{
object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
SetFogAmount(FOG_TYPE_ALL,iDMSetNumber);
}
