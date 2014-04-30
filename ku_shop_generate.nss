/* Funkce se spousti s kazdym otevrenim truhly v obchode vygeneruje nahodne itemy a upravi ty stackovatelne.
 *
 * release 13.01.2008 Kucik
 *
 * rev. 20.01.2008 pridan stolen flag
 * rev. 26.01.2008 pradany hole, lekarny, zneskondneno pretekani truhly
 * rev. 30.01.2008 Spraveny lekarny a pridano ukazovani cen ve jmene predmetu
 * rev. 07.05.2008 Pridan import predmetu pro obchody ala dobrodruhuv kramek. Presun itemu zmenen na kopirovani.
 * rev. 27.05.2008 Dalsi druh nahodnejch predmetu
 * rev. 27.12.2008 Oprava pretekani intu
 */

#include "ku_shop_katlst"

void MoveShopSortiment(int i) {

 object oItem;
 int count;

 while(i > 1) {
   i--;
   oItem = GetLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i));
   count = GetLocalInt(OBJECT_SELF,"KU_STACKITEMS_S_" + IntToString(i));
//   SendMessageToPC(GetFirstPC(),"presun :" + GetName(oItem));

//   AssignCommand(OBJECT_SELF,ActionTakeItem(oItem,oTempChest));
   CopyItem(oItem,OBJECT_SELF,TRUE);
   DestroyObject(oItem,0.4);

   //AssignCommand(OBJECT_SELF,ActionGiveItem(oItem,OBJECT_SELF));

   DeleteLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i));
   DeleteLocalInt(OBJECT_SELF,"KU_STACKITEMS_S_" + IntToString(i));
 }
}

int AddRandomItems() {

 object oItem = OBJECT_INVALID;
 int SortimentSize = 0;
 int iAdded = 0;

 // Import nahodnych predmetu pro obchody ala dobrodruh
 int iShopImport = GetLocalInt(OBJECT_SELF,"ku_shop_import");
 if(iShopImport) {
   iShopImport = iShopImport * 2/3 + Random(iShopImport/3) + 1;
   object oNearShop = GetNearestObjectByTag("ku_shop_warehouse");

//   SendMessageToPC(GetFirstPC(),"Coppying "+IntToString(iShopImport)+" items. ");
   /* Sum number of items in shop */
   oItem = GetFirstItemInInventory(oNearShop);
   while(GetIsObjectValid(oItem)) {
     SortimentSize++;
     oItem = GetNextItemInInventory(oNearShop);
   }

  
   // Copy items 
   oItem = GetFirstItemInInventory(oNearShop);
   while(GetIsObjectValid(oItem)) {
     if(Random(SortimentSize) < iShopImport) {
       CopyItem(oItem,OBJECT_SELF,TRUE);
       iAdded++;
     }
     oItem = GetNextItemInInventory(oNearShop);
   } 

 }
 
  return iAdded;
}

void main()
{
 if (GetLocalInt(OBJECT_SELF,"KU_SHOP_GENERATED")) // pokud je uz obsah pripravenej
 {

   return;
 }


 int i = 1;
 int j;
 object oItem = OBJECT_INVALID;
/*
 // Import nahodnych predmetu pro obchody ala dobrodruh
 int iShopImport = GetLocalInt(OBJECT_SELF,"ku_shop_import");
 if(iShopImport) {
   iShopImport = iShopImport * 2/3 + Random(iShopImport/3) + 1;
   object oNearShop = GetNearestObjectByTag("ku_shop_warehouse");

//   SendMessageToPC(GetFirstPC(),"Coppying "+IntToString(iShopImport)+" items. ");
   while(iShopImport > 0) {
     i = Random (100)+1;
     while(i > 0) {
       if(GetIsObjectValid(oItem))
         oItem = GetNextItemInInventory(oNearShop);
       else {
         oItem = GetFirstItemInInventory(oNearShop);
//         SendMessagToPC(GetFirstPC(),"over");
       }
       i--;
     }

     CopyItem(oItem,OBJECT_SELF,TRUE);
//     SendMessageToPC(GetFirstPC(),"Coppying item "+GetName(oItem));
     DestroyObject(oItem);
     iShopImport--;
   }

 }
*/
 AddRandomItems();

 
 if(GetObjectType(OBJECT_SELF)==OBJECT_TYPE_STORE) {
   SetLocalInt(OBJECT_SELF,"KU_SHOP_GENERATED",TRUE);
   /* Random shop reset to generate new items once more */
   DelayCommand(IntToFloat(Random(11*60*60)), DeleteLocalInt(OBJECT_SELF, "KU_SHOP_GENERATED"));
   return;
 }

// object oItem;
 object nItem;
 int iBaseItem;
 string sItemTag;
 object oTempChest = GetObjectByTag("ku_sh_tempchest" + IntToString(Random(12)));
// object oTempChest = GetObjectByTag("ku_sh_temp");
 location lLoc = GetLocation(oTempChest);
 i = 1;
// int j;
 int iCost;
 float fCost;
 int count;
 object oShopman = OBJECT_SELF;
 int iMarkup = 0;
 int bNotStack;
 while((iMarkup<=80) && (GetIsObjectValid(oShopman)) ) {
   oShopman = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC,OBJECT_SELF,i);
   i++;
   iMarkup = GetLocalInt(oShopman,"KU_SHOP_MARKUP");
   if(iMarkup > 0)
    iMarkup = iMarkup + 100;
 }
 if(iMarkup<=100)
   iMarkup=200;

 itemproperty ipProp;

// SendMessageToPC(GetFirstPC(),"Markup = "+IntToString(iMarkup));

 int iProb;

 i=1;
 oItem = GetFirstItemInInventory();
 while(GetIsObjectValid(oItem)) {
//     iBaseItem = GetBaseItemType(oItem);
     sItemTag = GetTag(oItem);
//     SendMessageToPC(GetFirstPC(),"Item " + GetStringLeft(sItemTag,12) + " - " + IntToString(iBaseItem));
     if( ( GetStringLeft(sItemTag,8) != "ku_shop_") ){
       if(GetItemStackSize(oItem)>1)
           bNotStack = TRUE;
       else
           bNotStack = FALSE;

       //Begin nahodne predmety pro obchody nove
       iProb = GetLocalInt(oItem,"ku_shop_probab");
       if( (iProb) && (iProb <= Random(100)) ) {
//         DestroyObject(oItem);
         continue;
       }
       //end nove nahodne predmety

       nItem = CopyObject(oItem,lLoc,oTempChest,"ku_shop_" + IntToString(i) + "_" + IntToString(j));

//       SendMessageToPC(GetFirstPC(),GetName(oItem) + " stack: " + IntToString(GetItemStackSize(oItem)));
       SetItemStackSize(nItem,GetItemStackSize(oItem));
       SetLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i),nItem);
       SetLocalInt(OBJECT_SELF,"KU_STACKITEMS_S_" + IntToString(i),GetItemStackSize(nItem));
       i++;
       SetLocalString(nItem,"KU_ORIGINAL_TAG",sItemTag);
//       SetItemStackSize(nItem,count);
       SetLocalInt(nItem,"KU_SHOP",TRUE);
       SetStolenFlag(nItem,TRUE);
       SetIdentified(nItem,TRUE);

       // cena
       iCost = GetGoldPieceValue(nItem);
       if( (iBaseItem == BASE_ITEM_ARROW           ) ||
           (iBaseItem == BASE_ITEM_BOLT            ) ||
           (iBaseItem == BASE_ITEM_BULLET          ) ||
           (iBaseItem == BASE_ITEM_DART            ) ||
           (iBaseItem == BASE_ITEM_SHURIKEN        ) ||
           (iBaseItem == BASE_ITEM_THROWINGAXE     ) ) {
         bNotStack = FALSE;
         iCost = iCost / 10 * GetItemStackSize(nItem);
       }

//       SendMessageToPC(GetFirstPC(),GetName(oItem)+" - puvodni cena je "+IntToString(iCost));
       iCost = FloatToInt(((IntToFloat(iCost) * iMarkup / 100) + 1) / GetItemStackSize(nItem));
       SetLocalString(nItem,"KU_SHOP_ORIGNAME",GetName(oItem));
       SetName(nItem,GetName(oItem) + " cena: " + IntToString(iCost));

       // Scrolls
       j=0;
       iBaseItem = GetBaseItemType(nItem);
//   SendMessageToPC(GetFirstPC(),"bastype=" + IntToString(iBaseItem));
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

     // Sebranim properties by se mohla zmenit cena, proto se ulozi
         SetLocalInt(nItem,"KU_SHOP_PRICE",GetGoldPieceValue(nItem));

         ipProp = GetFirstItemProperty(nItem);
         while(GetIsItemPropertyValid(ipProp)) {
           if( (GetItemPropertyType(ipProp) == ITEM_PROPERTY_CAST_SPELL) || (GetItemPropertyType(ipProp) == ITEM_PROPERTY_HEALERS_KIT) ){
             j++;
             SetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_TYPE",GetItemPropertyType(ipProp));
             SetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_STYPE",GetItemPropertySubType(ipProp));
             SetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_DUR",GetItemPropertyDurationType(ipProp));
             SetLocalInt(nItem,"KU_SHOP_IP_" + IntToString(j) + "_CTV",GetItemPropertyCostTableValue(ipProp));

             SetLocalInt(nItem,"KU_SHOP_IPCOUNT",j);
             RemoveItemProperty(nItem,ipProp);
           }
           ipProp = GetNextItemProperty(nItem);
         }
         //if(GetItemStackSize(oItem)>1) {
         //  bNotStack = TRUE;
         //SetItemStackSize(nItem,1);
         //}
       }
     }
//     SetLocalInt(oItem,"KU_SHOP",TRUE);
     if(bNotStack) {
//       SendMessageToPC(GetFirstPC(),"Stack1 = "+IntToString(GetItemStackSize(oItem)));
       SetItemStackSize(oItem,GetItemStackSize(oItem)-1);
//       SendMessageToPC(GetFirstPC(),"Stack2 = "+IntToString(GetItemStackSize(oItem)));
       SetItemStackSize(nItem,1);
     }
     else
       oItem = GetNextItemInInventory();
 }

 oItem = GetFirstItemInInventory();
 while(GetIsObjectValid(oItem)) {
   sItemTag = GetTag(oItem);
//   if( ( GetStringLeft(sItemTag,8) != "ku_shop_") ){
     DestroyObject(oItem);
//   }
   oItem = GetNextItemInInventory();
 }



 DelayCommand(0.3,MoveShopSortiment(i));

 /*
 while(i > 1) {
   i--;
   oItem = GetLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i));
   count = GetLocalInt(OBJECT_SELF,"KU_STACKITEMS_S_" + IntToString(i));
//   SendMessageToPC(GetFirstPC(),"presun :" + GetName(oItem));

//   AssignCommand(OBJECT_SELF,ActionTakeItem(oItem,oTempChest));
   DelayCommand(0.3,CopyItem(oItem,OBJECT_SELF,TRUE));
   DestroyObject(oItem,0.4);

   //AssignCommand(OBJECT_SELF,ActionGiveItem(oItem,OBJECT_SELF));

   DeleteLocalObject(OBJECT_SELF,"KU_STACKITEMS_" + IntToString(i));
   DeleteLocalInt(OBJECT_SELF,"KU_STACKITEMS_S_" + IntToString(i));
 }
 */

 SetLocalInt(OBJECT_SELF,"KU_SHOP_GENERATED",TRUE);
}

