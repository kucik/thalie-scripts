//unlock dc

object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
SetLockUnlockDC(oTarget,iDMSetNumber);

}

