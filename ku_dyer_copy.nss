void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int iPart;
    int iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO);
    int iAC = StringToInt(Get2DAString("parts_chest", "ACBONUS", iVal));

    for (iPart = 0; iPart < 19; iPart++)
    {
        iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iPart);
        SetLocalInt(OBJECT_SELF, "TEMPLATE" + IntToString(iPart), iVal);
    }
    // copy color
    for (iPart = 0; iPart <= 5; iPart++)
    {
        iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, iPart);
        SetLocalInt(OBJECT_SELF, "TEMPLATE_COLOR" + IntToString(iPart), iVal);
    }
    SetLocalInt(OBJECT_SELF, "TEMPLATEAC", iAC);
    SpeakString("Míry odìvu odebrány.");
}
