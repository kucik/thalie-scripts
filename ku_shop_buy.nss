/* Script pro prodej itemu vybranych z truhly u obchodnika.
 *
 * release 13.01.2008 Kucik
 *
 * rev. 20.01.2008 pridan stolen flag
 * rev. 23.01.2008 kontrola vybavenych predmetu
 * rev. 26.01.2008 opravy
 * rev. 26.01.2008 pridany hole a lekarna
 * rev. 30.01.2008 Spraveny lekarny a pridano ukazovani cen ve jmene predmetu
 * rev. 27.12.2008 Oprava pretekani intu
 */

#include "ku_libtime"

void main()
{
   object oPC = GetPCSpeaker();
   object oItem = GetFirstItemInInventory(oPC);
   object nItem;
   object oCase = oPC;
   int iCost;
   int iTotalCost = 0;
   string  sSpeak = "";
   int iBaseItem;
   int i=0;
   int j;
   location lLoc = GetLocation(OBJECT_SELF);
   int iDiscount;
   int iMarkup;
   itemproperty ipProp;
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
   }
   while((GetIsObjectValid(oItem)) || ((i>0) && (i<14) )) {
     if(GetStringLeft(GetTag(oItem),8) == "ku_shop_") {

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

     iMarkup = GetLocalInt(OBJECT_SELF,"KU_SHOP_MARKUP") + 100;
     if(iMarkup<=100)
       iMarkup=200;
     iCost = FloatToInt((IntToFloat(iCost) * iMarkup * (100 - iDiscount)  / 10000) + 1);
         sSpeak = sSpeak + GetName(oItem) + " stoji " +  IntToString(iCost) + ",   ";
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
   else {
     if(GetGold(oPC) < iTotalCost)
        AssignCommand(OBJECT_SELF,SpeakString("Nemas dost zlata. Neco tu budes muset nechat."));
     else {
       TakeGoldFromCreature(iTotalCost,oPC);
       AssignCommand(OBJECT_SELF,SpeakString("Dekuji. Prijdte zas."));

       oItem = GetFirstItemInInventory(oPC);
       i=0;
       j=1;
       while((GetIsObjectValid(oItem)) || ((i>0) && (i<14) )) {
         if(GetStringLeft(GetTag(oItem),8) == "ku_shop_") {
//         if(GetLocalInt(oItem,"KU_SHOP")) {

           SetLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(j),oItem);
           j++;

           SetLocalInt(oItem,"KU_SHOP",FALSE);
         }
         oItem = GetNextItemInInventory(oPC);

         if(i>=14)
           oItem == OBJECT_INVALID;
         if( (!GetIsObjectValid(oItem) || (i>0) ) && (i<14)  ) {
           i++;
            oItem = GetItemInSlot(GetLocalInt(OBJECT_SELF,"ku_inv_slots_" + IntToString(i)),oPC);
         }
       }
       i=j;
       while(i>1) {
         i--;
         oItem = GetLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i));
         nItem = CopyObject(oItem,lLoc,oPC,GetLocalString(oItem,"KU_ORIGINAL_TAG"));
         SetItemStackSize(nItem,GetItemStackSize(oItem));
         if(GetStringLength(GetLocalString(oItem,"KU_SHOP_ORIGNAME"))>0)
           SetName(nItem,GetLocalString(oItem,"KU_SHOP_ORIGNAME"));
         else
           SetName(nItem,GetStringLeft(GetName(oItem),FindSubString(GetName(oItem)," cena")));
         DeleteLocalString(nItem,"KU_SHOP_ORIGNAME");

         j=0;
         iBaseItem = GetBaseItemType(nItem);
//         SendMessageToPC(GetFirstPC(),"bastype=" + IntToString(iBaseItem));
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
             (iBaseItem == BASE_ITEM_BLANK_POTION    ) ) {

//             SendMessageToPC(GetFirstPC(),"scroll");
             // Sebranim properties by se mohla zmenit cena, proto se ulozi
             SetLocalInt(nItem,"KU_SHOP_COST",GetGoldPieceValue(nItem));

            j = GetLocalInt(nItem,"KU_SHOP_IPCOUNT");
            while(j>0) {
                if(GetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_TYPE")==ITEM_PROPERTY_CAST_SPELL)
                  ipProp = ItemPropertyCastSpell(GetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_STYPE"),1);
                if(GetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_TYPE")==ITEM_PROPERTY_HEALERS_KIT) {
                  ipProp = ItemPropertyHealersKit(GetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_CTV"));
                }
                AddItemProperty(GetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_DUR"),ipProp,nItem);

                DeleteLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_TYPE");
                DeleteLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_STYPE");
                DeleteLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_DUR");
                DeleteLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_CTV");

                j--;
            }
            SetLocalInt(nItem,"KU_SHOP_IPCOUNT",0);

         }

         DestroyObject(oItem);
         SetLocalInt(nItem,"KU_SHOP",FALSE);
         SetStolenFlag(nItem,FALSE);
       }
     }
   }
}
