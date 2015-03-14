object GetPCSkin(object oPC);

//void ReequipSkin(object oPC);

object CreatePCSkin(object oPC) {
  object oSkin = CreateItemOnObject("th_pcskin",oPC,1);
  SetLocalObject(oPC, "th_pcskin", oSkin);

  AssignCommand(oPC, ActionUnequipItem(oSkin));
  DelayCommand(0.2,AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));

  SendMessageToPC(oPC, "Created skin "+GetName(oSkin));

  return oSkin;
}

object CheckPCSkin(object oPC) {
  object oSkin = GetLocalObject(oPC, "th_pcskin");
  object oEquiped =  GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
  if(GetIsObjectValid(oSkin) && oSkin != oEquiped) {
    DelayCommand(0.2,AssignCommand(oPC, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR)));
  }
  else {
    oSkin = oEquiped;
    if(GetIsObjectValid(oSkin))
      SetLocalObject(oPC, "th_pcskin", oSkin);
  }
  return oSkin;
}

object GetPCSkin(object oPC) {
  object oSkin = CheckPCSkin(oPC);

  if(GetIsObjectValid(oSkin)) {
//    SendMessageToPC(oPC, "Checking for skin. Skin found: "+GetName(oSkin));
    if(GetTag(oSkin) == "th_pcskin")
      return oSkin;
    else {
      ActionUnequipItem(oSkin);
      return CreatePCSkin(oPC);
    }
  }
  else {
    oSkin = GetItemPossessedBy(oPC, "th_pcskin");
    if(GetIsObjectValid(oSkin)) {
      AssignCommand(oPC, ActionUnequipItem(oSkin));
      return oSkin;
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

void __skinCelanup(object oPC) {
  object oSkin = GetPCSkin(oPC);
  object oItem = GetFirstItemInInventory(oPC);
  while (GetIsObjectValid(oItem)) {
    if(GetTag(oItem) == "th_pcskin" && oItem != oSkin) {
      DestroyObject(oItem, 0.2);
    }
    // Non Th skins
    if(GetTag(oItem) == "x3_it_pchide")
      DestroyObject(oItem, 0.2);
    oItem = GetNextItemInInventory(oPC);
  }

}

void SkinCleanup(object oPC) {
  // Equip correct skin
  GetPCSkin(oPC);


  DelayCommand(1.1,__skinCelanup(oPC));
}
