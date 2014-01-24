object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
location Ltarget = GetLocation(oPCspeaker);

object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
object oTarget2 = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, Ltarget,iDMSetNumber);

void main()
{
SetLocalObject(oPCspeaker,"dmfi_univ_target",oTarget2);
}

