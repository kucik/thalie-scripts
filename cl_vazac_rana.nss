void main()
{
    object oRightHandWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    itemproperty ip = ItemPropertyOnHitCastSpell(141,10);
    if (GetIsObjectValid(oRightHandWeapon)==FALSE)
    {
        int iBaseItem = GetBaseItemType(oRightHandWeapon);
        switch (iBaseItem)
        {
            case BASE_ITEM_LIGHTMACE:
            case BASE_ITEM_LIGHTHAMMER:
            case BASE_ITEM_CLUB:
            case BASE_ITEM_MORNINGSTAR:
            case BASE_ITEM_MAGICSTAFF:
            case BASE_ITEM_LIGHTFLAIL:
            case BASE_ITEM_WARHAMMER:
                AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oRightHandWeapon,99999.0);
            break;

        }
    }
    oRightHandWeapon = GetItemInSlot(INVENTORY_SLOT_BULLETS);
    if (GetIsObjectValid(oRightHandWeapon)==FALSE)
    {
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oRightHandWeapon,99999.0);
    }









}
