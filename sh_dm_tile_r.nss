
object oPCspeaker = GetPCSpeaker();
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");

void main()
{
SetLocalInt(oCheck, "TileR",iDMSetNumber);
SetLocalInt(oPCspeaker, "sh_dm_univ_int", GetLocalInt(oPCspeaker, "sh_dm_univ_int")/10);
}
