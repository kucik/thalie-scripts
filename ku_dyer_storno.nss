/*
 * rev. 27.06.2008 Kucik Nahrazeni move funkci za copy
 */

#include "nwnx_funcs"
#include "ku_taylor_inc"

void main()
{

//  object oStand = GetLocalObject(OBJECT_SELF,"KU_STAND");
//  object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST,oStand);
  object oDyer = OBJECT_SELF;
//  object oChest = GetLocalObject(oDyer,"KU_CHEST");
  object oNCloth;
//  int iSlot = GetLocalInt(oDyer,"DYE_INV_SLOT");
  object oCloth = GetLocalObject(oDyer,"ITEM");
  object oOldCloth = GetLocalObject(oDyer,"ITEM_BACKUP");
  object oPC = GetPCSpeaker();
  DestroyObject(oCloth);
  oNCloth = CopyItem(oOldCloth,oPC,TRUE);
  DestroyObject(oOldCloth);

  DeleteLocalObject(oDyer,"CUSTOMER");
  DeleteLocalObject(oDyer,"ITEM");
  DeleteLocalObject(oDyer,"ITEM_BACKUP");
  DeleteLocalInt(oDyer,"working");
  AssignCommand(oPC,ActionEquipItem(oNCloth,GetLocalInt(oDyer,"DYE_INV_SLOT")));





/*  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH1)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;
  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH2)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;
  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER1)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;
  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER2)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;
  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL1)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;
  oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL2)),TRUE);
  DestroyObject(oCloth,0.2);
  oCloth = oNCloth;

  CopyItem(oNCloth,oChest,TRUE);
  DestroyObject(oNCloth);
//  DelayCommand(0.4,AssignCommand(oChest,ActionTakeItem(oCloth,oStand)));

  SetLocalObject(oDyer,"CUSTOMER",OBJECT_INVALID);
  SetLocked(oChest,FALSE);

//  oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST,oStand);
//  DestroyObject(oCloth);
*/
  SetCustomToken(6001,"0");
  int i;
  for(i = 0; i <= 20 ; i++)
    DestroyObject(GetNearestObjectByTag("ku_dyer_light"+IntToString(i)));
  DeleteLocalInt(OBJECT_SELF,"DYER_MACHINE_ACTIVATED");

}
