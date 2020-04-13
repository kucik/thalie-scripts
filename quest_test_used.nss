void main()
{
    object oPC = GetLastUsedBy();
    string sPCName = GetPCPlayerName(oPC);
    if ((sPCName=="Nalkanar") || (sPCName=="BlackDiamond") || (sPCName=="Paulus"))
    {
        object oQuestLog = GetItemPossessedBy(oPC,"quest_log");
        if (GetIsObjectValid(oQuestLog)==FALSE)
        {
            CreateItemOnObject("quest_log",oPC);
        }
    }

}
