#include "ku_libtime"

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;
    int iPart = GetLocalInt(OBJECT_SELF,"KU_PART");

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(nMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {

      if (oShouter == GetLocalObject(OBJECT_SELF, "CUSTOMER")) {
        string sSaid = GetMatchedSubstring(0);
        int iNum = StringToInt(sSaid);
        int nRestColors = 0;
        object oStand = GetLocalObject(OBJECT_SELF,"KU_STAND");
//        object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST,oStand);
        object oDyer = OBJECT_SELF;
        int iSlot = GetLocalInt(oDyer,"DYE_INV_SLOT");
        object oCloth = GetItemInSlot(iSlot,oStand);
/*
        if(iNum==61) {
          SpeakString("Takovou barvu tu nemam.");
          return;
        }

        if( (iNum==62) ||
            (iNum==63) ) {
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_CLOTH1) )
             nRestColors++;
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_CLOTH2) )
             nRestColors++;
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_LEATHER1) )
             nRestColors++;
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_LEATHER2) )
             nRestColors++;
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_METAL1) )
             nRestColors++;
           if( (GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2)==iNum) &&
               (iPart!=ITEM_APPR_ARMOR_COLOR_METAL2) )
             nRestColors++;

           if(nRestColors>0) {
             SpeakString("Takovy odpornosti delat nebudu. Tuhle barvu pouziju na saty nanejvys jednou.");
             return;
           }
        }
*/
        if(FindSubString(sSaid,IntToString(iNum))!=-1) {

          object oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,GetLocalInt(OBJECT_SELF,"KU_PART"),iNum,TRUE);
          AssignCommand(oStand,ActionEquipItem(oNCloth,iSlot));
          DestroyObject(oCloth);

          //cena
          int iDiscount;
          int iPrice = 0;
          object oPC = oShouter;
          object oDyer = OBJECT_SELF;
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
         oCloth = oNCloth;

 int iColor;
 // cena
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


//         SendMessageToPC(oPC,"cnt:"+IntToString(iPrice));
         //iPrice = ((100 - iDiscount) * GetGoldPieceValue(oCloth) / 2000 + 500) * iPrice;
         iPrice = 10 * iPrice;
         SetCustomToken(6001,IntToString(iPrice));
         SpeakString("Takze barva cislo "+IntToString(iNum)+". Zatim to bude za "+IntToString(iPrice)+" zlatych.");
//         SendMessageToPC(oPC,"price:"+IntToString(iPrice));

        }
//        else
//          SpeakString("*NIC*");
      }
    }
}
