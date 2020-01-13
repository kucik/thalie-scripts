//Resref itemu: it_portal_gem
//Resref portalu:teleport_portal
//Identifikace kotvy: Tag kotvy zacina towngate_

void main()
{
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        string sResRef = GetResRef(oItem);
        if (sResRef == "it_portal_gem")
        {
            string sTarget = GetLocalString(oItem,"PORTAL_TARGET");
            if (sTarget=="")
            {
                SetLocalString(oItem,"PORTAL_TARGET",GetTag(OBJECT_SELF));
                SetLocalString(oItem,"PORTAL_TARGET_AREA",GetName(GetArea(OBJECT_SELF)));
                SetName(oItem,GetName(oItem)+ " - "+GetName(GetArea(OBJECT_SELF)));
            }
        }
        oItem = GetNextItemInInventory();
    }

}
