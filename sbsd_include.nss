/* =======================================================================
 *
 * SBSD CONSTANTS
 *
 * These constants define certain parameters of SBSD behavior.  Builders
 * can modify them at will to adjust SBSD to suit their module's needs.
 *
 * =====================================================================*/

/* SBSD HENCHMAN SEARCHING
 *
 * If set to 1, SBSD switches will check the player's henchman's search score
 * instead of the player's if it is higher, as long as the player is within
 * detection range.  This can make it much easier for the player to make use
 * of their henchman's talents.
 *
 * Default: 1
 */
const int SBSD_ALLOW_HENCHMAN_SEARCHING = 1;

/* PASSIVE RANGE MULTIPLE
 *
 * When a player is in passive search mode, all switch detection ranges
 * are multiplied by this value.  Set to 1.0 to disable and use default
 * Neverwinter Nights search behavior.
 *
 * Default: 0.67
 */
const float SBSD_PASSIVE_SEARCH_RANGE_MULTIPLE = 0.67;

/* PASSIVE SKILL MULTIPLE
 *
 * When a player is in passive search mode, his / her search skill is
 * multiplied by this value.  Set to 1.0 to disable and use default
 * Neverwinter Nights search behavior.
 *
 * Default: 0.5
 */
const float SBSD_PASSIVE_SEARCH_SKILL_MULTIPLE = 0.5;

/* GLOBAL SWITCHES
 *
 * Set this to 1 if you want ALL switches in your module to be able to
 * control secret doors in other areas.  If this is set to 0, switches
 * can still be given cross-area access individually by setting the
 * SBSD_CROSSAREA_VAR on the switch.
 *
 * CAUTION: If you set this variable to 1, YOU MUST ensure that every secret
 * door switch or set of linked switches in your module has a unique tag, or
 * you may get unexpected results!
 *
 * If you find that you make most of your switches cross-area switches, you
 * may find it convenient to enable this feature.  For most builders, it
 * is recommended that you leave it disabled and set cross-area behavior
 * on individual switches as necessary.
 *
 * Default: 0
 */
const int SBSD_GLOBAL_SWITCHES_VAR = 0;

/* RESET FOUND SWITCHES
 *
 * Set this to 1 if you want switches to be rehidden when no one is in
 * the area.  This is mainly for persistent worlds.  Socketed switches
 * will be hidden, but their doors will remain open and the keys in their
 * inventories, if applicable.  It is recommended that single-player modules
 * leave this setting disabled.
 *
 * Default: 0
 */
const int SBSD_REHIDE_SWITCHES = 0;

/* REHIDE TIMEOUT
 *
 * If a switch attempts to hide itself when a player is within detection range,
 * the rehide will be delayed for this many seconds before trying again. To
 * prevent CPU seizures, minimum value is 6.0.
 *
 * Default: 18.0
 */
const float SBSD_REHIDE_GLOBAL_TIMEOUT_VAR = 18.0;

/* REHIDE TIMEOUT OVERRIDE
 *
 * If set to 1, a switch that attempts to rehide itself will use its own
 * SBSD_REHIDE_TIMER_VAR, if it has one, as the timeout value instead of the
 * default SBSD_REHIDE_GLOBAL_TIMEOUT_VAR.  If set to 0, the global value
 * will be used for every switch.  Minimum timeout is still six seconds.
 *
 * Default: 0
 */
const int SBSD_REHIDE_TIMEOUT_OVERRIDE_VAR = 0;

/* =======================================================================
 *
 * VARIABLES FOR BUILDERS
 *
 * Set these variables on your switched placeables to define their behavior.
 * Remember that a variable that is not explicitly defined on an object is
 * evaluated as 0 (integers) or "", the empty string (strings).
 *
 * The variable you need to set on your switches is given in quotations.
 * The capital names are used within the SBSD script code.
 *
 * =====================================================================*/

/* SBSD_CROSSAREA_VAR
 *
 * Normally a switch will only open doors at waypoints located in the same
 * area.  If this variable is set to 1, the switch can open secret doors
 * anywhere in the module.  Be sure that no other switch or set of linked
 * switches uses the same tag, or you may get unexpected results.
 */
const string SBSD_CROSSAREA_VAR = "sbsd_crossArea"; //int

/* SBSD_REHIDE_TIMER_VAR
 *
 * If this variable is set to an INTEGER value greater than 0, the switch
 * will automatically re-hide itself after that number of seconds and will
 * have to be found again.
 */
const string SBSD_REHIDE_TIMER_VAR = "sbsd_rehideTimer"; //integer

/* SBSD_REHIDE_CLOSE_DOORS_VAR
 *
 * If this variable is set to 1, a timed or empty-area rehide of the switch
 * will also close associated secret doors.  Otherwise they will remain open.
 * This variable has no effect if the switch is set not to rehide itself.
 * Use this feature with caution, or you may confuse your players if your
 * rehide is currently timed out.
 */
const string SBSD_REHIDE_CLOSE_DOORS_VAR = "sbsd_rehideCloseDoors"; //integer

/* SBSD_PREVENT_RESET_VAR
 *
 * A switch with this variable set to 1 will NOT be reset automatically
 * when there are no players in the area (see constant SBSD_REHIDE_SWITCHES).
 * The individual rehide timer, if set, will ignore this variable.
 */
const string SBSD_PREVENT_RESET_VAR = "sbsd_persistentState"; //integer

/* SBSD_FOUNDYESNO_VAR
 *
 * Set this to 1 if the switch should be accessible right away.  This is
 * -NOT- the same as the "Useable" flag in object properties! This determines
 * whether using the object will activate the associated secret door.  This
 * should =ALWAYS= be set to 1 for levers and other plain-sight switches.
 *
 * This variable is temporarily set to 0 after hitting a switch to prevent
 * rapid-fire clicking.  It is not advisable to manipulate this variable
 * directly except in the initial configuration of the switch.
 */
const string SBSD_FOUNDYESNO_VAR = "sbsd_isUseable"; //integer

/* SBSD_LOCKED_VAR
 *
 * Set this to 1 if the switch is locked - for example, if the secret
 * is activated by placing a special item into a socket.  To set the tag
 * of the key, simply set the object to Locked and put the key's tag
 * in the appropriate field.
 */
const string SBSD_LOCKED_VAR = "sbsd_isLocked"; //string

/* SBSD_TRIGGER_VAR
 *
 * Set this to 1 to enable precision searching.  The player can only find
 * the door if they are inside the trigger with tag SBTR_tag, where tag
 * is the tag of the object on which the switch is hidden.  Entering the
 * trigger does not reveal the secret, it merely enables normal searching.
 **/
const string SBSD_TRIGGER_VAR = "sbsd_usesTriggerToSearch"; //integer

/* SBSD_LINKED_VAR
 *
 * If you want multiple switches to synchronously control a single door,
 * give them all the same tag and set this variable to 1 on ALL of them.
 **/
const string SBSD_LINKED_VAR = "sbsd_linkedSwitch"; //integer

/* SBSD_TIMER_VAR
 *
 * Set this to an integer (NOT A FLOAT!) to force the secret door to
 * automatically close and disappear after this many seconds.  If the
 * value is zero or not set, no timer is applied.
 **/
const string SBSD_TIMER_VAR = "sbsd_timer"; //integer

/* SBSD_ONEWAY_VAR
 *
 * Set this to 1 on a switch to make the door it controls slam shut after
 * the player passes through it.
 */
const string SBSD_ONEWAY_VAR = "sbsd_oneWay"; //int

/* SBSD_NO_ANIMATION_VAR
 *
 * Set this to 1 to prevent the door from playing an open / close animation.
 * This is useful for placeables that don't HAVE such animations, as they
 * will sometimes play an inappropriate sound effect (such as a creaking
 * door for a magic portal).
 */
const string SBSD_NO_ANIMATION_VAR = "sbsd_noAnim"; //int

/* FLAVOR TEXT
 *
 * Custom strings that are displayed when the switch on the object changes
 * states.  If no string is set, the defaults are used.
 *
 * FOUNDSTRING: The player discovers the switch.
 * OPENSTRING: The player uses the switch to open a door.
 * CLOSESTRING: The player uses the switch to close a door.
 * SLAMSTRING: The door closes of its own accord.  This is typically used
 *             for timed or one-way doors.
 **/
const string SBSD_FOUNDSTRING_VAR = "sbsd_foundString"; //string
const string SBSD_OPENSTRING_VAR = "sbsd_openString"; //string
const string SBSD_CLOSESTRING_VAR = "sbsd_closeString"; //string
const string SBSD_SLAMSTRING_VAR = "sbsd_slamString";
//const string SBSD_LOCKEDSTRING_VAR = "sbsd_lockedString"; //string

/* SBSD_DOOR_RESREF_VAR
 *
 * Resref of the placeable that the switch will spawn as a door.  If left
 * blank, a default door will be used.
 */
const string SBSD_DOOR_RESREF_VAR = "sbsd_doorResref"; //string

/* =======================================================================
 *
 * DOOR RESREFS
 *
 * Resrefs for secret door objects.  Add more here if desired.
 * SBSD_DEFAULT_DOOR_RESREF is the default door to open if no resref is
 * explicitly defined on the switch.  The other resrefs are not used by the
 * code and are only here for reference.
 *
 * =====================================================================*/

const string SBSD_DEFAULT_DOOR_RESREF = "sbsd_stone"; //stone wall door
const string SBSD_DEFAULT_WOOD_RESREF = "sbsd_wood"; //wood wall door
const string SBSD_DEFAULT_STONETRAP_RESREF = "sbsd_stonetrap"; //stone trap door
const string SBSD_DEFAULT_WOODTRAP_RESREF = "sbsd_woodtrap"; //wood trap door
const string SBSD_DEFAULT_PORTAL_RESREF = "sbsd_portal"; //yellow portal

/* LEGACY DOOR RESREFS
 *
 * These doors are only relevant to SBSD 1.1 and earlier.  If you are using
 * the old 1.0/1.1 scripts anywhere in your module, do not delete these
 * entries.
 */
const string SBSD_2W_STONE = "sbsd_sdoor";
const string SBSD_2W_WOOD = "sbsd_wdoor";
const string SBSD_1W_STONE = "sbsd_sdoor_1w";
const string SBSD_1W_WOOD = "sbsd_wdoor_1w";


/* =======================================================================
 *
 * SYSTEM VARIABLES
 *
 * The following variables are for system use ONLY!  DO NOT manipulate
 * these variables on your switches, or they will behave erratically!
 *
 * =====================================================================*/

const string SBSD_TOGGLE_VAR = "sbsd_onOff"; //int, is lever on or off?
const string SBSD_SWITCH_IS_VISIBLE_VAR = "sbsd_switchIsVisible"; //int, stop making search checks
const string SBSD_SWITCHTRACKER_VAR = "sbsd_switchThatOpenedMe"; //object, 1-way doors remember the switch they are tied to
const string SBSD_REUNUSE_VAR = "sbsd_reUnuseOnly"; //int, rehide only deactivates the switch
//const string SBSD_TEMPFREEZE_VAR = "sbsd_refuseKeyChange"; //int, supposed to prevent rapid-fire use of socketed switches.  doesn't work


/* =======================================================================
 *
 * FUNCTIONS
 *
 * Functions used in Switch-Based Secret Doors.
 *
 * =====================================================================*/

/* ToggleAnimation
 *
 * oSwitch = object to toggle
 * onOff = current state of oSwitch
 *
 * All this does is play the activate/deactivate animation for levers and
 * similar objects.
 */
void ToggleAnimation(object oSwitch, int onOff)
{
    if (onOff == 0)
    {
      SetLocalInt(oSwitch, SBSD_TOGGLE_VAR, 1);
      AssignCommand(oSwitch, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }

    else
    {
      DeleteLocalInt(oSwitch, SBSD_TOGGLE_VAR);
      AssignCommand(oSwitch, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}


/* OpenSecretDoor
 *
 * oSwitch = object to toggle
 * doorType = resref of the door to spawn
 * oneWay = is it a one-way door?
 *
 * Spawn a door at waypoint SWP_tag and SWP2_tag, where tag is the tag
 * of oSwitch (the object being used).  This is essentially the same
 * as the Bioware function.  Note that the door is automatically opened.
 */
void OpenSecretDoor(object oSwitch, string doorType, int oneWay = FALSE, int multipleAreas = FALSE)
{
    string sTag = GetTag(oSwitch);
    int linked = GetLocalInt(oSwitch, SBSD_LINKED_VAR);
    int noDoorAnim = GetLocalInt(oSwitch, SBSD_NO_ANIMATION_VAR);
    object oidDoor;
    object oidDoor2;

    /* buddy variable is used to ensure all linked switches are toggled
     * simultaneously
     **/
    object buddy;

    location locLoc;
    location locLoc2;

    if (!multipleAreas && !SBSD_GLOBAL_SWITCHES_VAR)
    {
        locLoc = GetLocation (GetNearestObjectByTag("SWP_"+sTag, oSwitch));
        locLoc2 = GetLocation (GetNearestObjectByTag("SWP2_"+sTag, oSwitch));
    }
    else
    {
        locLoc = GetLocation (GetWaypointByTag("SWP_"+sTag));
        locLoc2 = GetLocation (GetWaypointByTag("SWP2_"+sTag));
    }

    // yes we found it, now create the appropriate door
    oidDoor = CreateObject(OBJECT_TYPE_PLACEABLE, doorType, locLoc,TRUE);
    oidDoor2 = CreateObject(OBJECT_TYPE_PLACEABLE, doorType, locLoc2,TRUE);

    if (!noDoorAnim)
    {
      DelayCommand(1.0, AssignCommand(oidDoor, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN)));
      DelayCommand(1.0, AssignCommand(oidDoor2, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN)));
    }

    SetLocalString(oidDoor, "Destination" , "DST_"+sTag );
    SetLocalString(oidDoor2, "Destination" , "DST2_"+sTag );
    // make this door as found.
    SetLocalInt(oSwitch,"D_"+sTag,1);

    // Do the same for all linked switches
    if (linked)
    {
      if (!multipleAreas && !SBSD_GLOBAL_SWITCHES_VAR)
        buddy = GetNearestObjectByTag(sTag, oSwitch, 0);
      else
        buddy = GetObjectByTag(sTag, 0);

      int n = 1;
      while (GetIsObjectValid(buddy))
      {
        SetLocalInt(buddy, "D_"+sTag, 1);
        SetLocalObject(buddy, "Door", oidDoor);
        SetLocalObject(buddy, "Door2", oidDoor2);

        if (!multipleAreas && !SBSD_GLOBAL_SWITCHES_VAR)
          buddy = GetNearestObjectByTag(sTag, oSwitch, n);
        else
          buddy = GetObjectByTag(sTag, n);
        n++;
      }
    }

    SetPlotFlag(oidDoor,1);
    SetPlotFlag(oidDoor2,1);
    SetLocalObject(oSwitch,"Door",oidDoor);
    SetLocalObject(oSwitch,"Door2",oidDoor2);

    if (oneWay)
      SetLocalObject(oidDoor, SBSD_SWITCHTRACKER_VAR, oSwitch);

}

/* CloseSecretDoor
 *
 * oSwitch = object to toggle
 *
 * Close the door associated with this switch, and seal / hide it by
 * destroying it.  It can be reopened later by using the switch again.
 */
void CloseSecretDoor(object oSwitch)
{
      object oidDoor = GetLocalObject(oSwitch, "Door");
      object oidDoor2 = GetLocalObject(oSwitch, "Door2");
      int linked = GetLocalInt(oSwitch, SBSD_LINKED_VAR);
      int multipleAreas = GetLocalInt(oSwitch, SBSD_CROSSAREA_VAR);
      int noDoorAnim = GetLocalInt(oSwitch, SBSD_NO_ANIMATION_VAR);
      string sTag = GetTag(oSwitch);

     /* buddy variable is used to ensure all linked switches are toggled
      * simultaneously
      **/
      object buddy;

      if (GetIsObjectValid(oidDoor))
      {
      AssignCommand(oidDoor, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));
      AssignCommand(oidDoor2, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));

      SetLocalInt(oSwitch,"D_"+sTag,0);

     // Do the same for all linked switches
      if (linked)
      {
         if (!multipleAreas && !SBSD_GLOBAL_SWITCHES_VAR)
           buddy = GetNearestObjectByTag(sTag, oSwitch, 0);
         else
           buddy = GetObjectByTag(sTag, 0);

         int n = 1;
         while (GetIsObjectValid(buddy))
         {
           SetLocalInt(buddy, "D_"+sTag, 0);
           DeleteLocalObject(buddy, "Door");
           DeleteLocalObject(buddy, "Door2");
           if (!multipleAreas && !SBSD_GLOBAL_SWITCHES_VAR)
             buddy = GetNearestObjectByTag(sTag, oSwitch, n);
           else
             buddy = GetObjectByTag(sTag, n);

           n++;
         }
      }

      if (!noDoorAnim)
      {
        DestroyObject(oidDoor, 0.5);
        DestroyObject(oidDoor2, 0.5);
      }
      else
      {
        DestroyObject(oidDoor);
        DestroyObject(oidDoor2);
      }

      DeleteLocalObject(oSwitch, "Door");
      DeleteLocalObject(oSwitch, "Door2");
      }
}

/* HideSwitch
 *
 * Hide the switch.  The player will have to find it again in
 * order to operate it.
 *
 * oSwitch = switch to hide
 * useable = if 0, set the object's useable flag to FALSE
 * minDistance = the switch will only be hidden if there are no players
 *               closer than this distance.  Usually given as the switch's
 *               detection range.
 */

void HideSwitch(object oSwitch, int useable = FALSE, float minDistance = 0.0)
{
  int rehideCloseDoors = GetLocalInt(oSwitch, SBSD_REHIDE_CLOSE_DOORS_VAR);
  int isLocked = GetLocalInt(oSwitch, SBSD_LOCKED_VAR);
  object oidNearestCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSwitch);
  int hideNow = 0;
  int localTimeout;

  if (GetIsObjectValid(oidNearestCreature))
  {
    float fDist = GetDistanceBetween(oSwitch,oidNearestCreature);

    if (fDist > minDistance)
      hideNow = 1;
  }
  else
    hideNow = 1;

  if (hideNow)
  {
    SetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR, FALSE);
    SetLocalInt(oSwitch, SBSD_SWITCH_IS_VISIBLE_VAR, FALSE);

    //  if (useable > 0)
    //    SetUseableFlag(oSwitch, 1);

    //  else
    //    SetUseableFlag(oSwitch, 0);

    SetUseableFlag(oSwitch, useable);

    if (rehideCloseDoors && !isLocked)
      CloseSecretDoor(oSwitch);

    int onOff = GetLocalInt(oSwitch, SBSD_TOGGLE_VAR);
    ToggleAnimation(oSwitch, onOff);

    SetLocked(oSwitch, GetLocalInt(oSwitch, SBSD_LOCKED_VAR));
  }
  else
  {
    if (SBSD_REHIDE_TIMEOUT_OVERRIDE_VAR && ((localTimeout = GetLocalInt(oSwitch, SBSD_REHIDE_TIMER_VAR)) >= 6))
    {
      DelayCommand(0.0+localTimeout, HideSwitch(oSwitch, useable, minDistance));
    }
    else
    {
      if (SBSD_REHIDE_GLOBAL_TIMEOUT_VAR > 6.0)
        DelayCommand(SBSD_REHIDE_GLOBAL_TIMEOUT_VAR, HideSwitch(oSwitch, useable, minDistance));
      else
        DelayCommand(6.0, HideSwitch(oSwitch, useable, minDistance));
    }
  }
}


