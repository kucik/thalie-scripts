/**
 * Script pro ovládání dveří pomocí placeablu. Např. pomocí páky.
 * Možnosti použití od nejjednodušších.
 * 1) Prosté dveře. Nastavit script do onused na páku. Po použítí otevře nejbližší dveře.
 * 2) Pro otevření jiných než nejbližších dveří naplňte na páku proměnnou DOORS_TAG s tagem dveří.
 * 3) Pokud má otevírat více dveří najednou, nastav na páku DOORS_COUNT (int) počet dveří
 * 4) Pokud neotevírá normální dveře, ale placeablové, nastav PLC_DOORS int 1.
 * 5) Aby skrz plc dveře nešlo procházet, když jsou zavřené, je dobré spawnout v nich při zavření placeable. Do DOORWAY_BREAK napiš resref plc ke spawnutí. Osvědčilo se x0_fallentimber (kláda).
 * 6) PLC dveře jde nastavit tak, aby se zavřené chovaly jako otevřené a naopak. Např. jde vzít plc mříže, posunout je o 2.5m nahoru a tim pádem se místo dolu budou zasouvat nahoru. Aby se kláda spawnovala když jsou mříže nahoře, použij DOORS_REVERSE int 1. Aby se kláda nespawnovala ve vzduchu, je třeba jí vejškově posunout na správné místo pomocí DOORWAY_BREAK_OFFSET_Z
 * 7) Je možné vyrobit dveře, které k otevření potřebují zároveň stlačených víc pák. V tom případě na dveře (! ne na páku) nastav LEVER_COUNT int počet pák nutných k otevření dveří.
 *
 * Nastavovací proměnné:
 *
 * PLC_DOORS int 1 - Nastavit pokud jsou to placeablové dveře.
 * DOORS_TAG string <tag dveří k otevření>
 * DOORS_COUNT int <pocet dveri>

 * DOORWAY_BREAK string <placeable, kterým se zablokují dveře> např.: x0_fallentimber
 * DOORS_REVERSE int 1 - Nastavit pokud mají dveře převrácenou animaci. Např. mříže, které mají vypadat zavřené když jsou otevřené a naopak.
 * DOORWAY_BREAK_OFFSET_Z float -2.5 - Svislé posunutí placeablu pro zablokování dveří.
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

void LeverReturn(object oDoors, object oLever) {
  if(oDoors == oLever)
    return;

  AssignCommand(oLever,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
  int iPushed = GetLocalInt(oDoors,"KU_LEVER_PUSHED") - 1;
  if(iPushed < 0)
    iPushed = 0;
  SetLocalInt(oDoors,"KU_LEVER_PUSHED",iPushed);

}

void DoCopyVars(object oDoors, object oLever) {

   if(GetStringLength(GetLocalString(oDoors,"DOORWAY_BREAK")) == 0) {

     SetLocalInt(   oDoors,"DOORS_REVERSE",         GetLocalInt(oLever,"DOORS_REVERSE"));
     SetLocalString(oDoors,"DOORWAY_BREAK",         GetLocalString(oLever,"DOORWAY_BREAK"));
     SetLocalFloat( oDoors,"DOORWAY_BREAK_OFFSET_Z",GetLocalFloat(oLever,"DOORWAY_BREAK_OFFSET_Z"));
   }

}

int __LeverPushNeedCheck(object oDoors) {
  int iNeeded = GetLocalInt(oDoors,"LEVER_COUNT");
  if(iNeeded == 0)
    return TRUE;
  int iPushed = GetLocalInt(oDoors,"KU_LEVER_PUSHED") + 1;
  SetLocalInt(oDoors,"KU_LEVER_PUSHED",iPushed);
  if(iPushed == iNeeded)
    return TRUE;

  return FALSE;
}

void __openCloseDoorPlc(object oDoors, string sWayBreak, int iReverse, int iCopyVars) {
  int nIsOpen = GetIsOpen(oDoors);
  if(!__LeverPushNeedCheck(oDoors) && nIsOpen == iReverse)
    return;

  if (!nIsOpen) {
    AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
    MakeDoorBrake(sWayBreak,oDoors,0,iReverse);
    if(iCopyVars)
      DoCopyVars(oDoors,OBJECT_SELF);
    if(!iReverse) {
      ExecuteScript("ja_door_onopen",oDoors);
    }
  }
  else {
    AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
    MakeDoorBrake(sWayBreak,oDoors,1,iReverse);
    if(iCopyVars)
      DoCopyVars(oDoors,OBJECT_SELF);
    if(iReverse) {
      ExecuteScript("ja_door_onopen",oDoors);
    }
  }
}


void __openCloseDoor(object oDoors) {
  int nIsOpen = GetIsOpen(oDoors);

  if (!nIsOpen && __LeverPushNeedCheck(oDoors)) {
    AssignCommand(oDoors,ActionOpenDoor(oDoors));
  }
  else {
    AssignCommand(oDoors,ActionCloseDoor(oDoors));
  }
}

object __getNearestDoors(string sTag, int i) {
  if(GetStringLength(sTag) > 0)
    return GetNearestObjectByTag(sTag,OBJECT_SELF,i);
  else
    return GetNearestObject(OBJECT_TYPE_DOOR, OBJECT_SELF, i);
}

void main()
{
  int iType = 0; //Doors
  string sTag = GetLocalString(OBJECT_SELF,"DOORS_TAG");
  int i;
  //ovladacmu prvku nastavit tyto promenne:
  //DOORS_COUNT, int, pocet dveri
  //PLC_DOORS, int, 1 pokud jsou dvere placeable
  //DOORS_TAG, string, tag dvari
  int iCount = GetLocalInt(OBJECT_SELF,"DOORS_COUNT");
  int iReverse = GetLocalInt(OBJECT_SELF,"DOORS_REVERSE");
  float LeverTimeout = GetLocalFloat(OBJECT_SELF,"TIMEOUT");

  // Make it pure boolean for binary compare
  if(iReverse)
   iReverse = TRUE;
  else
   iReverse = FALSE;

  if(LeverTimeout < 0.1)
    LeverTimeout = 2.0;

  object oLever = OBJECT_SELF;

  if(GetLocalInt(OBJECT_SELF,"PLC_DOORS")) {
    iType = 1;
  }
  if(iCount < 1) {
    iCount = 1;
  }
  string sWayBreak = GetLocalString(OBJECT_SELF,"DOORWAY_BREAK");

  // PLC doors itself
  if(iType == 1 && GetStringLength(sTag) == 0) {
    object oDoors = OBJECT_SELF;
    __openCloseDoorPlc(oDoors, sWayBreak, iReverse, FALSE);
    return;
  }


  for(i=1;i<=iCount;i++) {
//      WriteTimestampedLogEntry("Open #"+IntToString(i)+" doors "+sTag);
    object oDoors = __getNearestDoors(sTag,i);
//SpeakString("mam dvere:"+GetName(oDoors));
    if(iType == 0) {
      __openCloseDoor(oDoors);
      DelayCommand(LeverTimeout,LeverReturn(oDoors,oLever));
    }
    else {
      __openCloseDoorPlc(oDoors, sWayBreak, iReverse, TRUE);
      DelayCommand(LeverTimeout,LeverReturn(oDoors,oLever));
    }
  }

  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

//  DelayCommand(2.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
