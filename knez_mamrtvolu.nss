int StartingConditional()
{

    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    int iResult = 0;

    while(GetIsObjectValid(oItem)){
     if(GetResRef(oItem) == "mrtvola"){
      SetLocalObject(oPC, "mrtvola", oItem);
      iResult = 1;
      break;
     }
     oItem = GetNextItemInInventory(oPC);
    }

    return iResult;
}
