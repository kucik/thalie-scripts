#include "nwnx_areas"
#include "aps_include"

const int CMD_FETCH_LIMIT = 10;
const int CMD_MAX_COMMANDS_AT_ONCE = 10;

void __loadArea(string sResref) {
  WriteTimestampedLogEntry("Loading area "+sResref+" ...");
  object oArea = LoadArea(sResref);
  WriteTimestampedLogEntry("Loaded area "+sResref+" -> "+GetName(oArea));
}

int __processCommand(string sCmd, string sVal) {
  // Known commands one by one

  // Area load through resman
  if(sCmd == "load_location") {
    // Delay to be sure that area file is on place
    DelayCommand(2.0,__loadArea(sVal));
    return TRUE;
  }
  // Area load through resman
  if(sCmd == "drop_location") {
    object oArea = GetObjectByTag(sVal);
    if(GetIsObjectValid(oArea)) {
      DestroyArea(oArea);
      return TRUE;
    }
    else
      return FALSE;
  }
  // Shout 
  if(sCmd == "shout") {
    SpeakString(sVal, TALKVOLUME_SHOUT);
    return TRUE;
  }
  // Kick player(s) 
  if(sCmd == "kick") {
    object oPC;
    int i = 0;

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC)) {
      if(sVal == "all" || sVal == GetPCPlayerName(oPC)) {
        DelayCommand(0.5*i,BootPC(oPC));
        i++;
      }
      oPC = GetNextPC();
    }
    return TRUE;
  }
 
  return FALSE;
}

int __processCommands() {

  int i = 0;
  string sID;
  string sCmd;
  string sVal;

  /* Fetch commands to be processed */ 
  string sSql = "SELECT * FROM server_commands ORDER BY datestamp;";
  SQLExecDirect(sSql);
  while (SQLFetch() == SQL_SUCCESS &&  i <= CMD_FETCH_LIMIT) {
    sID = SQLGetData(1);
    sCmd = SQLGetData(2);
    sVal = SQLGetData(3);

    if(__processCommand(sCmd, sVal)) {
      sSql = "DELETE FROM server_commands WHERE id='"+sID+"';";
      return TRUE; 
    }
    i++;
  }

  return FALSE;
}

void main() {
  int i;
  
  while(__processCommands() && i <  CMD_MAX_COMMANDS_AT_ONCE) {
    i++;
  }

}
