/*
Skript pro opravovac truhlu

*/
#include "sh_classes_const"

void main()
{
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        //Nahrazeni item property pouze dobrodruh za item property pouze rogue
        itemproperty ip = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(ip))
        {
            if (GetItemPropertyType(ip)==ITEM_PROPERTY_USE_LIMITATION_CLASS)
            {
                if (GetItemPropertySubType(ip)==CLASS_TYPE_OBCAN)
                {
                    RemoveItemProperty(oItem,ip);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLimitUseByClass(CLASS_TYPE_ROGUE),oItem);
                    break;
                }
            }
            ip = GetNextItemProperty(oItem);
        }
        oItem = GetNextItemInInventory();
    }
}
