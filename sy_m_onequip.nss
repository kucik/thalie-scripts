//script sa aktivuje ak PC equipne veci z batohu na seba
//tento script patri do modules->OnPlayerEquip
/*
 *
 * rev. Kucik 05.01.2008 pridat pozadavek na silu pri equip, zbrane
 * rev. Kucik 05.01.2008 Pridana dynamicka munice
 */

/*
 * Inventory slots constants:
 * INVENTORY_SLOT_HEAD = 0
 * INVENTORY_SLOT_CHEST = 1
 * INVENTORY_SLOT_BOOTS = 2
 * INVENTORY_SLOT_ARMS = 3
 * INVENTORY_SLOT_RIGHTHAND = 4
 * INVENTORY_SLOT_LEFTHAND = 5
 * INVENTORY_SLOT_CLOAK = 6
 * INVENTORY_SLOT_LEFTRING = 7
 * INVENTORY_SLOT_RIGHTRING = 8
 * INVENTORY_SLOT_NECK = 9
 * INVENTORY_SLOT_BELT = 10
 * INVENTORY_SLOT_ARROWS = 11
 * INVENTORY_SLOT_BULLETS = 12
 * INVENTORY_SLOT_BOLTS = 13
 * INVENTORY_SLOT_CWEAPON_L = 14
 * INVENTORY_SLOT_CWEAPON_R = 15
 * INVENTORY_SLOT_CWEAPON_B = 16
 * INVENTORY_SLOT_CARMOUR = 17
 */

#include "x2_inc_switches"
#include "sy_main_lib"
#include "ku_libbase"



void main()
{
    object oPC   = GetPCItemLastEquippedBy();
    object oItem = GetPCItemLastEquipped();


    int allowed = ku_CheckItemRestrictions(oPC, oItem);

// Zakomentovat tuhle radku pro zapnuti omezeni zbrani
//    allowed = TRUE;

    if(allowed == FALSE) {
      DelayCommand(0.3,AssignCommand(oPC,ActionUnequipItem(oItem)));
      SendMessageToPC(oPC,"Pro toto vybaveni nemas dost sily!");
      return;
    }
    if(allowed == -1) {
      DelayCommand(0.3,AssignCommand(oPC,ActionUnequipItem(oItem)));
      SendMessageToPC(oPC,"Pro nasazeni teto prilby potrebujes odbornost strednich zbroji!");
      return;
    }
    //ak je to zbran z lavej ruky oznacim si ju
    //je to koli efektom pre dualwield zbrani
    if (GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC)==oItem)
        sy_on_equip(oPC, oItem, 1);
    else
    {
        sy_on_equip(oPC, oItem, 0);
    }

    // Pokud je to behem boje je moznost, ze se jedna o sipy sipky, nebo neco podobneho
//    if(GetIsInCombat(oPC)) {
    if(FALSE) {
      object oSoul=GetSoulStone(oPC);
      //Sipy - zkontroluj, zda se nemely brat z toulce
      switch(GetBaseItemType(oItem)) {
         //Sipy - zkontroluj, zda se nemely brat z toulce
         case BASE_ITEM_ARROW: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_20");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_20"),20,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_20"),20,1);
           }
           break;
         }
         //Sipky do kuse
         case BASE_ITEM_BOLT: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_25");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_25"),25,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_25"),25,1);
           }
           break;
         }
         //Kameny do praku
         case BASE_ITEM_BULLET: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_27");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_27"),27,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_27"),27,1);
           }
           break;
         }
         //Sipky
         case BASE_ITEM_DART: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_31");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_31"),31,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_31"),31,1);
           }
           break;
         }
         case BASE_ITEM_SHURIKEN: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_59");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_59"),59,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_59"),59,1);
           }
           break;
         }
         case BASE_ITEM_THROWINGAXE: {
           object oSoul=GetSoulStone(oPC);
           string sArrows = GetLocalString(oSoul,"ku_ammo_63");
           if(sArrows != "") {
             if(GetTag(oItem)!=sArrows)
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_63"),63,1);
             else
               ku_GetMunitionFromPack(oPC,GetLocalString(oSoul,"ku_ammo_pack_63"),63,1);
           }
           break;
         }
      }
    }

}


