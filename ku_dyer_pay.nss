#include "ku_libtime"
#include "ku_taylor_inc"
#include "nwnx_funcs"

/*
 * rev. 27.06.2008 Kucik Nahrazeni move funkci za copy
 */

void main()
{
//  object oStand = GetLocalObject(OBJECT_SELF,"KU_STAND");
//  object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST,oStand);
  object oDyer = OBJECT_SELF;
  int iSlot = GetLocalInt(oDyer,"DYE_INV_SLOT");
//  object oCloth = GetItemInSlot(iSlot,oStand);
//  object oChest = GetLocalObject(oDyer,"KU_CHEST");
  object oCloth = GetLocalObject(oDyer,"ITEM");
  object oOldCloth = GetLocalObject(oDyer,"ITEM_BACKUP");
  object oPC = GetPCSpeaker();
  int iPrice = 0;

/*
  if( GetLocalInt(oPC,"KU_APPRAISE_TIME") < ku_GetTimeStamp() ) {
     iDiscount = (GetSkillRank(SKILL_APPRAISE,oPC) + Random(20) + 1) * 50 / 90;
     SetLocalInt(oPC,"KU_APPRAISE",iDiscount);
     SetLocalInt(oPC,"KU_APPRAISE_TIME",ku_GetTimeStamp(0,0,6));
  }
  else {
     iDiscount = GetLocalInt(oPC,"KU_APPRAISE");
     if(GetLocalInt(oPC,"KU_APPRAISE_TIME") < ku_GetTimeStamp(0,5))
        SetLocalInt(oPC,"KU_APPRAISE_TIME",ku_GetTimeStamp(0,5));
  }
*/
/*
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH1)) != iColor ) {
    iPrice++;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH2)) != iColor ) {
    iPrice++;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER1)) != iColor ) {
    iPrice++;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER2)) != iColor ) {
    iPrice++;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL1)) != iColor ) {
    iPrice = iPrice + 3;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
  iColor = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2);
  if(GetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL2)) != iColor ) {
    iPrice = iPrice + 3;
//    if( (iColor == 63) || (iColor == 62) )
//      iPrice = iPrice + 2;
  }
*/

//  iPrice = ((100 - iDiscount) * GetGoldPieceValue(oCloth) / 2000 + 500) * iPrice;
//  iPrice = 10 * iPrice;

  iPrice = ku_TaylorCalculatePrice(oCloth,oOldCloth);

  if(GetGold(oPC) < iPrice)
    AssignCommand(OBJECT_SELF,SpeakString("Nemas dost zlata. Takhle to nepujde."));
  else {
    TakeGoldFromCreature(iPrice,oPC);
//    AssignCommand(oChest,ActionTakeItem(oCloth,oStand));
    string sApp = GetEntireItemAppearance(oCloth);
    RestoreItemAppearance(oOldCloth,sApp);


    DestroyObject(oCloth);
    object oNCloth = CopyItem(oOldCloth,oPC,TRUE);
    DestroyObject(oOldCloth);

    DeleteLocalObject(oDyer,"CUSTOMER");
    DeleteLocalObject(oDyer,"ITEM");
    DeleteLocalObject(oDyer,"ITEM_BACKUP");
    AssignCommand(oPC,ActionEquipItem(oNCloth,GetLocalInt(oDyer,"DYE_INV_SLOT")));
    DeleteLocalInt(oDyer,"working");

    SetCustomToken(6001,"0");
    int i;
    for(i = 1; i <= 8 ; i++)
      DestroyObject(GetNearestObjectByTag("ku_dyer_light"+IntToString(i)));
    DeleteLocalInt(OBJECT_SELF,"DYER_MACHINE_ACTIVATED");
  }

}
