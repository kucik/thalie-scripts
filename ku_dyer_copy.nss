void main()
{
    int iVal, iPart;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    
    for (iPart = 0; iPart < 19; iPart++)
    {
        iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, iPart);
        SetLocalInt(OBJECT_SELF, "TEMPLATE" + IntToString(iPart), iVal);
    }
    SpeakString("Míry odìvu odebrány a zapsány jako vzor.");
}