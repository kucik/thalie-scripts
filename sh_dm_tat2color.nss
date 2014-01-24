object oDM =GetPCSpeaker();
object oTarget = GetLocalObject(oDM, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oDM);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
SetColor(oTarget,COLOR_CHANNEL_TATTOO_2,iDMSetNumber);
}
