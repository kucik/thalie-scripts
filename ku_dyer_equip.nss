#include "ku_libtime"
#include "nwnx_funcs"

/*
 * rev. 27.06.2008 Kucik Nahrazeni move funkci za copy
 */

void main()
{
  object oDyer = OBJECT_SELF;
  object oStand = GetLocalObject(oDyer,"KU_STAND");
  object oChest = GetLocalObject(oDyer,"KU_CHEST");
  object oPC = GetPCSpeaker();
  int iDiscount;


//  SetMovementRate(oPC,MOVEMENT_RATE_IMMOBILE);

  return;

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


  if(GetGender(GetPCSpeaker())==GENDER_FEMALE)
    oStand = GetNearestObjectByTag("ku_dyer_stand_f");
  else
    oStand = GetNearestObjectByTag("ku_dyer_stand_m");

  SetLocalObject(oDyer,"KU_STAND",oStand);

  SetListenPattern(OBJECT_SELF, "**", 777); //listen to all text
  SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening

  if(!GetIsObjectValid(oStand)) {
    SpeakString("Neni figurina -kontaktujte DM");
    return;
  }
  if(!GetIsObjectValid(oChest)) {
    SpeakString("Neni truhla -kontaktujte DM");
    return;
  }
  object oCloth;

  /* Vyprazdneni stojanu - pro sichr */
  oCloth=GetFirstItemInInventory(oStand);
  while(GetIsObjectValid(oCloth)) {
    DestroyObject(oCloth,0.2);
    oCloth=GetNextItemInInventory(oStand);
  }


  oCloth=GetFirstItemInInventory(oChest);
  int iBaseItem = -1;
  int iSlot = -1;
  while(GetIsObjectValid(oCloth)) {
    //oCloth = GetNextItemInInventory(oChest);
    iBaseItem = GetBaseItemType(oCloth);
    switch(iBaseItem) {
      case BASE_ITEM_ARMOR:
        iSlot = INVENTORY_SLOT_CHEST;
        break;
      case BASE_ITEM_CLOAK:
        iSlot = INVENTORY_SLOT_CLOAK;
        break;
      case BASE_ITEM_HELMET:
        iSlot = INVENTORY_SLOT_HEAD;
        break;
      default:
        iSlot = -1;
        break;
    }
//    if(GetBaseItemType(oCloth)==BASE_ITEM_ARMOR)
//      break;
    if(iSlot > -1)
      break;
    oCloth=GetNextItemInInventory(oChest);
  }

  if(!GetIsObjectValid(oCloth)) {
    if(!GetLocalInt(OBJECT_SELF,"dye_shut_up"))
      SpeakString("V bedne neni, co by se dalo obarvit.");
    return;
  }

  SetLocked(oChest,TRUE);
  SetLockKeyRequired(oChest,TRUE);
  SetLocalInt(oDyer,"DYE_INV_SLOT",iSlot);

//  AssignCommand(GetModule(),ActionTakeItem(oItem,oTempChest));
//  AssignCommand(oChest,ActionGiveItem(oCloth,oStand));

  object oOldCloth = oCloth;
  oCloth = CopyItem(oOldCloth,oStand,TRUE);
  DestroyObject(oOldCloth);

//  ActionTakeItem(oCloth,oChest);
//  ActionGiveItem(oCloth,oStand);
  DelayCommand(0.2,AssignCommand(oStand,ActionEquipItem(oCloth,iSlot)));

  SetLocalObject(oDyer,"CUSTOMER",oPC);

  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH1),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1));
  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_CLOTH2),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2));
  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER1),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1));
  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_LEATHER2),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2));
  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL1),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1));
  SetLocalInt(oDyer,"DYE"+IntToString(ITEM_APPR_ARMOR_COLOR_METAL2),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2));

//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1)));
//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2)));
//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1)));
//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2)));
//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1)));
//  SendMessageToPC(oPC,IntToString(GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2)));

//  SendMessageToPC(oPC,IntToString(GetGoldPieceValue(oCloth)));
//  SetLocalInt(oDyer,"CLOTH_COST",GetGoldPieceValue(oCloth));
  SetCustomToken(6001,"0");
}
