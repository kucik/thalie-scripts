#include "quest_inc_e"
#include "quest_inc"
void main()
{
    object oPC = GetLastSpeaker();
    int nMatch = GetListenPatternNumber();
    if(nMatch == -1)
    {
        SpeakString("Ne!");
    }
    else if(nMatch == QUEST_NPC_LISTEN_PATTERN)
    {
        //GetMatchedSubstring(0) - Vrati text "Chci "
        //GetMatchedSubstring(1) - vrati zbytek, tedy zadane cislo
        string sQuestNumber = GetStringUpperCase(GetMatchedSubstring(1));
        if (QUEST_DEBUG) SendMessageToPC(oPC,"Text0:"+GetMatchedSubstring(0));
        if (QUEST_DEBUG) SendMessageToPC(oPC,"Text1:"+GetMatchedSubstring(1));
        int iQuestNumber = StringToInt(sQuestNumber);
        if (iQuestNumber == 0) return;  //Konverze skoncila chybou nebo je zadany quest 0 - konec
        object oQuestBoard = GetObjectByTag(GetLocalString(OBJECT_SELF,"QUESTBOARD"));
        QUEST_ActivateQuest(oPC,oQuestBoard,iQuestNumber);
    }
}
