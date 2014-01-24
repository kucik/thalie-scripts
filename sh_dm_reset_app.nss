object oPCspeaker = GetPCSpeaker();
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
int iO_tail =GetLocalInt(oTarget,"O_tail");
int iO_app =GetLocalInt(oTarget,"O_App");
void main()
{
SetCreatureTailType(iO_tail,oTarget);
SetCreatureAppearanceType(oTarget,iO_app);
}
