location MoveObject(object oTarget)
{
object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
float fDMSetNumber=IntToFloat(iDMSetNumber);
float fAdjust = fDMSetNumber /10;

object oGArea = GetArea(oTarget);
vector vGPosition =GetPosition(oTarget);
float fGfacing =GetFacing(oTarget);


     float vX = vGPosition.x;
     float vY = vGPosition.y+fAdjust;
     float vZ = vGPosition.z;

  vector vNewPos = Vector(vX, vY,vZ);

location LNew = Location(oGArea,vNewPos,fGfacing);

return LNew;
}

location MoveObject2(object oTarget)
{
object oPCspeaker =GetPCSpeaker();
object oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPCspeaker);
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
float fDMSetNumber=IntToFloat(iDMSetNumber);

object oGArea = GetArea(oTarget);
vector vGPosition =GetPosition(oTarget);
float fGfacing =GetFacing(oTarget);


     float vX = vGPosition.x;
     float vY = vGPosition.y+fDMSetNumber;
     float vZ = vGPosition.z;

  vector vNewPos = Vector(vX, vY,vZ);

location LNew = Location(oGArea,vNewPos,fGfacing);

return LNew;
}





void main()
{
object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
location Ltarget = GetLocalLocation(oPCspeaker, "dmfi_univ_location");
 if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
                {
                 oTarget = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, Ltarget);
string sGRef =GetResRef(oTarget);
location LNew = MoveObject2(oTarget);
object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sGRef,LNew,FALSE);
DestroyObject(oTarget);
DelayCommand(1.0,SetLocalObject(oPCspeaker,"dmfi_univ_target",oNew));
SendMessageToPC(oPCspeaker,"Target was not a placable, used placeable"+
"closest to targeted area, if static you will need to leave the area"+
"and come back to see it full effect");
return;
}

string sGRef =GetResRef(oTarget);
location LNew = MoveObject(oTarget);
object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sGRef,LNew,FALSE);
DestroyObject(oTarget);
DelayCommand(1.0,SetLocalObject(oPCspeaker,"dmfi_univ_target",oNew));

}
