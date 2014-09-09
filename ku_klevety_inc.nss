#include "aps_include"
#include "strings_inc"

const int RELOAD_KLEVETY = 6000;

void ku_klevety_dialog(object NPC, string text);

void ku_klevety_init() {
  int initialized = GetLocalInt(OBJECT_SELF,"KU_NPC_KLEV_INITIALIZED");
  if(initialized)
    return;

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

  /* Get texts from DB */
  string sSQL = "SELECT text FROM Klevety WHERE lokace_tag = '"+sAreaTag+"' AND NPC_tag = '"+sNPCtag+"'; ";
  SQLExecDirect(sSQL);
  string sText;
  int i=0;
  object oMod = GetModule();
  while (SQLFetch() == SQL_SUCCESS) {

    sText = SQLGetData(1);
    sText = StrEncodeToCZ(oMod,sText);
    SetLocalString(oNPC,"KU_KLEVETY_"+IntToString(i),sText);
    i++;
  }
  SetLocalInt(oNPC,"KU_KLEVETY_CNT",i);

  /* If no text, initialize me in DB */
  if(i == 0) {
    string sValues = "'"+sAreaTag+"',"+
                     "'"+sAreaName+"',"+
                     "'"+sNPCtag+"',"+
                     "'"+sNPCname+"',"+
                     "'*Zivne*'";
    sSQL = "INSERT INTO Klevety  (lokace_tag,lokace,NPC_tag,NPC,text) VALUES ("+sValues+");";
    SQLExecDirect(sSQL);
  }


  /* Check from DB every RELOAD_KLEVETY + rand seconds */
  SetLocalInt(OBJECT_SELF,"KU_NPC_KLEV_INITIALIZED",1);
  float timeout = IntToFloat(RELOAD_KLEVETY + Random(500));
  DelayCommand(timeout,DeleteLocalInt(oNPC,"KU_NPC_KLEV_INITIALIZED"));

  return;
}

void ku_klevety_shout() {
 object oNPC = OBJECT_SELF;
 int max =  GetLocalInt(oNPC,"KU_KLEVETY_CNT");
 object oFriend = GetLocalObject(oNPC,"KLEV_FRIEND");
 int i = Random(max);
 string sText = GetLocalString(oNPC,"KU_KLEVETY_"+IntToString(i));

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


