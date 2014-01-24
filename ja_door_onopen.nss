/*
    ja_door_onclose
*/
// VYSVETLIVKY
//   int DOORCLOSE=0 - vypnute
//   int DOORCLOSE=1 - zapnute
//   int DOORCLOSE_DELAY=55 - zavrit za 55 sekund
//   int DOORLOCK=0 - vypnute
//   int DOORLOCK=1 - zamknout v noci
//   int DOORLOCK=2 - zamknout ve dne
//   int DOORLOCK=3 - zamknout kdykoliv

// Pro placeable dvere (obvykle ovladane pakou)
//   Int    DOORS_REVERSE          = 1                  - prevracene dvere (zavrene jsou otevrene a naopak)
//   string DOORWAY_BREAK          = "x0_fallentimber"  - resref placeablu prehrazujiciho cestu
//   float  DOORWAY_BREAK_OFFSET_Z = -2.5               - posunuti placeablu na ose Z vuci dverim


void unlock(object oDoor){
    SetLocked(oDoor, FALSE);
    SetLocalInt(oDoor, "JA_DOOR_SETTIMER", 0);
}

int getIsDay(){ //upravene GetIsDay
    int iHour = GetTimeHour();
    if(iHour >= 23 || iHour <= 4)
        return 0;


    return 1;
}


object MakeDoorBrake(string sWayBreak, object oDoors,int iOpen, int iReverse = 0) {
  if(GetStringLength(sWayBreak) == 0) {
    return OBJECT_INVALID;
  }

  iOpen = (iOpen + iReverse) % 2;

  if(iOpen == 0) {
    object oBreak = GetNearestObjectByTag("DOORS"+sWayBreak,oDoors,1);
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
//    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_BEAM_FIRE),oBreak);
    return oBreak;
  }


}

void DoOpenCloseDoor(object oDoors, int iOpen = 0) {

  // Normal doors
  if(GetObjectType(oDoors) == OBJECT_TYPE_DOOR) {
    if(iOpen == 0)
      ActionCloseDoor(oDoors);
    else
      ActionOpenDoor(oDoors);
    return;
  }
  //placeable doors
  else {
    int iReverse = GetLocalInt(oDoors,"DOORS_REVERSE");
    string sWayBreak = GetLocalString(oDoors,"DOORWAY_BREAK");

    if((iOpen == 0 ) && (iReverse == 0)) {
      AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
      MakeDoorBrake(sWayBreak,oDoors,1,iReverse);
    }
    else {
      AssignCommand(oDoors,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
      MakeDoorBrake(sWayBreak,oDoors,0,iReverse);
    }

  }

}

void main()
{

   object oDvere = OBJECT_SELF;
   object oPC = GetLastOpenedBy();

   //if(GetLocalInt(oDvere, "JA_DOOR_DELAY")) return; //delay catch

   int iDoorClose = GetLocalInt (oDvere, "DOORCLOSE");
   int iDoorClose_Delay = GetLocalInt (oDvere, "DOORCLOSE_DELAY");
   int iDoorLock = GetLocalInt(oDvere, "JA_DOOR_NIGHTLOCK");
    if(!iDoorLock) iDoorLock = GetLocalInt (oDvere, "DOORLOCK");

   //Overime, jestli je Close_Time zadanej, jestli ne, nebudeme dvere
   //zavirat a vypiseme Debug hlasku v pripade, ze je zadany, aby se zaviraly
   if(iDoorClose_Delay < 1 && iDoorClose == 1)
   {
//       SendMessageToPC(oPC, "[DEBUG] - Tyto dvere maji spatne nastavene promenne, prosim kontaktujte DM a informujte ho o teto chybe");
       return;
   }

   //Pokud mame dvere zavirt a je spravne nastavnenj close time, tak je zavreme
   if(iDoorClose == 1 && iDoorClose_Delay >= 1)
   {
       //DelayCommand(IntToFloat(iDoorClose_Delay),ActionCloseDoor(oDvere)); DoOpenCloseDoor
       DelayCommand(IntToFloat(iDoorClose_Delay),DoOpenCloseDoor(oDvere));
   }

   //Pokud mame dvere zamknout, tak je zamkneme... K tomu potrebujeme overit, jestli je
   //den, nebo noc

   int isDay = getIsDay();

   if(!isDay && iDoorLock == 1) //v noci zavrit
   {
//       ActionCloseDoor(oDvere);
       DoOpenCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
       SetLockKeyRequired(oDvere, TRUE);

       //nastavime delay na otevreni
        if(!GetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER")){
            int iDuration = GetTimeHour();

            if(iDuration >= 23)
                iDuration = 29-iDuration;
            else
               iDuration = 5-iDuration;

            DelayCommand(HoursToSeconds(iDuration), unlock(oDvere));
            SetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER", 1);
        }
   }
   else if(isDay && iDoorLock == 2) //ve dne zavrit
   {
//       ActionCloseDoor(oDvere);
       DoOpenCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
       SetLockKeyRequired(oDvere, TRUE);

       //nastavime delay na otevreni
        if(!GetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER")){
            int iDuration = 23 - GetTimeHour();

            DelayCommand(HoursToSeconds(iDuration), unlock(oDvere));
            SetLocalInt(OBJECT_SELF, "JA_DOOR_SETTIMER", 1);
        }
   }
   else if(iDoorLock == 3) //vzdy
   {
//       ActionCloseDoor(oDvere);
       SetLocked(oDvere,TRUE);
   }

   SetLocalInt(oDvere, "JA_DOOR_DELAY", 1);
   DelayCommand(1.0f, DeleteLocalInt(oDvere, "JA_DOOR_DELAY"));
}
