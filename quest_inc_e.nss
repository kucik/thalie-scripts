const int QUEST_NPC_LISTEN_PATTERN = 151;



void QUEST_InitQuestNPC(object oNPC)
{

    SetListening(oNPC,TRUE);
    SetListenPattern(OBJECT_SELF, "Chci **", QUEST_NPC_LISTEN_PATTERN);
}
