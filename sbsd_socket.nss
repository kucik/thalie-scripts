/**
 * Switch-Based Secret Doors, v1.0
 * Written by Samuel Ferguson, April 2007
 *
 * This script is modified from nw_02_dtwalldoor by Bioware.
 *
 * This event fires OnDisturbed when an item is placed in the object's
 * inventory.  When the key designated in the item properties is
 * placed inside, the door opens.  When removed, it shuts again.
 * Doors opened by socketed switches are always two-way.
 *
 **/
#include "sbsd_include"
void main()
{
  object oItem = GetInventoryDisturbItem();
  object oPC = GetLastDisturbed();
  object oSwitch = OBJECT_SELF;
  int type = GetInventoryDisturbType();
  int isUseable = GetLocalInt(oSwitch, SBSD_FOUNDYESNO_VAR);
  string doorResref = GetLocalString(oSwitch, SBSD_DOOR_RESREF_VAR);

  // If no resref is defined for the door model, use the default.
  if (doorResref == "")
    doorResref = SBSD_DEFAULT_DOOR_RESREF;

  // If the item matches the required key, open or close the
  // door, and don't let the player manipulate the key until the
  // door's animation is over.
  if ((isUseable) && (GetTag(oItem) == GetLockKeyTag(oSwitch)))
  {
      SetItemCursedFlag(oItem, 1);
      OpenInventory(oPC, oPC);
      DelayCommand(2.0, SetItemCursedFlag(oItem, 0));

      SetUseableFlag(oSwitch, 0);
      DelayCommand(2.0, SetUseableFlag(oSwitch, 1));

      ExecuteScript("sbsd_useswitch", oSwitch);
  }

  // If the item doesn't match, don't let it be moved
  else
  {
    if (type == INVENTORY_DISTURB_TYPE_ADDED)
      ActionGiveItem(oItem, oPC);

    else
      ActionTakeItem(oPC, oItem);

  }
}
