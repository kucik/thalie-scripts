


void main()
{
object oPCspeaker = GetPCSpeaker();
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
SetLocalInt(oCheck, "TileC",iDMSetNumber);
SetLocalInt(oPCspeaker, "sh_dm_univ_int", GetLocalInt(oPCspeaker, "sh_dm_univ_int")/10);
}
