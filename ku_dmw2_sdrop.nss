void main()
{
  object oPlayer = GetPCSpeaker();
  object oPC = GetLocalObject(oPlayer,"KU_DM_WAND_USED_TO");
  object oItem = GetFirstItemInInventory(oPC);
  while(GetIsObjectValid(oItem)) {
    SetDroppableFlag(oItem,TRUE);
    oItem = GetNextItemInInventory(oPC);
  }

  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARMS,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BELT,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_HEAD,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),TRUE);
  SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC),TRUE);

  SendMessageToPC(oPlayer,"Vsechny predmety na "+GetName(oPC)+" byly nastaveny jako neodlozitelne.");
}
