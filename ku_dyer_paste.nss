#include "nwnx_funcs"

void main()
{
    int iVal, iPart;
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    
    for (iPart = 0; iPart < 19; iPart++)
    {
        iVal = GetLocalInt(OBJECT_SELF, "TEMPLATE" + IntToString(iPart));
        SetItemAppearance(oItem, iPart, iVal);
    }
}