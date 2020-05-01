
const int QUEST_DEBUG = 1;
#include "quest_sql"
//konstanty
const int QUEST_TYPE_ENTER_TRIGGER = 1;                                         //TargetTag
const int QUEST_TYPE_ENTER_AREA = 2;                                            //TargetAreaTag
const int QUEST_TYPE_KILL_BY_AREA = 3;                                          //TargetAreaTag,TargetCount
const int QUEST_TYPE_KILL_BY_MONSTER = 4;                                       //TargetAreaTag,TargetCount,TargetTag

//Definice
void QUEST_InitQuest();
//Vrati objekt pro cache questu
object QUEST_GetQuestTaskObject();
void QUEST_QuestBoardExamine(object oPC,object oQuestBoard);
void QUEST_QuestLogExamine(object oPC,object oQuestLog);
void QUEST_LoadQuestsForLog(object oPC,object oQuestLog);

//
void QUEST_InitQuest()
{
    object oSYS = QUEST_GetQuestTaskObject();
    //QUEST_CreateCache(oSYS);
}

int QUEST_GetSuperId(int iQuestId,int iTaskId)
{
    return (iQuestId*100)+iTaskId;
}


object QUEST_GetQuestTaskObject()
{
    return GetObjectByTag("_quest_cache");
}


void QUEST_QuestBoardExamine(object oPC,object oQuestBoard)
{
    if (GetLocalInt(oQuestBoard,"QUESTBOARD")!=1)
    {
        return;
    }
    object oQuestLog = GetItemPossessedBy(oPC,"quest_log");
    if (GetIsObjectValid(oQuestLog)==FALSE)
    {
        if (QUEST_DEBUG) SendMessageToPC(oPC,"Nemas knihu ukolu.");
        return;
    }
    else
    {
        if (QUEST_DEBUG) SendMessageToPC(oPC,"Kniha ukolu je na miste.");
    }
    QUEST_LoadQuestsForBoard(oPC,oQuestBoard);
}

void QUEST_ActivateQuest(object oPC,object oQuestBoard, int iQuestNumber)
{
    //zkontroluju zda QUEST muzu vzit jinak return(vypisu info)
    if (QUEST_GetIsQuestValid(oPC, oQuestBoard, iQuestNumber)==FALSE)
    {
        SendMessageToPC(oPC,"Nevalidni quest");
        return;
    }
    //Najdu volny quest - 1-3 (vypisu pokud jsou obsazene)
    int iQuestOrder1 = GetLocalInt(oPC,"QUEST_ORDER_1");
    if (iQuestOrder1 > 0) //Quest obsazen
    {
        int iQuestOrder2 = GetLocalInt(oPC,"QUEST_ORDER_2");
        if (iQuestOrder2 > 0) //Quest obsazen
        {
            int iQuestOrder3 = GetLocalInt(oPC,"QUEST_ORDER_3");
            if (iQuestOrder3 > 0) //Quest obsazen
            {
                SendMessageToPC(oPC,"Dnes jiz nemuzes brat dalsi questy.");
                return;
            }
            else
            {
                SetLocalInt(oPC,"QUEST_ORDER_3",iQuestNumber);
                QUEST_CreateTaskList(oPC,iQuestNumber,3);
                SendMessageToPC(oPC,"3. Quest nastaven na "+IntToString(iQuestNumber));
                return;
            }
        }
        else
        {
            SetLocalInt(oPC,"QUEST_ORDER_2",iQuestNumber);
            QUEST_CreateTaskList(oPC,iQuestNumber,2);
            SendMessageToPC(oPC,"2. Quest nastaven na "+IntToString(iQuestNumber));
            return;
        }
    }
    else
    {
        SetLocalInt(oPC,"QUEST_ORDER_1",iQuestNumber);
        QUEST_CreateTaskList(oPC,iQuestNumber,1);
        SendMessageToPC(oPC,"1. Quest nastaven na "+IntToString(iQuestNumber));
        return;
    }
}

void QUEST_QuestLogExamine(object oPC,object oQuestLog)
{
    if (GetTag(oQuestLog)=="quest_log")
    {
        QUEST_LoadQuestsForLog(oPC,oQuestLog);
    }
}


void QUEST_LoadQuestsForLog(object oPC,object oQuestLog)
{
    string sResult = "Obsahuje tyto ukoly:\n\n";
    int iQuest1 = GetLocalInt(oPC,"QUEST_ORDER_1");
    int iQuest2 = GetLocalInt(oPC,"QUEST_ORDER_2");
    int iQuest3 = GetLocalInt(oPC,"QUEST_ORDER_3");

    if (iQuest1)
    {
        sResult = QUEST_LoadQuestInfo(oPC,iQuest1);
    }
    if (iQuest2)
    {
        sResult += "\n";
        sResult += QUEST_LoadQuestInfo(oPC,iQuest2);
    }
    if (iQuest3)
    {
        sResult += "\n";
        sResult += QUEST_LoadQuestInfo(oPC,iQuest3);
    }
    SetDescription(oQuestLog,sResult);
}










