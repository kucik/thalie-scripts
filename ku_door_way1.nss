
const string way= "1";

void main() {
 object oPC = GetPCSpeaker();
 object oDoors = OBJECT_SELF;

 object oWaypoint = GetLocalObject(oDoors,"WAYPOINT_"+way);
 if(!GetIsObjectValid(oWaypoint)) {
   oWaypoint = GetNearestObjectByTag(GetLocalString(oDoors,"DOORWAY_"+way));
   SetLocalObject(oDoors,"WAYPOINT_"+way,oWaypoint);
 }

 AssignCommand(oPC,ActionJumpToLocation(GetLocation(oWaypoint)));

}
