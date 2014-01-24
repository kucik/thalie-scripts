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
#include "ku_hire_inc"

void main()
{
   object oPC = GetEnteringObject();
   if(!GetIsObjectValid(oPC))
     oPC=GetExitingObject();
   if(!GetIsObjectValid(oPC))
     oPC=OBJECT_SELF;
   object oItem = GetFirstItemInInventory(oPC);
   object oCase;
   int bThief = FALSE;
   int i=-1;
/*   SetLocalInt(OBJECT_SELF,"ku_inv_slots_1",INVENTORY_SLOT_ARMS);
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
*/
   while((GetIsObjectValid(oItem)) || ((i>-1) && (i<13) )) {
//     SetLocalInt(oItem,"ku_stolen_flag",GetStolenFlag(oItem));
      DeleteLocalInt(oItem,"ku_stolen_flag");

     if(GetStringLeft(GetTag(oItem),8) == "ku_shop_") {
//     if(GetLocalInt(oItem,"KU_SHOP")) {
       bThief = TRUE;
       DestroyObject(oItem);
     }
     else if(ku_HireGetIsKeyExpired(oItem)) {
       DestroyObject(oItem);
     }



     oItem = GetNextItemInInventory(oPC);

     if(i>=13) {
       oItem == OBJECT_INVALID;
       break;
     }
     if( (!GetIsObjectValid(oItem) || (i>-1) ) && (i<13)  ) {
       i++;
//       oItem = GetItemInSlot(GetLocalInt(OBJECT_SELF,"ku_inv_slots_" + IntToString(i)),oPC);
       oItem = GetItemInSlot(i,oPC);
//       SendMessageToPC(oPC,"Slot "+IntToString(i)+" is "+IntToString(GetLocalInt(OBJECT_SELF,"ku_inv_slots_" + IntToString(i))) );
     }
   }
   if(bThief) {
     SendMessageToAllDMs(GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!");
     bbs_add_notice(GetObjectByTag("ku_dm_board"), GetPCPlayerName(oPC),"Kradeni", GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!", "");
     int nStolecnt= GetLocalInt(GetSoulStone(oPC),"KU_STOLECNT") + 1;
     SetLocalInt(GetSoulStone(oPC),"KU_STOLECNT",nStolecnt);
     if(nStolecnt>5)
        SetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ",ku_GetTimeStamp(0,0,0,15));

     ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6()),oPC);
     ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_BEAM_ODD),oPC);
     FloatingTextStringOnCreature("Odnesl sis neco, cos nemel",oPC);
     //SendMessageToPC(oPC,GetName(oPC) + " se snazi krast v " + GetName(GetArea(oPC)) + "!!!");
     //doplnit
   }
   if(GetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ") < ku_GetTimeStamp()) {
        SetLocalInt(GetSoulStone(oPC),"KU_ZLODEJ",FALSE);
        SetLocalInt(GetSoulStone(oPC),"KU_STOLECNT",0);
   }
   else if(ku_HireGetIsKeyExpired(oItem)) {
       DestroyObject(oItem);

     }
}
