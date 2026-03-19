/*
    Trigger se aktivuje, kdyû na nÏj vstoupÌ hr·Ë nebo DM-possessed NPC.
    sy_id    = typ akce (1 = zobrazenÌ pro vöechny, 2 = zobrazenÌ skrze NPC)
    sy_npc   = doplÚ tag NPC, skrze kterou se m· zobrazit text
    sy_str   = text zpr·vy
    sy_once  = 0 = opakovanÏ, 1 = jen jednou pro kaûdÈho hr·Ëe/DM
    sy_first = 1 = text se zobrazÌ pouze prvnÌmu hr·Ëi, kter˝ vstoupÌ
*/

void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC))
        return;

    int iID     = GetLocalInt(OBJECT_SELF, "sy_id");
    int iOnce   = GetLocalInt(OBJECT_SELF, "sy_once");
    int iFirst  = GetLocalInt(OBJECT_SELF, "sy_first");
    string sTX  = GetLocalString(OBJECT_SELF, "sy_str");

    // --- NOV¡ LOGIKA: sy_first ---
    // KlÌË pro hr·Ëe ñ unik·tnÌ podle triggeru
    string sFirstKey = "sy_first_shown_" + GetTag(OBJECT_SELF);

    // Pokud je sy_first aktivnÌ a hr·Ë uû to vidÏl õ konec
    if (iFirst == 1 && GetLocalInt(oPC, sFirstKey) == 1)
        return;

    // Pokud je sy_first aktivnÌ a hr·Ë to jeötÏ nevidÏl õ oznaËÌme ho
    if (iFirst == 1)
    {
        SetLocalInt(oPC, sFirstKey, 1);
    }

    // --- PŸVODNÕ LOGIKA: sy_once (pro kaûdÈho hr·Ëe zvl·öù) ---
    string sOnceKey = "sy_once_" + GetTag(OBJECT_SELF);

    if (iOnce == 1 && GetLocalInt(oPC, sOnceKey) == 1)
        return;

    if (iOnce == 1)
        SetLocalInt(oPC, sOnceKey, 1);

    // --- VlastnÌ akce ---
    switch (iID)
    {
        case 1: // soukrom· zpr·va hr·Ëi/DM
        {
            SendMessageToPC(oPC, sTX);
            break;
        }

        case 2: // ve¯ejn· zpr·va skrz NPC
        {
            string sNPC = GetLocalString(OBJECT_SELF, "sy_npc");
            object oNPC = GetNearestObjectByTag(sNPC, oPC, 10);
            if (oNPC != OBJECT_INVALID)
                AssignCommand(oNPC, SpeakString(sTX, TALKVOLUME_TALK));
            break;
        }
    }
}
