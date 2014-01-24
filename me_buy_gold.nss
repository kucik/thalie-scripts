void main()
{

    //object oTable = GetNearestObjectByTag("");

    string sBuing = GetLocalString(OBJECT_SELF, "THINGS_TO_BUY");
    if (sBuing == ""){
        return;   // kdyz nema nastaveny vykup
    }

    int iPriceSum = 0;
    int iPrice = 0;
    int iStack = 0;
    object oPC = GetPCSpeaker();
    object oItem;

    oItem = GetFirstItemInInventory(oPC);

    while (oItem != OBJECT_INVALID)
    {
        iPrice = GetLocalInt(oItem, sBuing);
        if (iPrice != 0)
        {
            iStack =  GetNumStackedItems(oItem);
            iPriceSum += (iPrice * iStack);
            DestroyObject(oItem);
        }

        oItem = GetNextItemInInventory(oPC);
    }
    if (iPriceSum == 0){
        SpeakString("Hmmm, nevidim nic co by me zajimalo, same stare veci. Mas to snad v batohu?");
    }else{
        SpeakString("Tu mas penize...");
        GiveGoldToCreature(oPC, iPriceSum);
    }
    return;
}
