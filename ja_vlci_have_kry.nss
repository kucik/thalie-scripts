int StartingConditional()
{
    string key = GetLocalString(OBJECT_SELF, "JA_VLCI_KRYSTAL");
    object oPC = GetPCSpeaker();

    return GetIsObjectValid(GetItemPossessedBy(oPC, key));
}
