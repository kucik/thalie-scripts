////////////////////////////////////////////////////////////////////////////////
// npcact_h_moving - The movement library for NPC ACTIVITIES 6.0
// By Deva Bryson Winblood.
// Last Modified By: Deva Bryson Winblood   ON: 2/4/2006
////////////////////////////////////////////////////////////////////////////////

const int MOVE_DEBUG_ON = FALSE; // set to TRUE if you want movement debug messages
const string MOVE_DEBUG_NPC = ""; // set to tag of specific NPC if you wish to debug movement

/////////////////////////////////////////
// PROTOTYPES
/////////////////////////////////////////

// FILE: npcact_h_moving  FUNCTION: fnMoveToDestination()
//-------------------------------------------------------
// This function is called to move an npc to a specified destination oDest
// to the range fRange.  This function uses anti-stuck scripting technology,
// supports multiple movement methods, and can make calls to more complex pathing
// commands if need be.  It also checks nearby doors, triggers, and placeables to
// insure that the closest entrance to another area is chosen.  This is done to
// prevent the choosing a further door problem that Bioware pathing sometimes uses
// when there are more than one door linking to another area.  It will with Bioware
// sometimes wander to another door rather than using the one it is standing directly
// next to.   This has been addressed by this function.  The function returns the
// following values:  0 = still pathing, 1=arrived, -1 = error unreachable
// -1 and 1 you must react to.  -1 is returned when even with all the anti-stuck
// technology the NPC was still unable to reach the destination.
int fnMoveToDestination(object oNPC,object oDest,float fRange=1.0);

// FILE: npcact_h_moving  FUNCTION: MOVE_LocationInDirection
//----------------------------------------------------------
// This function will take a specified starting direction and provide another
// location in the direction specified fDistance from the specified location.
location MOVE_LocationInDirection(location lStart,float fDirection,float fDistance);


/////////////////////////////////////////
// FUNCTIONS
/////////////////////////////////////////

location MOVE_LocationInDirection(location lStart,float fDirection,float fDistance)
{ // PURPOSE: Return a new location fDistance in the fDirection facing from lStart
  location lRet;
  vector vVec=GetPositionFromLocation(lStart);
  float fX,fY,fZ,fNX,fNY,fNZ;
  float fDX,fDY,fDZ;
  object oArea=GetAreaFromLocation(lStart);
  fX=vVec.x;
  fY=vVec.y;
  fZ=vVec.z;
  if (fDirection>=0.0&&fDirection<22.5)
  { // 0
    fDY=1.0;
  } // 0
  else if (fDirection>=22.5&&fDirection<45.0)
  { // 1
    fDY=0.75;
    fDX=0.25;
  } // 1
  else if (fDirection>=45.0&&fDirection<67.5)
  { // 2
    fDY=0.5;
    fDX=0.5;
  } // 2
  else if (fDirection>=67.5&&fDirection<90.0)
  { // 3
    fDY=0.25;
    fDX=0.75;
  } // 3
  else if (fDirection>=90.0&&fDirection<112.5)
  { // 4
    fDY=0.0;
    fDX=1.0;
  } // 4
  else if (fDirection>=112.5&&fDirection<135.0)
  { // 5
    fDY=-0.25;
    fDX=0.75;
  } // 5
  else if (fDirection>=135.0&&fDirection<157.5)
  { // 6
    fDY=-0.5;
    fDX=0.5;
  } // 6
  else if (fDirection>=157.5&&fDirection<180.0)
  { // 7
    fDY=-0.75;
    fDX=0.25;
  } // 7
  else if (fDirection>=180.0&&fDirection<202.5)
  { // 8
    fDY=-1.0;
    fDX=0.0;
  } // 8
  else if (fDirection>=202.5&&fDirection<225.0)
  { // 9
    fDY=-0.75;
    fDX=-0.25;
  } // 9
  else if (fDirection>=225.0&&fDirection<247.5)
  { // 10
    fDY=-0.5;
    fDX=-0.5;
  } // 10
  else if (fDirection>=247.5&&fDirection<270.0)
  { // 11
    fDY=-0.25;
    fDX=-0.75;
  } // 11
  else if (fDirection>=270.0&&fDirection<292.5)
  { // 12
    fDX=-1.0;
  } // 12
  else if (fDirection>=292.5&&fDirection<315.0)
  { // 13
    fDY=0.25;
    fDX=-0.75;
  } // 13
  else if (fDirection>=315.0&&fDirection<337.5)
  { // 14
    fDY=0.5;
    fDX=-0.5;
  } // 14
  else if (fDirection>337.5)
  { // 15
    fDY=0.75;
    fDX==0.25;
  } // 15
  fNX=(fDX*fDistance)+fX;
  fNY=(fDY*fDistance)+fY;
  vVec.x=fNX;
  vVec.y=fNY;
  lRet=Location(oArea,vVec,fDirection);
  return lRet;
} // MOVE_LocationInDirection()

void DebugMove(string sSay)
{ // PURPOSE: To display debug messages for movement
  // LAST MODIFIED BY: Deva Bryson Winblood  6/25/2004
  string sMsg="["+GetTag(OBJECT_SELF)+"] [npcact_h_moving debug] "+sSay;
  if (MOVE_DEBUG_ON)
  { // movement debug
    if (GetStringLength(MOVE_DEBUG_NPC)<3||GetTag(OBJECT_SELF)==MOVE_DEBUG_NPC)
    { // okay to display
      SendMessageToPC(GetFirstPC(),sMsg);
      PrintString("[npcact_h_moving debug] "+sMsg);
    } // okay to display
  } // movement debug
} // DebugMove()

object fnFindRandomDestination(object oFrom,int bUseObjects=FALSE)
{ // PURPOSE: To find a random destination from a specific object
  // If bUseObjects is set to TRUE it will use the older method of
  // grabbing a random object as opposed to calculating a new destination
  object oOb=OBJECT_INVALID;
  int nL;
  int nN;
  int nXSize;
  int nYSize;
  float fF;
  vector vVec;
  location lLoc;
  object oArea=GetArea(oFrom);
  float fX,fY;
  if (bUseObjects)
  { // use random objects
    oOb=GetNearestObject(OBJECT_TYPE_WAYPOINT,oFrom,d100());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_WAYPOINT,oFrom,d20());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_WAYPOINT,oFrom,d12());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_PLACEABLE,oFrom,d20());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_PLACEABLE,oFrom,d12());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_ITEM,oFrom,d20());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_ITEM,oFrom,d12());
    if (oOb==OBJECT_INVALID) oOb=GetNearestObject(OBJECT_TYPE_ALL,oFrom,d10());
    return oOb;
  } // use random objects
  else
  { // calculate location
    nXSize=GetAreaSize(AREA_WIDTH,oArea);
    nYSize=GetAreaSize(AREA_HEIGHT,oArea);
    nN=Random(nXSize*10);
    fX=IntToFloat(nN);
    nN=Random(nYSize*10);
    fY=IntToFloat(nN);
    vVec=GetPosition(oFrom);
    vVec.x=fX;
    vVec.y=fY;
    lLoc=Location(oArea,vVec,GetFacing(oFrom));
    oOb=CreateObject(OBJECT_TYPE_WAYPOINT,"nw_waypoint001",lLoc,FALSE,"NPCACT_TEMPORARY");
    DelayCommand(10.0,DestroyObject(oOb));
    return oOb;
  } // calculate location
  return OBJECT_INVALID;
} // fnFindRandomDestination()

int fnHandleStuck(object oNPC,object oDest,int nASC,int nASR,int nRun)
{ // PURPOSE: To handle anti-stuck situations
  // LAST MODIFIED BY: Deva Bryson Winblood  6/25/2004
  int nRet=0;
  object oOb;
  object oMe=oNPC;
  float fR;
  int nR;
  nASC++;
  SetLocalInt(oNPC,"nGNBASC",nASC);
  if (nASC==1)
  { // first encounter
    AssignCommand(oNPC,ClearAllActions(TRUE));
    AssignCommand(oNPC,ActionMoveToObject(oDest,nRun));
  } // first encounter
  else if (nASC==3&&nASR<3)
  { // pick a nearby object to move near
    oOb=fnFindRandomDestination(oMe);
    if (GetIsObjectValid(oOb))
    { // found temporary target
      AssignCommand(oNPC,ClearAllActions(TRUE));
      AssignCommand(oNPC,ActionMoveToObject(oOb,nRun));
      nR=d4();
      fR=4.0+IntToFloat(nR);
      DelayCommand(fR,AssignCommand(oNPC,ClearAllActions(TRUE)));
      DelayCommand(fR+0.1,AssignCommand(oNPC,ActionMoveToObject(oDest,nRun)));
    } // found temporary target
    SetLocalInt(oNPC,"nGNBASC",0);
    nASR++;
    SetLocalInt(oNPC,"nGNBASR",nASR);
  } // pick a nearby object to move near
  else if (nASC==3&&nASR==3)
  { // teleport
    AssignCommand(oMe,ClearAllActions(TRUE));
    AssignCommand(oMe,JumpToLocation(GetLocation(oDest)));
  } // teleport
  else if (nASC>3)
  { // can't get there
    DeleteLocalFloat(oNPC,"fLastDist");
    DeleteLocalInt(oNPC,"nGNBASC");
    DeleteLocalInt(oNPC,"nGNBASR");
    DeleteLocalObject(oNPC,"oGNBNearbyObject");
    return -1;
  } // can't get there
  return nRet;
} // fnHandleStuck()

void fnJumpNPC(object oNPC,object oDest,float fRange)
{ // PURPOSE: Move the NPC quick
  if (GetArea(oNPC)!=GetArea(oDest)||GetDistanceBetween(oNPC,oDest)>fRange)
  { // teleport
    if (GetIsInCombat(oNPC)==FALSE)
    { // okay to teleport
      AssignCommand(oNPC,ClearAllActions());
      AssignCommand(oNPC,JumpToObject(oDest));
      DelayCommand(6.0,fnJumpNPC(oNPC,oDest,fRange));
    } // okay to teleport
  } // teleport
} // fnJumpNPC()

void fnLowAINoPCMove(object oNPC,object oDest,float fRange)
{ // PURPOSE: To Assign to the module object to handle movement of this
  // NPC if AI level is less than normal.
  float fTime=5.0;
  object oOb;
  if (GetLocalInt(oNPC,"bModulePossessed")!=TRUE)
  { // possess
    SetLocalInt(oNPC,"bModulePossessed",TRUE);
    if (GetArea(oDest)==GetArea(oNPC))
    { // same area
      fTime=fTime+(GetDistanceBetween(oNPC,oDest)/3.0);
      DelayCommand(fTime,fnJumpNPC(oNPC,oDest,fRange));
    } // same area
    else
    { // different area
      DelayCommand(60.0,fnJumpNPC(oNPC,oDest,fRange));
    } // different area
  } // possess
} // fnLowAINoPCMove()

int fnMoveToDestination(object oNPC,object oDest,float fRange=1.0)
{ // PURPOSE: Version 2.0 of the fnMoveToDestination function
  // VARIABLES:
  // OnModule
  // ========
  // bGNBAccuratePathing if set to 1 will always try to get nearby transition
  // OnNPC
  // ========
  // bGNBAccuratePathing if set to 1 will always try to get nearby transition
  // bGNBQuickMove  if set to 1 will use jump and such to move NPCs when no PCs
  //                are around to witness it.
  int nRet=0;
  int nN;
  object oT;
  object oD;
  object oC;
  float fD;
  object oRelative;  // oGNBNearbyObject
  int nASC;          // nGNBASC
  int nASR;          // nGNBASR
  int nGRun;          // nGNBRun
  int nRun;         // nRun
  float fLD;        // fLastDist
  float fDist;
  effect eEff;
  float fF;
  float fFF;
  //vector vVec;
  //vector vNew;
  //location lLoc;
  int bNoAIHandle=FALSE;
  int bAP=GetLocalInt(GetModule(),"bGNBAccuratePathing");
  int nAIL=GetAILevel(oNPC);
  object oPCN=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oNPC,1,CREATURE_TYPE_IS_ALIVE,TRUE);
  object oPCD=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oDest,1,CREATURE_TYPE_IS_ALIVE,TRUE);
  object oEnemy=GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNPC,1,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_IS_ALIVE,TRUE);
  if (!bAP) bAP=GetLocalInt(oNPC,"bGNBAccuratePathing");
  DebugMove("fnMoveToDestination("+GetTag(oNPC)+","+GetTag(oDest)+","+FloatToString(fRange)+")");
  if (oPCN==OBJECT_INVALID&&oPCD==OBJECT_INVALID&&oEnemy==OBJECT_INVALID&&GetLocalInt(oNPC,"bGNBQuickMove")==TRUE)
  { // might be able to take short cut
    if (nAIL!=AI_LEVEL_HIGH&&nAIL!=AI_LEVEL_VERY_HIGH&&nAIL!=AI_LEVEL_NORMAL) bNoAIHandle=TRUE;
  } // might be able to take short cut
  if (!bNoAIHandle)
  { // AI level is sufficient or PCs are present
  DebugMove("   Normal movement");
  nGRun=GetLocalInt(oNPC,"nGNBRun");
  if (nGRun<5)
  { // no instant movement
    nRun=FALSE;
    if (nGRun==1) nRun=TRUE;
    if (nGRun==0||nGRun==1) { // no stealth or search
            SetActionMode(oNPC,ACTION_MODE_DETECT,FALSE);
            SetActionMode(oNPC,ACTION_MODE_STEALTH,FALSE);
    } // no stealth or search
    else if (nGRun==2||nGRun==4)
    { // hide
            SetActionMode(oNPC,ACTION_MODE_STEALTH,TRUE);
    } // hide
    if (nGRun==3||nGRun==4)
    { // search
            SetActionMode(oNPC,ACTION_MODE_DETECT,TRUE);
    } // search
    if (GetArea(oNPC)==GetArea(oDest))
    { // NPC is in the same area as the destination
      DebugMove("     Same Area");
      if (GetDistanceBetween(oNPC,oDest)<=fRange)
      { // arrived
        // cleanup variables  return 1;
        DeleteLocalInt(oNPC,"nGNBASC");
        DeleteLocalInt(oNPC,"nGNBASR");
        DeleteLocalFloat(oNPC,"fLastDist");
        DeleteLocalObject(oNPC,"oGNBNearbyObject");
        return 1;
      } // arrived
      else
      { // not close enough
        fLD=GetLocalFloat(oNPC,"fLastDist");
        fDist=GetDistanceBetween(oNPC,oDest);
        if (fDist==fLD)
        { // have not moved - could be stuck
          nASC=GetLocalInt(oNPC,"nGNBASC");
          nASR=GetLocalInt(oNPC,"nGNBASR");
          nASC++;
          DebugMove("      anti-stuck nASC="+IntToString(nASC)+"  nASR="+IntToString(nASR));
          if (nASC<3)
          { // just try to move again
            AssignCommand(oNPC,ClearAllActions());
            AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange));
          } // just try to move again
          else if (nASC>2&&nASR<3)
          { // try nearby object
            oRelative=fnFindRandomDestination(oNPC);
            if (oRelative!=OBJECT_INVALID)
            { // object found
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,ActionMoveToObject(oRelative,TRUE,1.0));
              DelayCommand(5.0,AssignCommand(oNPC,ClearAllActions()));
              DelayCommand(5.1,AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange)));
              nASR++;
              SetLocalInt(oNPC,"nGNBASR",nASR);
            } // object found
          } // try nearby object
          else if (nASC>2&&nASR<5)
          { // jump to location
            nASR++;
            DebugMove("        Teleport called to handle stuck.");
            SetLocalInt(oNPC,"nGNBASR",nASR);
            AssignCommand(oNPC,ClearAllActions());
            AssignCommand(oNPC,JumpToObject(oDest));
          } // jump to loaction
          else if (nASR>4)
          { // ERROR
            return -1;
          } // ERROR
          SetLocalInt(oNPC,"nGNBASC",nASC);
        } // have not moved - could be stuck
        else if (fLD!=0.0)
        { // not stuck
          DeleteLocalInt(oNPC,"nGNBASC");
          SetLocalFloat(oNPC,"fLastDist",fDist);
          return 0;
        } // not stuck
        else
        { // have not tried to move yet
          AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange));
          SetLocalFloat(oNPC,"fLastDist",fDist);
          return 0;
        } // have not tried to move yet
        SetLocalFloat(oNPC,"fLastDist",fDist);
      } // not close enough
    } // NPC is in the same area as the destination
    else
    { // different area
      DebugMove("     Different Area");
      nN=1;
      if (bAP)
      { // accurate pathing
        oC=GetLocalObject(oNPC,"oNearestTransition");
        oT=GetNearestObject(OBJECT_TYPE_TRIGGER,oNPC,nN);
        oD=GetNearestObject(OBJECT_TYPE_DOOR,oNPC,nN);
      } // accurate pathing
      else
      { // standard pathing
        oC=OBJECT_INVALID;
        oT=OBJECT_INVALID;
        oD=OBJECT_INVALID;
      } // standard pathing
      while(oC==OBJECT_INVALID&&(oT!=OBJECT_INVALID||oD!=OBJECT_INVALID)&&bAP)
      { // look for nearest transition
        nN++;
        if (oT!=OBJECT_INVALID)
        { // trigger found
          if (GetTransitionTarget(oT)!=OBJECT_INVALID)
          { // transition found
            if (GetArea(GetTransitionTarget(oT))==GetArea(oDest))
            { // same area
              oC=oT;
              SetLocalObject(oNPC,"oNearestTransition",oC);
            } // same area
          } // transition found
        } // trigger found
        if (oD!=OBJECT_INVALID&&(GetDistanceBetween(oT,oNPC)<GetDistanceBetween(oD,oNPC)||oC==OBJECT_INVALID))
        { // door found
          if (GetTransitionTarget(oD)!=OBJECT_INVALID)
          { // transition found
            if (GetArea(GetTransitionTarget(oD))==GetArea(oDest))
            { // same area
              oC=oD;
              SetLocalObject(oNPC,"oNearestTransition",oC);
            } // same area
          } // transition found
        } // door found
        oT=GetNearestObject(OBJECT_TYPE_TRIGGER,oNPC,nN);
        oD=GetNearestObject(OBJECT_TYPE_DOOR,oNPC,nN);
      } // look for nearest transition
      if (oC==OBJECT_INVALID||!bAP)
      { // long distance pathing
        DebugMove("       Long Distance Pathing");
        oRelative=GetLocalObject(oNPC,"oGNBNearbyObject");
        if (oRelative==OBJECT_INVALID||GetArea(oRelative)!=GetArea(oNPC))
        { // find nearby object
          oRelative=GetNearestObject(OBJECT_TYPE_WAYPOINT,oNPC,1);
          if (oRelative==OBJECT_INVALID) oRelative=GetNearestObject(OBJECT_TYPE_PLACEABLE,oNPC,1);
          if (oRelative==OBJECT_INVALID) oRelative=GetNearestObject(OBJECT_TYPE_DOOR,oNPC,1);
          if (oRelative==OBJECT_INVALID) oRelative=GetNearestObject(OBJECT_TYPE_TRIGGER,oNPC,1);
          if (oRelative!=OBJECT_INVALID)
          { // relative object found
            SetLocalObject(oNPC,"oGNBNearbyObject",oRelative);
            fLD=GetDistanceBetween(oNPC,oRelative);
            SetLocalFloat(oNPC,"fLastDist",fLD);
            DeleteLocalInt(oNPC,"nGNBASC");
            DeleteLocalInt(oNPC,"nGNBASR");
            AssignCommand(oNPC,ClearAllActions());
            AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange));
            return 0;
          } // relative object found
        } // find nearby object
        else
        { // object exists
          fDist=GetDistanceBetween(oNPC,oRelative);
          fLD=GetLocalFloat(oNPC,"fLastDist");
          if (fDist==fLD)
          { // might be stuck
            nASC=GetLocalInt(oNPC,"nGNBASC");
            nASR=GetLocalInt(oNPC,"nGNBASR");
            nASC++;
            DebugMove("      anti-stuck nASC="+IntToString(nASC)+"  nASR="+IntToString(nASR));
            if (nASC<3)
            { // regular movement restart
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange));
            } // regular movement restart
            else if (nASC>2&&nASR<3)
            { // try nearby object
              oRelative=fnFindRandomDestination(oNPC);
              if (oRelative!=OBJECT_INVALID)
              { // object found
                AssignCommand(oNPC,ClearAllActions());
                AssignCommand(oNPC,ActionMoveToObject(oRelative,TRUE,1.0));
                DelayCommand(5.0,AssignCommand(oNPC,ClearAllActions()));
                DelayCommand(5.1,AssignCommand(oNPC,ActionMoveToObject(oDest,nRun,fRange)));
                nASR++;
              } // object found
            } // try nearby object
            else if (nASC>2&&nASR>2)
            { // try teleport
              DebugMove("        Teleport called to handle stuck.");
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,JumpToObject(oDest));
              nASR++;
            } // try teleport
            else if (nASR>4)
            { // error
              return -1;
            } // error
            SetLocalInt(oNPC,"nGNBASC",nASC);
            SetLocalInt(oNPC,"nGNBASR",nASR);
            return 0;
          } // might be stuck
          else
          { // not stuck
            DeleteLocalInt(oNPC,"nGNBASC");
          } // not stuck
          SetLocalFloat(oNPC,"fLastDist",fDist);
          return 0;
        } // object exists
      } // long distance pathing
      else
      { // use nearest transition
        DebugMove("    Use nearby transition");
        if (GetDistanceBetween(oNPC,oC)<=1.5)
        { // arrived at transition
          AssignCommand(oNPC,ClearAllActions());
          if (GetObjectType(oC)==OBJECT_TYPE_DOOR&&GetIsOpen(oC)==FALSE)
          { // face and open door
            AssignCommand(oNPC,ActionOpenDoor(oC));
            if (GetObjectType(GetTransitionTarget(oC))==OBJECT_TYPE_DOOR)
              AssignCommand(GetTransitionTarget(oC),ActionOpenDoor(oC));
          } // face and open door
          oEnemy=GetTransitionTarget(oC);
          oPCN=GetNearestObject(OBJECT_TYPE_WAYPOINT,oEnemy,1);
          if (oPCN==OBJECT_INVALID) oPCN=GetNearestObject(OBJECT_TYPE_PLACEABLE,oEnemy,1);
          if (oPCN==OBJECT_INVALID) oPCN=oEnemy;
          AssignCommand(oNPC,JumpToObject(oPCN));
          DeleteLocalInt(oNPC,"nGNBASC");
          DeleteLocalInt(oNPC,"nGNBASR");
          DeleteLocalFloat(oNPC,"fLastDist");
          return 0;
        } // arrived at transition
        else
        { // move to nearby transition
          fLD=GetLocalFloat(oNPC,"fLastDist");
          fDist=GetDistanceBetween(oNPC,oC);
          nASC=GetLocalInt(oNPC,"nGNBASC");
          nASR=GetLocalInt(oNPC,"nGNBASR");
          if (fLD==fDist)
          { // might be stuck
            nASC++;
            DebugMove("      anti-stuck nASC="+IntToString(nASC)+"  nASR="+IntToString(nASR));
            if (nASC<3)
            { // regular movement restart
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,ActionMoveToLocation(GetLocation(oC),nRun));
            } // regular movement restart
            else if (nASC>2&&nASR<3)
            { // try nearby object
              oRelative=fnFindRandomDestination(oNPC);
              if (oRelative!=OBJECT_INVALID)
              { // object found
                AssignCommand(oNPC,ClearAllActions());
                AssignCommand(oNPC,ActionMoveToObject(oRelative,TRUE,1.0));
                DelayCommand(5.0,AssignCommand(oNPC,ClearAllActions()));
                DelayCommand(5.1,AssignCommand(oNPC,ActionMoveToLocation(GetLocation(oC),nRun)));
                nASR++;
              } // object found
            } // try nearby object
            else if (nASC>2&&nASR>2)
            { // try teleport
              DebugMove("        Teleport called to handle stuck.");
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,JumpToLocation(GetLocation(oC)));
              nASR++;
            } // try teleport
            else if (nASR>4)
            { // error
              AssignCommand(oNPC,ClearAllActions());
              AssignCommand(oNPC,ActionForceMoveToObject(oDest,TRUE,fRange,60.0));
            } // error
            SetLocalInt(oNPC,"nGNBASC",nASC);
            SetLocalInt(oNPC,"nGNBASR",nASR);
            return 0;
          } // might be stuck
          else
          { // not stuck
            nASC=0;
          } // not stuck
          SetLocalInt(oNPC,"nGNBASC",nASC);
          SetLocalInt(oNPC,"nGNBASR",nASR);
          SetLocalFloat(oNPC,"fLastDist",fDist);
          return 0;
        } // move to nearby transition
      } // use nearest transition
    } // different area
  } // no instant movement
  else
  { // teleport like movement
    nASC=GetLocalInt(oNPC,"nGNBASC");
    nASR=GetLocalInt(oNPC,"nGNBASR");
    DebugMove("  Teleport Style Movement");
    if (nASR==0)
    { // do teleport
      if (nGRun==5) { AssignCommand(oNPC,ClearAllActions(TRUE)); AssignCommand(oNPC,JumpToObject(oDest)); }
      else if (nGRun==6)
      { // teleport w/ VFX
        AssignCommand(oNPC,ClearAllActions(TRUE));
        eEff=EffectVisualEffect(VFX_FNF_IMPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,GetLocation(oNPC),3.0);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,GetLocation(oDest),3.0);
        DelayCommand(0.8,AssignCommand(oNPC,JumpToObject(oDest)));
      } // teleport w/ VFX
      else if (nGRun==7)
      { // fly out and then in
        AssignCommand(oNPC,ClearAllActions(TRUE));
        eEff=EffectDisappearAppear(GetLocation(oDest),1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEff,oNPC,4.0);
      } // fly out and then in
      else if (nRun==8)
      { // custom VFX teleport
        AssignCommand(oNPC,ClearAllActions(TRUE));
        nN=GetLocalInt(oNPC,"nGNBVFX1");
        eEff=EffectVisualEffect(nN);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEff,GetLocation(oNPC),4.0);
        nN=GetLocalInt(oNPC,"nGNBVFX2");
        eEff=EffectVisualEffect(nN);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eEff,GetLocation(oDest),4.0);
        DelayCommand(2.5,AssignCommand(oNPC,JumpToObject(oDest)));
      } // custom VFX teleport
      SetLocalInt(oNPC,"nGNBASR",1);
    } // do teleport
    else if (nASR==1)
    { // effect called
      nASC++;
      if (GetArea(oDest)==GetArea(oNPC)&&GetDistanceBetween(oDest,oNPC)<=fRange)
      { // arrived
        DeleteLocalFloat(oNPC,"fLastDist");
        DeleteLocalInt(oNPC,"nGNBASC");
        DeleteLocalInt(oNPC,"nGNBASR");
        DeleteLocalObject(oNPC,"oGNBNearbyObject");
        return 1;
      } // arrived
      else if (nASC>4)
      { // did not arrive
        DeleteLocalFloat(oNPC,"fLastDist");
        DeleteLocalInt(oNPC,"nGNBASC");
        DeleteLocalInt(oNPC,"nGNBASR");
        DeleteLocalObject(oNPC,"oGNBNearbyObject");
        return -1;
      } // did not arrive
      SetLocalInt(oNPC,"nGNBASC",nASC);
    } // effect called
  } // teleport like movement
  } // AI level is sufficient or PCs are present
  else
  { // handle no PC present and low AI level
    if (GetArea(oDest)!=GetArea(oNPC)||GetDistanceBetween(oNPC,oDest)>fRange)
    { // move
      DebugMove("  Execute Low-AI and No PC present movement routines");
      AssignCommand(GetModule(),fnLowAINoPCMove(oNPC,oDest,fRange));
      return 0;
    } // move
    else
    { // arrived
      DeleteLocalInt(oNPC,"bModulePossessed");
      return 1;
    } // arrived
  } // handle no PC present and loq AI level
  return nRet;
} // fnMoveToDestination()


//void main(){}
