#include "nwnx_funcs"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    object oNewItem;
    int iPart;
    int iVal = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO);
    int iAC = StringToInt(Get2DAString("parts_chest", "ACBONUS", iVal));
    int iTemplateAC = GetLocalInt(OBJECT_SELF, "TEMPLATEAC");

    for (iPart = 0; iPart < 19; iPart++)
    {
        if (iPart == ITEM_APPR_ARMOR_MODEL_TORSO && iAC != iTemplateAC)
            continue;

        iVal = GetLocalInt(OBJECT_SELF, "TEMPLATE" + IntToString(iPart));
        SetItemAppearance(oItem, iPart, iVal);
    }
    // copy color
    for (iPart = 0; iPart <= 5; iPart++)
    {
        iVal = GetLocalInt(OBJECT_SELF, "TEMPLATE_COLOR" + IntToString(iPart));
        SetItemColor (oItem, iPart, iVal);
    }

    oNewItem = CopyItem(oItem, oPC, TRUE);
    AssignCommand(oPC, ActionEquipItem(oNewItem, INVENTORY_SLOT_CHEST));
    DestroyObject(oItem);
    SetLocalObject(OBJECT_SELF, "ITEM", oNewItem);
}
