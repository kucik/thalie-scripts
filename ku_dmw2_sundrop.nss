void main()
{
  object oPlayer = GetPCSpeaker();
  object oPC = GetLocalObject(oPlayer,"KU_DM_WAND_USED_TO");
  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem)) {
    SetDroppableFlag(oItem,FALSE);
    oItem = GetNextItemInInventory(oPC);
  }

  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BELT,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),FALSE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC),FALSE);

  SendMessageToPC(oPlayer,"Vsechny predmety na "+GetName(oPC)+" byly nastaveny jako neodlozitelne.");
}
