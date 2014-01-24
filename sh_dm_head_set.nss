object oPCspeaker = GetPCSpeaker();
string sDMstring = GetLocalString(oPCspeaker,"DMstring");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
void main()
{
SetCreatureBodyPart(CREATURE_PART_HEAD,iDMSetNumber,oTarget);
}
