//#include "aps_include"
/*
 * PLC_DOORS int 1
 * DOORS_TAG string ph_kar_mobr
 * DOORS_COUNT int pocet dveri

 * DOORWAY_BREAK string x0_fallentimber
 * DOORS_REVERSE int  1
 * DOORWAY_BREAK_OFFSET_Z float -2.5
*/



object MakeDoorBrake(string sWayBreak, object oDoors,int iOpen, int iReverse = 0) {
  if(GetStringLength(sWayBreak) == 0) {
    return OBJECT_INVALID;
  }

  iOpen = (iOpen + iReverse) % 2;

  if(iOpen == 0) {
    object oBreak = GetLocalObject(oDoors,"DOORWAY_BREAK");
//    GetNearestObjectByTag("DOORS"+sWayBreak,oDoors,1);
//    SpeakString("Destrying doors break "+GetName(oBreak));
    DestroyObject(oBreak);
    return oBreak;
  }
  else {
    location lLoc = GetLocation(oDoors);
//    SpeakString("Orig location: "+LocationToString(lLoc));
    if(iReverse) {
      object oArea = GetAreaFromLocation(lLoc);
      vector vVect = GetPositionFromLocation(lLoc);
      float fOrientation = GetFacingFromLocation(lLoc);
      vVect.z = vVect.z  + GetLocalFloat(OBJECT_SELF,"DOORWAY_BREAK_OFFSET_Z");
      lLoc = Location(oArea,vVect,fOrientation);
    }
//    SpeakString("Creating doors break "+sWayBreak+" at "+LocationToString(lLoc)+" you are at "+LocationToString(GetLocation(GetLastUsedBy())));
//    SpeakString("Creating doors break "+sWayBreak);
    object oBreak = CreateObject(OBJECT_TYPE_PLACEABLE,sWayBreak,lLoc,FALSE,"DOORS"+sWayBreak);
    SetLocalObject(oDoors,"DOORWAY_BREAK",oBreak);
//    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_BEAM_FIRE),oBreak);
    return oBreak;
  }


}

void DoCopyVars(object oDoors, object oLever) {

   if(GetStringLength(GetLocalString(oDoors,"DOORWAY_BREAK")) == 0) {

     SetLocalInt(   oDoors,"DOORS_REVERSE",         GetLocalInt(oLever,"DOORS_REVERSE"));
     SetLocalString(oDoors,"DOORWAY_BREAK",         GetLocalString(oLever,"DOORWAY_BREAK"));
     SetLocalFloat( oDoors,"DOORWAY_BREAK_OFFSET_Z",GetLocalFloat(oLever,"DOORWAY_BREAK_OFFSET_Z"));
   }

}

void main()
{
  int iType = 0; //Doors
  string sTag = "";
  int i;
  //ovladacmu prvku nastavit tyto promenne:
  //DOORS_COUNT, int, pocet dveri
  //PLC_DOORS, int, 1 pokud jsou dvere placeable
  //DOORS_TAG, string, tag dvari
  int iCount = GetLocalInt(OBJECT_SELF,"DOORS_COUNT");
  int iReverse = GetLocalInt(OBJECT_SELF,"DOORS_REVERSE");

  if(GetLocalInt(OBJECT_SELF,"PLC_DOORS")) {
    iType = 1;
    sTag = GetLocalString(OBJECT_SELF,"DOORS_TAG");
  }
  if(iCount < 1) {
    iCount = 1;
  }
  string sWayBreak = GetLocalString(OBJECT_SELF,"DOORWAY_BREAK");

  if(GetStringLength(sTag) > 0) {
    for(i=1;i<=iCount;i++) {
      object oDoors = GetNearestObjectByTag(sTag,OBJECT_SELF,i);
//SpeakString("mam dvere:"+GetName(oDoors));
      int nIsOpen = GetIsOpen(oDoors);
      if(iType == 0) {
        if (nIsOpen == 0)
        {
            AssignCommand(oDoors,ActionCloseDoor(oDoors));
        }
        else
        {
            AssignCommand(oDoors,ActionOpenDoor(oDoors));
        }
      }
      else {
        if (nIsOpen == 0)
        {
            AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
            MakeDoorBrake(sWayBreak,oDoors,0,iReverse);
            DoCopyVars(oDoors,OBJECT_SELF);
            if(!iReverse) {
              ExecuteScript("ja_door_onopen",oDoors);
            }
        }
        else
        {
            AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
            MakeDoorBrake(sWayBreak,oDoors,1,iReverse);
            DoCopyVars(oDoors,OBJECT_SELF);
            if(iReverse) {
              ExecuteScript("ja_door_onopen",oDoors);
            }
        }
      }
    }
  }
  else if(iType == 1) {
    object oDoors = OBJECT_SELF;
       int nIsOpen = GetIsOpen(oDoors);
//       SendMessageToPC(GetFirstPC(),"working with PLC doors. Is Open?"+IntToString(nIsOpen));
       if (nIsOpen == 0)
        {
//            SendMessageToPC(GetFirstPC(),"Opening doors");
            AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
            MakeDoorBrake(sWayBreak,oDoors,0,iReverse);
//            DoCopyVars(oDoors,OBJECT_SELF);
            if(!iReverse) {
              ExecuteScript("ja_door_onopen",oDoors);
            }
        }
        else
        {
//            SendMessageToPC(GetFirstPC(),"Closing doors");
            AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
            MakeDoorBrake(sWayBreak,oDoors,1,iReverse);
//            DoCopyVars(oDoors,OBJECT_SELF);
            if(iReverse) {
              ExecuteScript("ja_door_onopen",oDoors);
            }
        }
    return;
  }
  else {
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR);
//SpeakString("Trying to open door "+GetName(oDoor));
    AssignCommand(oDoor,ActionOpenDoor(oDoor));
  }

  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

  DelayCommand(2.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
