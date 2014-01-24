/**
 * Switch-Based Secret Doors, v1.2
 * Written by Samuel Ferguson, April 2007
 *
 * This script is modified from nw_02_dtwalldoor by Bioware.
 *
 * Called from OnUsed.  Creates a one-way stone secret wall door.
 *
 * Spawns secret doors from a switch instead of a search trigger.
 * Spawns at location of SWP_<tag> and leads to DST_<tag>, where
 * <tag> is this object's tag.  If you place SWP2_<tag> and
 * DST2_<tag>, the switch will control two doors at once.  This is
 * handy for making a two-way door with one switch.
 *
 * If the door is already opened, using the switch again will
 * close it and hide it.
 *
 * If the switch object has the variable "sbsd_linkedSwitch" set
 * to 1, all switches with the same tag will be toggled at the
 * same time and will control the same door.  Make sure to set
 * sbsd_linkedSwitch on all switches that you want to link, or
 * they will not toggle each other properly.
 *
 * v1.2
 * ----
 * This script is based on the old sbsd_trapdoor scripts.  It now
 * functions for any switch and takes configuration variables from it
 * to define behavior.
 *
 **/

#include "sbsd_include"

void main()
{
    object oSwitch = OBJECT_SELF;
    string sTag = GetTag(oSwitch);
    string sOpen;
    string sClose;
    string sSlam;
    object oPC = GetLastUsedBy();
    int onOff = GetLocalInt(oSwitch, SBSD_TOGGLE_VAR);
    int linked = GetLocalInt(oSwitch, SBSD_LINKED_VAR);
    int timer = GetLocalInt(oSwitch, SBSD_TIMER_VAR);
    int isUsable = GetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR);
    int oneWay = GetLocalInt(oSwitch, SBSD_ONEWAY_VAR);
    int isLocked = GetLocalInt(oSwitch, SBSD_LOCKED_VAR);
    int crossArea = GetLocalInt(oSwitch, SBSD_CROSSAREA_VAR);
    string doorResref = GetLocalString(oSwitch, SBSD_DOOR_RESREF_VAR);

    // If no resref is defined for the door model, use the default.
    if (doorResref == "")
      doorResref = SBSD_DEFAULT_DOOR_RESREF;

    // Socketed switches never spawn one-way doors
    if (isLocked)
      oneWay = 0;

    object oidDoor;
    object oidDoor2;

    ToggleAnimation(oSwitch, onOff);

    // Define default strings if necessary
    sOpen = GetLocalString(oSwitch, SBSD_OPENSTRING_VAR);
    if (sOpen == "")
      sOpen = "You hear a scraping noise from somewhere nearby.";

    sClose = GetLocalString(oSwitch, SBSD_CLOSESTRING_VAR);
    if (sClose == "")
      sClose = "You hear a hollow bang from somewhere nearby.";

    sSlam = GetLocalString(oSwitch, SBSD_SLAMSTRING_VAR);
    if (sSlam == "")
      sSlam = "You hear a hollow bang from somewhere nearby.";

    // If the switch is active when the user clicks on it
    if (isUsable)
    {

      // If the door doesn't exist, create and open it
      if (GetLocalInt(oSwitch, "D_"+sTag) == 0)
      {
        FloatingTextStringOnCreature(sOpen, oPC, FALSE);
        OpenSecretDoor(oSwitch, doorResref, oneWay, crossArea);

        // If the switch is timed, close the door when the timer expires
        if (timer > 0)
        {
          DelayCommand(2.0+timer, FloatingTextStringOnCreature(sSlam, oPC, FALSE));
          DelayCommand(2.0+timer, CloseSecretDoor(oSwitch));
        }

        // Disable the switch for 2+timer seconds to prevent rapid fire
        // clicking
        SetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR, 0);
        DelayCommand(2.0+timer, SetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR, 1));

        SetUseableFlag(oSwitch, 0);
        DelayCommand(2.0+timer, SetUseableFlag(oSwitch, 1));
      }

      // If the door exists, close and destroy it
      else
      {
        FloatingTextStringOnCreature(sClose, oPC, FALSE);
        SetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR, 0);
        DelayCommand(2.0, SetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR, 1));
        SetUseableFlag(oSwitch, 0);
        DelayCommand(2.0, SetUseableFlag(oSwitch, 1));
        CloseSecretDoor(oSwitch);
      }
    }
}
