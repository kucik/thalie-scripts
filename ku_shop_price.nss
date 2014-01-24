/* Script rekne cenu itemu vybranych z truhly u obchodnika.
 *
 * release 13.01.2008 Kucik
 * rev. 23.01.2008 Kucik kontrola vybavenych predmetu
 * rev. 26.01.2008 Kucik opravy
 * rev. 26.01.2008 pridany hole a lekarna
 * rev. 30.01.2008 drobne upravy
 * rev. 27.12.2008 Oprava pretekani intu
 */

#include "ku_libtime"

void main()
{
   object oPC = GetPCSpeaker();
   object oItem = GetFirstItemInInventory(oPC);
   object oCase = oPC;
   int iCost;
   float fCost;
   int iTotalCost = 0;
   string  sSpeak = "";
   int iDiscount;
   int iBaseItem;
   int iMarkup;
   int i=0;
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_1",INVENTORY_SLOT_ARMS);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_2",INVENTORY_SLOT_ARROWS);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_3",INVENTORY_SLOT_BELT);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_4",INVENTORY_SLOT_BOLTS);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_5",INVENTORY_SLOT_BOOTS);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_6",INVENTORY_SLOT_BULLETS);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_7",INVENTORY_SLOT_CLOAK);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_8",INVENTORY_SLOT_HEAD);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_9",INVENTORY_SLOT_CHEST);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_10",INVENTORY_SLOT_LEFTHAND);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_11",INVENTORY_SLOT_LEFTRING);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_12",INVENTORY_SLOT_NECK);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_13",INVENTORY_SLOT_RIGHTHAND);
   SetLocalInt(OBJECT_SELF,"ku_inv_slots_14",INVENTORY_SLOT_RIGHTRING);

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

   iMarkup = GetLocalInt(OBJECT_SELF,"KU_SHOP_MARKUP") + 100;
   if(iMarkup<=100)
     iMarkup=200;

//   SendMessageToPC(GetFirstPC(),"Markup = "+IntToString(iMarkup));

   while((GetIsObjectValid(oItem)) || ((i>0) && (i<14) )) {
//     if(GetLocalInt(oItem,"KU_SHOP")) {
     if(GetStringLeft(GetTag(oItem),8) == "ku_shop_") {
//       SendMessageToPC(oPC,"Item stoji" + IntToString(GetGoldPieceValue(oItem)));

       iBaseItem = GetBaseItemType(oItem);
       if( (iBaseItem == BASE_ITEM_ENCHANTED_WAND  ) ||
           (iBaseItem == BASE_ITEM_MAGICSTAFF      ) ||
           (iBaseItem == BASE_ITEM_MAGICWAND       ) ||
           (iBaseItem == BASE_ITEM_HEALERSKIT      ) ||
           (iBaseItem == BASE_ITEM_ENCHANTED_SCROLL) ||
           (iBaseItem == BASE_ITEM_SPELLSCROLL     ) ||
           (iBaseItem == BASE_ITEM_SCROLL          ) ||
           (iBaseItem == BASE_ITEM_BLANK_SCROLL    ) ||
           (iBaseItem == BASE_ITEM_POTIONS         ) ||
           (iBaseItem == BASE_ITEM_ENCHANTED_POTION) ||
           (iBaseItem == BASE_ITEM_BLANK_POTION    ) )
         iCost = GetLocalInt(oItem,"KU_SHOP_PRICE");
       else
         iCost = GetGoldPieceValue(oItem);

       if( (iBaseItem == BASE_ITEM_ARROW           ) ||
           (iBaseItem == BASE_ITEM_BOLT            ) ||
           (iBaseItem == BASE_ITEM_BULLET          ) ||
           (iBaseItem == BASE_ITEM_DART            ) ||
           (iBaseItem == BASE_ITEM_SHURIKEN        ) ||
           (iBaseItem == BASE_ITEM_THROWINGAXE     ) )
         iCost = iCost / 10;

       fCost=IntToFloat(iCost);
//       SendMessageToPC(GetFirstPC(),"Cost = "+IntToString(iCost));
//       iCost = (iCost * iMarkup * (100 - iDiscount)  / 10000) + 1;
       iCost = FloatToInt((fCost * iMarkup * (100 - iDiscount)  / 10000) + 1);
//       SendMessageToPC(GetFirstPC(),"Cost = "+IntToString(iCost));
//       SendMessageToPC(GetFirstPC(),"Cost = "+FloatToString(fCost));

//       iCost = (GetGoldPieceValue(oItem) * GetLocalInt(OBJECT_SELF,"KU_SHOP_MARKUP") * (100 - iDiscount)  / 10000) + 1;
//       iCost = GetGoldPieceValue(oItem) * GetLocalInt(OBJECT_SELF,"KU_SHOP_MARKUP") / 100;
       sSpeak = sSpeak + GetLocalString(oItem,"KU_SHOP_ORIGNAME") + " stoji " +  IntToString(iCost) + ",   ";
       iTotalCost = iTotalCost + iCost;
     }
     oItem = GetNextItemInInventory(oPC);

     // Equiped sloty
     if(i>=14)
       oItem == OBJECT_INVALID;

     if( (!GetIsObjectValid(oItem) || (i>0) ) && (i<14)  ) {
       i++;
       oItem = GetItemInSlot(GetLocalInt(OBJECT_SELF,"ku_inv_slots_" + IntToString(i)),oPC);
     }
   }
   if(iTotalCost == 0)
     AssignCommand(OBJECT_SELF,SpeakString("Nic u sebe nemas."));
   else
     AssignCommand(OBJECT_SELF,SpeakString(sSpeak + " Dohromady to bude " + IntToString(iTotalCost) + " zlatych."));
}
