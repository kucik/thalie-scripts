#include "aps_include"

struct ctf_status {
  string sOwner;
  string sConqueror;
};

struct ctf_status CFT_GetAreaStatus(string sArea);
void CTF_SetConqueror(string sFaction, string sPC);
int CTF_GetIsCtfTime();
void __doorCloseCheck(object oDoors);

void __setFlagStatus(object oFlag, string sOwner, int iPerc, string sPC="") {
  if(GetStringLength(sPC) > 0 && iPerc == 100)
    SetName(oFlag, sOwner+" - Dobyl(a) "+sPC);
  else
    SetName(oFlag, sOwner+" - "+IntToString(iPerc)+"%");
}

void CTF_FlagInit() {
  if(GetLocalInt(OBJECT_SELF,"flag_initialized"))
    return;

  object oFlag = OBJECT_SELF;
  object oArea = GetArea(oFlag);
  string sArea = GetTag(oArea);

  struct ctf_status status = CFT_GetAreaStatus(sArea);

  SetLocalInt(oFlag,"FLAG_PERC",100);
  SetLocalString(oFlag,"FLAG_OWNER",status.sOwner);
  __setFlagStatus(oFlag, status.sOwner, 100, status.sConqueror);

  SetLocalString(oArea,"LOCK_CTF_OWNER",status.sOwner);
  SetLocalInt(oArea, "CTF_AREA",TRUE);
}

struct ctf_status CFT_GetAreaStatus(string sArea) {

  struct ctf_status status;

  string sSql = "SELECT owner, conqueror FROM ctf_locations WHERE area = '"+sArea+"' ORDER BY timestamp DESC LIMIT 0,1;";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    status.sOwner = SQLGetData(1);
    status.sConqueror = SQLDecodeSpecialChars(SQLGetData(2));
  }
  else {
    status.sOwner = "BANDITI";
    status.sConqueror = "Bandita";
    CTF_SetConqueror(status.sOwner, status.sConqueror);
  }

  return status;
}

void CTF_SetConqueror(string sFaction, string sPC) {
  string sConq = SQLEncodeSpecialChars(sPC);
  string sSql = "INSERT INTO ctf_locations (owner, conqueror) VALUES ('"+sFaction+"','"+sConq+"');";
  SQLExecDirect(sSql);
}

void CTF_PumpFlag(object oFlag, string sFaction, object oPC) {
  int iPerc = GetLocalInt(oFlag,"FLAG_PERC");
  string sFlagFaction = GetLocalString(oFlag,"FLAG_OWNER");

  if(iPerc <= 0) {
    sFlagFaction = sFaction;
  }

  if(sFlagFaction == sFaction) {
    iPerc = iPerc + 5;
  }
  else {
    iPerc = iPerc - 5;
  }
  if(iPerc > 100)
    iPerc = 100;

  SetLocalInt(oFlag,"FLAG_PERC", iPerc);
  SetLocalString(oFlag,"FLAG_OWNER", sFaction);
  __setFlagStatus(oFlag, sFaction, iPerc, GetName(oPC));

  if(iPerc == 100) {
    CTF_SetConqueror(sFaction, GetName(oPC));
    SetLocalString(GetArea(oFlag),"LOCK_CTF_OWNER",sFaction);
  }

}

void CTF_UseLever() {
  object oLever = OBJECT_SELF;
  object oPC = GetLastUsedBy();

  if(GetLocalInt(oLever,"BLOCKED"))
    return;

  if(!CTF_GetIsCtfTime())
    return;

  /* 6s block lever */
  SetLocalInt(oLever, "BLOCKED",TRUE);
  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
  DelayCommand(6.0,DeleteLocalInt(oLever,"BLOCKED"));
  DelayCommand(6.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));

  object oFlag = GetNearestObjectByTag("CTF_FLAG",oLever,1);
  CTF_PumpFlag(oFlag, GetTag(oLever), oPC);
}

int CTF_GetIsCtfTime() {
  string sql = "SELECT HOUR(CURTIME()), DAYOFWEEK(CURDATE());";
  SQLExecDirect(sql);
  if (SQLFetch() == SQL_SUCCESS){
    int iHour = StringToInt(SQLGetData(1));
    int iDay = StringToInt(SQLGetData(2));

    if(iHour < 19 || iHour > 20) // 19:00 - 20:59
      return FALSE;

    if(iDay != 1) // Sunday
      return FALSE;

    return TRUE;
  }

  return FALSE;
}

void __doorCloseCheck(object oDoors) {
  if(!GetIsOpen(oDoors))
    return;

  string sTag = GetTag(oDoors);
  if(GetLocalString(GetArea(oDoors),"LOCK_CTF_OWNER") == GetTag(oDoors) ||
     CTF_GetIsCtfTime()) {
    DelayCommand(60.0,__doorCloseCheck(oDoors));
    return;
  }

  AssignCommand(oDoors,ActionCloseDoor(oDoors));
  SetLocked(oDoors,TRUE);
  SetLockKeyRequired(oDoors, TRUE);

}

void CTF_DoorClick() {
  object oDoors = OBJECT_SELF;
  if(GetIsOpen(oDoors))
    return;

  if(GetLocalString(GetArea(oDoors),"LOCK_CTF_OWNER") == GetTag(oDoors) ||
     CTF_GetIsCtfTime()) {
    AssignCommand(oDoors,ActionOpenDoor(oDoors));
    DelayCommand(60.0,__doorCloseCheck(oDoors));
    return;
  }

}
