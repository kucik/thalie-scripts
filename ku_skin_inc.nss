object GetPCSkin(object oPC);

//void ReequipSkin(object oPC);

object CreatePCSkin(object oPC) {
  object oSkin = CreateItemOnObject("th_pcskin",oPC,1);

  AssignCommand(oPC, ActionUnequipItem(oSkin));
  DelayCommand(0.2,AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));

  SendMessageToPC(oPC, "Created skin "+GetName(oSkin));

  return oSkin;
}

object CheckPCSkin(object oPC) {
  return GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
}

object GetPCSkin(object oPC) {
  object oSkin = CheckPCSkin(oPC);

  if(GetIsObjectValid(oSkin)) {
    SendMessageToPC(oPC, "Checking for skin. Skin found: "+GetName(oSkin));
    if(GetTag(oSkin) == "th_pcskin")
      return oSkin;
    else {
      ActionUnequipItem(oSkin);
      return CreatePCSkin(oPC);
    }
  }


  oSkin = CreatePCSkin(oPC);
  return oSkin;
}

void ReequipSkin(object oPC) {
  object oSkin = GetPCSkin(oPC);

  AssignCommand(oPC, ActionUnequipItem(oSkin));

  DelayCommand(0.2,AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));
}
