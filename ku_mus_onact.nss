#include "x2_inc_switches"

const int MUS_DEBUG = FALSE;

void main()
{
  object oItem = GetItemActivated();
  object oPC = GetItemActivator();
  string sTag = GetTag(oItem);
  string sDialog = "";
  if(MUS_DEBUG)
    SendMessageToPC(oPC, "[DEBUG] Executed music script for item '"+sTag+"'.");
  if(GetStringLeft(sTag,6) != "ry_hn_") {
    SetExecutedScriptReturnValue(FALSE);
    return;
  }
  if(MUS_DEBUG)
    SendMessageToPC(oPC, "[DEBUG] Item '"+sTag+"' is music instrument.");

  if(sTag == "ry_hn_pistal") {
    sDialog = "myd_mus_pipe";
  }
  else if(sTag == "ry_hn_kytara") {
    sDialog = "myd_mus_guitar";
  }
  else if(sTag == "ry_hn_loutna") {
    sDialog = "myd_mus_lute";
  }
  else if(sTag == "ry_hn_housle") {
    sDialog = "myd_mus_violin";
  }
  else if(sTag == "ry_hn_harfa") {
    sDialog = "myd_mus_harp";
  }
  else {
    SetExecutedScriptReturnValue(FALSE);
    return;
  }

  if(MUS_DEBUG)
    SendMessageToPC(oPC, "[DEBUG] Item '"+sTag+"' - Loading dialog '"+sDialog+"'.");
  AssignCommand(oPC,ActionStartConversation(OBJECT_SELF,sDialog,TRUE,FALSE));

  SetExecutedScriptReturnValue(TRUE);
  return;
}
