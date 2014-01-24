/* Script pro kontrolu, jestli se nekdo nesnazi odejit s nakupem
 *
 * release 12.01.2008 Kucik
 *
 * rev. 20.01.2008 pridano hlaseni DM
 * rev. 23.01.2008 zachytavani vsech slotu postavy, Message na nastenku.
 * rev. 26.01.2008 drobne upravy
 */
#include "ja_lib"
/*
 * melvik upava na novy zpusob nacitani soulstone 16.5.2009
 */
#include "bbs_include"
#include "ku_libtime"

void main()
{
   object oPC=GetExitingObject();
   object oItem = GetFirstItemInInventory(oPC);
   object oCase;
   int bThief = FALSE;
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

   while((GetIsObjectValid(oItem)) || ((i>0) && (i<14) )) {
     if(GetStringLeft(GetTag(oItem),8) == "ku_shop_") {
//     if(GetLocalInt(oItem,"KU_SHOP")) {
       bThief = TRUE;
       DestroyObject(oItem);
     }

     oItem = GetNextItemInInventory(oPC);

     if(i>=14)
       oItem == OBJECT_INVALID;
     if( (!GetIsObjectValid(oItem) || (i>0) ) && (i<14)  ) {
       i++;
       oItem = GetItemInSlot(GetLocalInt(OBJECT_SELF,"ku_inv_slots_" + IntToString(i)),oPC);
     }
   }
   if(bThief) {
     SendMessageToAllDMs(GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!");
     bbs_add_notice(GetObjectByTag("ku_dm_board"), GetPCPlayerName(oPC),"Kradeni", GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!", "");
     int nStolecnt= GetLocalInt(GetSoulStone(oPC),"KU_STOLECNT") + 1;
     SetLocalInt(GetSoulStone(oPC),"KU_STOLECNT",nStolecnt);
     if(nStolecnt>3)
        SetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ",ku_GetTimeStamp(0,0,0,30));
     //SendMessageToPC(oPC,GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!");
     //doplnit
   }
   if(GetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ") < ku_GetTimeStamp()) {
        SetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ",FALSE);
        SetLocalInt(GetSoulStone(oPC),"KU_STOLECNT",0);
   }

}
