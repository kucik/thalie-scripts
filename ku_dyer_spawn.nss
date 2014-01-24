//::///////////////////////////////////////////////
//:: Default: On Spawn In
//:: NW_C2_DEFAULT9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    after having just been spawned in
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////

#include "ku_taylor_inc"

void main()
{
      object oDyer = OBJECT_SELF;
//      object oStand = GetNearestObjectByTag("ku_dyer_stand_m");
      object oChest = GetNearestObjectByTag("ku_dyer_chest");

//      SetLocalObject(oDyer,"KU_STAND",oStand);
      SetLocalObject(oDyer,"KU_CHEST",oChest);
      SetLocalInt(oDyer,"DYE_INV_SLOT",INVENTORY_SLOT_CHEST);

      SetLocked(oChest,FALSE);

      SetListenPattern(OBJECT_SELF, "**", 777); //listen to all text
      SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening

      ku_TaylorInit(OBJECT_SELF);

      int iRandCloths = GetLocalInt(OBJECT_SELF,"random_cloths");
      if(iRandCloths > 0) {
        int iCloth = Random(iRandCloths);
        object oCloth = GetFirstItemInInventory();
        while(iCloth > 0 && GetIsObjectValid(oCloth)) {

          if(GetBaseItemType(oCloth) == BASE_ITEM_ARMOR) {
            iCloth--;
          }
          if(iCloth > 0) {
            oCloth = GetNextItemInInventory();
          }
        }

        if(GetIsObjectValid(oCloth)) {
          AssignCommand(OBJECT_SELF,ActionEquipItem(oCloth,INVENTORY_SLOT_CHEST));
        }
        DeleteLocalInt(OBJECT_SELF,"random_cloths");
      }

}


