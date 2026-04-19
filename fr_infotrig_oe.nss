/*
    Trigger se aktivuje, kdyz na nej vstoupi hrac nebo DM-possessed NPC.
    sy_id    = typ akce (1 = zobrazeni pro vsechny, 2 = zobrazeni skrze NPC)
    sy_npc   = dopln tag NPC, skrze kterou se ma zobrazit text
    sy_str   = text zpravy
    sy_once  = 0 = opakovane, 1 = jen jednou pro kazdeho hrace/DM
    sy_first = 1 = text se zobrazi pouze prvnimu hraci nebo DM-possessed NPC
    sy_test  = 1 = DM avatar muze spustit sy_first (testovaci rezim)
*/

void main()
{
    object oPC = GetEnteringObject();

    // Pouze hraci a DM (avatar nebo possessed)
    if (!GetIsPC(oPC))
        return;

    // Testovaci rezim
    int iTest = GetLocalInt(OBJECT_SELF, "sy_test");

    // DM avatar ignorovat, pokud neni testovaci rezim
    // DM avatar: GetIsDM == TRUE && GetMaster == OBJECT_INVALID
    // DM possessed NPC: GetIsDM == TRUE && GetMaster != OBJECT_INVALID
    if (GetIsDM(oPC) && GetMaster(oPC) == OBJECT_INVALID && iTest == 0)
        return;

    int iID     = GetLocalInt(OBJECT_SELF, "sy_id");
    int iOnce   = GetLocalInt(OBJECT_SELF, "sy_once");
    int iFirst  = GetLocalInt(OBJECT_SELF, "sy_first");
    string sTX  = GetLocalString(OBJECT_SELF, "sy_str");

    // --- sy_first: zobrazit jen prvnimu hraci nebo DM possessed NPC ---
    if (iFirst == 1)
    {
        if (GetLocalInt(OBJECT_SELF, "sy_first_shown") == 1)
            return;

        // Oznacit, ze uz nekdo videl
        SetLocalInt(OBJECT_SELF, "sy_first_shown", 1);
    }

    // --- sy_once: jednou pro kazdeho hrace/DM pokud neni nastavena promenna
    // sy_first na 1 ---
    string sKey = "sy_once_" + GetTag(OBJECT_SELF);

    if (iOnce == 1 && GetLocalInt(oPC, sKey) == 1)
        return;

    if (iOnce == 1)
        SetLocalInt(oPC, sKey, 1);

    // --- Vlastni akce ---
    switch (iID)
    {
        case 1: // soukroma zprava hraci/DM
        {
            SendMessageToPC(oPC, sTX);
            break;
        }

        case 2: // verejna zprava skrz NPC
        {
            string sNPC = GetLocalString(OBJECT_SELF, "sy_npc");
            object oNPC = GetNearestObjectByTag(sNPC, oPC, 10);
            if (oNPC != OBJECT_INVALID)
                AssignCommand(oNPC, SpeakString(sTX, TALKVOLUME_TALK));
            break;
        }
    }
}
