/*
    Trigger se aktivuje, když na nìj vstoupí hráè nebo DM-possessed NPC.
    sy_id   = typ akce (1 = zobrazení pro všechny, 2 = zobrazení skrze NPC)
    sy_npc = doplò tag NPC, skrze kterou se má zobrazit text
    sy_str  = text zprávy
    sy_once = 0 = opakovanì, 1 = jen jednou pro každého hráèe/DM
*/

void main()
{
    object oPC = GetEnteringObject();

    // Reagujeme na:
    // - normální hráèe
    // - DM-possessed NPC (GetIsDM == TRUE)
    if (!(GetIsPC(oPC)))
        return;

    int iID   = GetLocalInt(OBJECT_SELF, "sy_id");
    int iOnce = GetLocalInt(OBJECT_SELF, "sy_once");
    string sTX = GetLocalString(OBJECT_SELF, "sy_str");

    // unikátní klíè pro hráèe/DM podle tagu triggeru
    string sKey = "sy_once_" + GetTag(OBJECT_SELF);

    // pokud je režim "jen jednou" a objekt už to vidìl ? konec
    if (iOnce == 1 && GetLocalInt(oPC, sKey) == 1)
        return;

    // pokud je režim "jen jednou", oznaèíme objekt jako "už vidìl"
    if (iOnce == 1)
        SetLocalInt(oPC, sKey, 1);

    switch (iID)
    {
        case 1: // soukromá zpráva hráèi/DM
        {
            SendMessageToPC(oPC, sTX);
            break;
        }

        case 2: // veøejná zpráva skrz NPC
        {
            string sNPC = GetLocalString(OBJECT_SELF, "sy_npc");
            object oNPC = GetNearestObjectByTag(sNPC, oPC, 10);
            if (oNPC != OBJECT_INVALID)
                AssignCommand(oNPC, SpeakString(sTX, TALKVOLUME_TALK));
            break;
        }
    }
}
