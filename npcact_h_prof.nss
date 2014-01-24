///////////////////////////////////////////////////////////////////////////////
// npcact_h_prof - NPC ACTIVITIES 6.0 Professions Header File
// By Deva Bryson Winblood.   09/06/2004
//----------------------------------------------------------------------------
// PURPOSE: The purpose of this file is to provide support functions for
// extracting and cleaning up parameters and other tasks that will be needed
// repeatedly for the various professions scripts.
///////////////////////////////////////////////////////////////////////////////
#include "npcactivitiesh"
#include "npcact_h_moving"
#include "npcact_h_anim"
/////////////////////////////
// PROTOTYPES
/////////////////////////////

// FILE: npcact_h_prof                     FUNCTION: fnPROFCleanupArgs()
//  This function will delete the argument variables used by this profession
// and should be called by any profession script that no longer needs its
// arguments.
void fnPROFCleanupArgs(object oNPC=OBJECT_SELF);

// FILE: npcact_h_prof                     FUNCTION: fnPROFActionMethod()
// This function handles the action methods for actions for a given
// profession.  This section of code was used frequently thus, it was
// put into this header.
// sMethod is a series of method commands with period delimiters
// oTool is the tool object for this profession
// sLoc1 = waypoint tags for locations  NA = not applicable
// The variable bPROFActDone will be set to TRUE when this script is
// done.  This variable is stored on the NPC.
void fnPROFActionMethod(string sMethod,object oTool,object oNPC=OBJECT_SELF,string sLoc1="NA",string sLoc2="NA",string sLoc3="NA");

// FILE: npcact_h_prof                     FUNCTION: fnPROFContainerHasItem()
// This function will return an object in a store, container, etc. inventory
// by traversing its inventory and looking for the item.
object fnPROFContainerHasItem(object oContainer,string sItemTag);

// FILE: npcact_h_prof                     FUNCTION: GetPlayerID()
// This function returns a string formatted ID for the player.  If you have
// a specific way of storing IDs for your module simply replace this function with
// your own and rebuild the scripts.
string GetPCPlayerID(object oPC);


/////////////////////////////
// FUNCTIONS
/////////////////////////////

object fnPROFContainerHasItem(object oContainer,string sItemTag)
{ // PURPOSE: To find an item in a container
  object oRet=OBJECT_INVALID;
  object oInv=GetFirstItemInInventory(oContainer);
  while(oRet==OBJECT_INVALID&&oInv!=OBJECT_INVALID)
  { // traverse inventory
    if (GetTag(oInv)==sItemTag) oRet=oInv;
    oInv=GetNextItemInInventory(oContainer);
  } // traverse inventory
  return oRet;
} // fnPROFContainerHasItem()

void fnPROFActionMethod(string sMethod,object oTool,object oNPC=OBJECT_SELF,string sLoc1="NA",string sLoc2="NA",string sLoc3="NA")
{ // PURPOSE: To handle the special methods of a profession
  object oOb;
  int nN;
  string sS;
  string sActs=sMethod;
  string sParse;
  int bDone=FALSE;
  string sSS;
  int nSpeed=GetLocalInt(oNPC,"nGNBStateSpeed");
  if (nSpeed<1) nSpeed=6;
  while(GetStringLength(sActs)>0&&!bDone)
  { // method stuff to parse
    DeleteLocalInt(oNPC,"bPROFActionMeth");
    sParse=fnParse(sActs);
    if (GetStringLeft(sParse,1)=="W")
    { // go to work area
      if (GetStringRight(sParse,1)=="1") { oOb=GetWaypointByTag(sLoc1); }
      else if (GetStringRight(sParse,1)=="2") { oOb=GetWaypointByTag(sLoc2); }
      else if (GetStringRight(sParse,1)=="3") { oOb=GetWaypointByTag(sLoc3); }
      if (GetIsObjectValid(oOb))
      { // valid destination
        if (GetArea(oOb)!=GetArea(oNPC)||GetDistanceBetween(oOb,oNPC)>2.5)
        { // move
          fnMoveToDestination(oNPC,oOb);
          bDone=TRUE;
        } // move
        else
        { // done moving
          sActs=fnRemoveParsed(sActs,sParse);
        } // done moving
      } // valid destination
      else
      { // invalid
        sActs=fnRemoveParsed(sActs,sParse);
      } // invalid
    } // go to work area
    else
    { // other
      sActs=fnRemoveParsed(sActs,sParse);
      if (GetStringLeft(sParse,1)=="!")
      { // animation
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        sSS=fnParse(sParse,"_");
        sS=fnRemoveParsed(sParse,sSS,"_");
        nN=fnNPCACTAnimMagicNumber(sSS);
        AssignCommand(oNPC,ActionPlayAnimation(nN,1.0,IntToFloat(StringToInt(sS))*0.2));
      } // animation
      else if (GetStringLeft(sParse,1)=="A")
      { // attack object
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        oOb=GetNearestObjectByTag(sParse,oNPC,1);
        if(GetIsObjectValid(oOb))
        { // do it
          AssignCommand(oNPC,ActionAttack(oOb,TRUE));
        } // do it
      } // attack object
      else if (GetStringLeft(sParse,1)=="U")
      { // use object
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        oOb=GetNearestObjectByTag(sParse,oNPC,1);
        if(GetIsObjectValid(oOb))
        { // do it
          AssignCommand(oNPC,ActionInteractObject(oOb));
        } // do it
      } // use object
      else if (GetStringLeft(sParse,1)=="F")
      { // face
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        if(GetIsObjectValid(oOb))
        { // do it
          AssignCommand(oNPC,ActionDoCommand(SetFacingPoint(GetPosition(oOb))));
        } // do it
      } // face
      else if (GetStringLeft(sParse,1)=="'")
      { // say something
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        AssignCommand(oNPC,ActionSpeakString(sParse));
      } // say something
      else if (GetStringLeft(sParse,1)=="P")
      { // pause
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        AssignCommand(oNPC,ActionWait(IntToFloat(StringToInt(sParse))));
      } // pause
      else if (GetStringLeft(sParse,1)=="D")
      { // done
        AssignCommand(oNPC,ActionDoCommand(SetLocalInt(oNPC,"bPROFActDone",TRUE)));
      } // done
      else if (GetStringLeft(sParse,1)=="@")
      { // custom script
        sParse=GetStringRight(sParse,GetStringLength(sParse)-1);
        AssignCommand(oNPC,ActionDoCommand(ExecuteScript(sParse,oNPC)));
      } // custom script
      else if (sParse=="ET")
      { // equip tool
        if (GetIsObjectValid(oTool))
        { // tool is valid
          AssignCommand(oNPC,ActionEquipItem(oTool,INVENTORY_SLOT_RIGHTHAND));
        } // tool is valid
      } // equip tool
      else if (sParse=="UT")
      { // unequip tool
        if (GetIsObjectValid(oTool))
        { // tool is valid
          AssignCommand(oNPC,ActionUnequipItem(oTool));
        } // tool is valid
      } // unequip tool
    } // other
  } // method stuff to parse
  if (bDone&&GetStringLength(sActs)>0)
  { // delay continue
    DelayCommand(IntToFloat(nSpeed),fnPROFActionMethod(sActs,oTool,oNPC,sLoc1,sLoc2,sLoc3));
  } // delay continue
  else {
   if (GetLocalInt(oNPC,"bPROFActionMeth")!=TRUE)
   {
   SetLocalInt(oNPC,"bPROFActionMeth",TRUE);
   AssignCommand(oNPC,ActionDoCommand(SetLocalInt(oNPC,"bPROFActDone",TRUE)));
   }
  }
} // fnPROFActionMethod()


void fnPROFCleanupArgs(object oNPC=OBJECT_SELF)
{ // PURPOSE: To cleanup sArgV# and nArgC variables when they are no longer
  // needed
  int nC=GetLocalInt(oNPC,"nArgC");
  int nLoop=1;
  while(nLoop<=nC)
  { // delete variables
    DeleteLocalString(oNPC,"sArgV"+IntToString(nLoop));
    nLoop++;
  } // delete variables
  DeleteLocalInt(oNPC,"nArgC");
} // fnPROFCleanupArgs()

string GetPCPlayerID(object oPC)
{ // PURPOSE: To return a string representing this players ID
  string sRet="";
  if (GetIsPC(oPC))
  { // is PC
    sRet=GetPCPublicCDKey(oPC)+GetPCPlayerName(oPC)+GetName(oPC);
  } // is PC
  return sRet;
} // GetPlayerID()


//void main(){}
