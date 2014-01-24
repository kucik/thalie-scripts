
object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");

location Ltarget = GetLocalLocation(oPCspeaker, "dmfi_univ_location");
void main()
{
 if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
                {
                oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, Ltarget);
                SendMessageToPC(oPCspeaker,"You did not target a placable, so using placable closet to you were you targeted");
                }


int iGuseable =GetUseableFlag(oTarget);
if(iGuseable == TRUE)
{
SetUseableFlag(oTarget,FALSE);
}
if(iGuseable == FALSE)
{
SetUseableFlag(oTarget,TRUE);
}
}
