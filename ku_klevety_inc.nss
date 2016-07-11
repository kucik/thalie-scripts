#include "aps_include"
#include "strings_inc"
#include "ku_libtime"

const int RELOAD_KLEVETY = 6000;

void ku_klevety_dialog(object NPC, string text);

void __initPlc();

void ku_klevety_init() {
  int initialized = GetLocalInt(OBJECT_SELF,"KU_NPC_KLEV_INITIALIZED");
  if(initialized)
    return;

  string sEmptyText = "*Zivne*";

  object oNPC = OBJECT_SELF;
  string sNPCtag = GetTag(oNPC);
  string sNPCname = GetName(oNPC);
  object oArea = GetArea(oNPC);
  string sAreaTag = GetTag(oArea);
  string sAreaName = GetName(oArea);

  /* Look for talking friend */
  object oFriend = GetLocalObject(oNPC,"KLEV_FRIEND");
  if(!GetIsObjectValid(oFriend)) {
    string sFriend = GetLocalString(oNPC,"KLEV_FRIEND_TAG");
    if(GetStringLength(sFriend) > 0) {
      oFriend = GetNearestObjectByTag(sFriend,oNPC);
      SetLocalObject(oNPC,"KLEV_FRIEND",oFriend);
      SetLocalObject(oFriend,"KLEV_FRIEND",oNPC);
    }
  }

  /* Location independent */
  if(GetLocalInt(oNPC,"KLEV_NO_LOC")) {
    sAreaTag = "-";
  }

  int iCnt = 0;
  /* Check if NPC is initialized in DB */
  string sSQL = "SELECT count(*) FROM Klevety WHERE lokace_tag = '"+sAreaTag+"' AND NPC_tag = '"+sNPCtag+"'; ";
  SQLExecDirect(sSQL);
  if(SQLFetch() == SQL_SUCCESS) {
    iCnt = StringToInt(SQLGetData(1));
  }

  /* If no text, initialize me in DB */
  if(iCnt == 0) {
    string sValues = "'"+sAreaTag+"',"+
                     "'"+sAreaName+"',"+
                     "'"+sNPCtag+"',"+
                     "'"+sNPCname+"',"+
                     "'"+sEmptyText+"'";
    sSQL = "INSERT INTO Klevety  (lokace_tag,lokace,NPC_tag,NPC,text) VALUES ("+sValues+");";
    SQLExecDirect(sSQL);
  }


  /* Check from DB every RELOAD_KLEVETY + rand seconds */
  SetLocalInt(OBJECT_SELF,"KU_NPC_KLEV_INITIALIZED",1);
//  float timeout = IntToFloat(RELOAD_KLEVETY + Random(500));
//  DelayCommand(timeout,DeleteLocalInt(oNPC,"KU_NPC_KLEV_INITIALIZED"));

  if(GetObjectType(oNPC) == OBJECT_TYPE_PLACEABLE)
    __initPlc();

  return;
}

void ku_klevety_shout() {
  object oNPC = OBJECT_SELF;
  object oFriend = GetLocalObject(oNPC,"KLEV_FRIEND");
  string sText;
  string sNPCtag = GetTag(oNPC);
  object oArea = GetArea(oNPC);
  string sAreaTag = GetTag(oArea);
  object oMod = GetModule();

  /* Location independent */
  if(GetLocalInt(oNPC,"KLEV_NO_LOC")) {
    sAreaTag = "-";
  }

  // Fetch random text 
  string sSql = "SELECT text FROM Klevety WHERE lokace_tag = '"+sAreaTag+"' AND NPC_tag = '"+sNPCtag+"' ORDER BY RAND() LIMIT 0,1;";
  SQLExecDirect(sSql);
  if (SQLFetch() != SQL_SUCCESS) {
    WriteTimestampedLogEntry("KLEVETY: Error on loading records for: lokace_tag = '"+sAreaTag+"' AND NPC_tag = '"+sNPCtag+"';");
    return;
  }
  sText = SQLGetData(1);
  sText = StrEncodeToCZ(oMod,sText);

 if(FindSubString(sText,"|",0) > 0) {
   if(GetIsObjectValid(oFriend)) {
      ku_klevety_dialog(oNPC, sText);
   }
   else {
     int pos = FindSubString(sText,"|",0);
     string part1 = GetSubString(sText,0,pos);
     SpeakString(part1);
   }
 }
   else {
   SpeakString(sText);
   }

 SetLocalInt(OBJECT_SELF,"__KLEV_LAST", ku_GetTimeStamp());
}

void ku_klevety_dialog(object NPC, string text) {
  string part1;
  string part2;
  int pos = FindSubString(text,"|",0);
  object oFriend = GetLocalObject(NPC,"KLEV_FRIEND");

  part1 = GetSubString(text,0,pos);
  part2 = GetSubString(text,pos+1,GetStringLength(text) - pos);

  AssignCommand(NPC,SpeakString(part1));
  if(pos > 0) {
    DelayCommand(6.0,ku_klevety_dialog(oFriend,part2));
  }
}

void __initPlc() {
  /* Get texts from DB */
  object oNPC = OBJECT_SELF;
  string sNPCtag = GetTag(oNPC);
  object oArea = GetArea(oNPC);
  string sAreaTag = GetTag(oArea);
  object oMod = GetModule();

  /* Location independent */
  if(GetLocalInt(oNPC,"KLEV_NO_LOC")) {
    sAreaTag = "-";
  }

  string sSQL = "SELECT text FROM Klevety WHERE lokace_tag = '"+sAreaTag+"' AND NPC_tag = '"+sNPCtag+"' order by id; ";
  SQLExecDirect(sSQL);
  string sText;
  string sDesc = "";
  while (SQLFetch() == SQL_SUCCESS) {
    sText = SQLGetData(1);
    sText = StrEncodeToCZ(oMod,sText);
    sDesc = sDesc + sText;
  }
  SetDescription(oNPC, sDesc);
}

int __plcCheckShout() {
  if(GetLocalInt(OBJECT_SELF,"KU_NPC_KLEV_INITIALIZED"))
    return FALSE;

  return TRUE;
}

int klevetyChechShout() {
  if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE)
    return __plcCheckShout();

  int irand = GetLocalInt(OBJECT_SELF,"KLEV_RAND");
  int iMinTime = GetLocalInt(OBJECT_SELF,"KLEV_MIN_TIME") * 60; // In minutes
  int iMaxTime = GetLocalInt(OBJECT_SELF,"KLEV_MAX_TIME") * 60; // In minutes
  int iLast = GetLocalInt(OBJECT_SELF,"__KLEV_LAST");
  int iTS = ku_GetTimeStamp();
 
  if(iLast + iMinTime > iTS ) 
    return FALSE;

  if(iMaxTime > 0 && iLast + iMaxTime < iTS)
    return TRUE;
  
  if(Random(irand) == 0) 
    return TRUE;

 return FALSE;
}
