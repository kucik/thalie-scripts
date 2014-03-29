int StartingConditional()
{

  object oPC = GetPCSpeaker();

  object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  if ( (GetIsObjectValid(oTool)) && (GetTag(oTool) == "cnrSkinningKnife") )
  {
      return TRUE;
  }

  oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
  if ( (GetIsObjectValid(oTool)) && (GetTag(oTool) == "cnrSkinningKnife") )
  {
    return TRUE;
  }

  return FALSE;
}
