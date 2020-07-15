void main()
{
    object oRightHandWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oRightHandWeapon)==FALSE)
    {
        oRightHandWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS);
    }
    if (GetIsObjectValid(oRightHandWeapon)==FALSE)
    {
        return;
    }
    itemproperty ip = ItemPropertyOnHitCastSpell(141,10);
    AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oRightHandWeapon,99999.0);






}
