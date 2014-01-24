#include "aps_include"

// Log DM Action
void LogDMAction(object oDM, object oPC, string sAction, int iParam);

void LogDMAction(object oDM, object oPC, string sAction, int iParam) {

  string sDM = GetPCPlayerName(oDM)+" ("+GetName(oDM)+")";
  string sPlayer = "";
  string sName = "";
  if(GetIsObjectValid(oPC)) {
    sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
    sName = SQLEncodeSpecialChars(GetName(oPC));
  }
  string sParam = IntToString(iParam);

  string sValues = "'"+sDM+"',"+
                   "'"+sPlayer+"',"+
                   "'"+sName+"',"+
                   "'"+sAction+"',"+
                   "'"+sParam+"'";
  string sSQL = "INSERT INTO dmaction (dm,player,name,action,param) VALUES ("+sValues+");";
  SQLExecDirect(sSQL);

}

