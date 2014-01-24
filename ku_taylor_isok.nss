int StartingConditional()
{
  object oPC = GetPCSpeaker();
  object oDyer = OBJECT_SELF;

  if( (GetLocalObject(oDyer,"CUSTOMER") == oPC) &&
      (GetLocalInt(oDyer,"DYE_INV_SLOT") == INVENTORY_SLOT_CHEST)) {
    return TRUE;
  }

  return FALSE;
}
