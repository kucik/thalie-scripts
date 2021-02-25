void main()
{
    object oPC = GetLastUsedBy();
    string sPCName = GetPCPlayerName(oPC);
    if ((sPCName=="Nalkanar") || (sPCName=="BlackDiamond") || (sPCName=="Paulus") || (sPCName=="Sokar") ||(sPCName=="Bruciacullo"))
    {
        object oQuestLog = GetItemPossessedBy(oPC,"quest_log");
        if (GetIsObjectValid(oQuestLog)==FALSE)
        {
            CreateItemOnObject("quest_log",oPC);
        }
    }

}
