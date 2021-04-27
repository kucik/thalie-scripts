
const int QUEST_DEBUG = 0;

const int QUEST_TYPE_ENTER_TRIGGER = 1;                                         //TargetTag
const int QUEST_TYPE_ENTER_AREA = 2;                                            //TargetAreaTag
const int QUEST_TYPE_KILL_BY_AREA = 3;                                          //TargetAreaTag,TargetCount
const int QUEST_TYPE_KILL_BY_MONSTER = 4;                                       //TargetAreaTag,TargetCount,TargetTag
#include "quest_sql"
//konstanty


//Definice
void QUEST_InitQuest();
//Vrati objekt pro cache questu
object QUEST_GetQuestTaskObject();
void QUEST_QuestBoardExamine(object oPC,object oQuestBoard);
void QUEST_QuestLogExamine(object oQuestLog);
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
    int iQuestOrder2 = GetLocalInt(oPC,"QUEST_ORDER_2");
    int iQuestOrder3 = GetLocalInt(oPC,"QUEST_ORDER_3");
    if  ((iQuestOrder1==iQuestNumber) || (iQuestOrder2==iQuestNumber) ||(iQuestOrder3==iQuestNumber))
    {
        SendMessageToPC(oPC,"Tento quest jiz mas.");
        return;
    }


    if (iQuestOrder1 > 0)  //Quest obsazen
    {

        if (iQuestOrder2 > 0) //Quest obsazen
        {

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

void QUEST_QuestLogExamine(object oQuestLog)
{
    if (GetTag(oQuestLog)=="quest_log")
    {
        object oPC = GetItemPossessor(oQuestLog);
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
        sResult = QUEST_LoadQuestInfo(1,oPC,iQuest1);
    }
    if (iQuest2)
    {
        sResult += "\n";
        sResult += QUEST_LoadQuestInfo(2,oPC,iQuest2);
    }
    if (iQuest3)
    {
        sResult += "\n";
        sResult += QUEST_LoadQuestInfo(3,oPC,iQuest3);
    }
    SetDescription(oQuestLog,sResult);
}

void QUEST_ProcessTaskByOrder(object oPC,int iQuestOrder, int iTaskType, string sSuperString)
{
    string sSuperTag = IntToString(iQuestOrder)+"_"+ sSuperString;
    int iTaskValue = GetLocalInt(oPC,sSuperTag);
    if (iTaskValue==0)
    {
        //Postava nema dany task
        return;
    }
    switch (iTaskType)
    {
        case QUEST_TYPE_ENTER_AREA:
        case QUEST_TYPE_ENTER_TRIGGER:
            if (iTaskValue==TASK_STATE_ACTIVE)
            {
                iTaskValue = TASK_STATE_FINISHED;
                SetLocalInt(oPC,sSuperTag,iTaskValue);
            }
            SendMessageToPC(oPC,"Kniha ukolu aktualizovana.");
        break;
        case QUEST_TYPE_KILL_BY_MONSTER:
        case QUEST_TYPE_KILL_BY_AREA:
            if (iTaskValue==1)
            {
                iTaskValue = TASK_STATE_FINISHED;
                SetLocalInt(oPC,sSuperTag,iTaskValue);
            }
            else
            {
                iTaskValue = iTaskValue - 1;
                SetLocalInt(oPC,sSuperTag,iTaskValue);
            }
            SendMessageToPC(oPC,"Kniha ukolu aktualizovana.");
        break;
    }
}


void QUEST_ProcessTaskType1(object oPC,object oTrigger)
{
    if (!GetIsPC(oPC)) return;
    string sSuperString = QUEST_GetTaskSuperString(QUEST_TYPE_ENTER_TRIGGER,"",GetTag(oTrigger));
    QUEST_ProcessTaskByOrder(oPC,1,QUEST_TYPE_ENTER_TRIGGER,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,2,QUEST_TYPE_ENTER_TRIGGER,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,3,QUEST_TYPE_ENTER_TRIGGER,sSuperString);
}

void QUEST_ProcessTaskType2(object oPC,object oArea)
{
    if (!GetIsPC(oPC)) return;
    string sSuperString = QUEST_GetTaskSuperString(QUEST_TYPE_ENTER_AREA,GetTag(oArea),"");
    QUEST_ProcessTaskByOrder(oPC,1,QUEST_TYPE_ENTER_AREA,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,2,QUEST_TYPE_ENTER_AREA,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,3,QUEST_TYPE_ENTER_AREA,sSuperString);
}

void QUEST_ProcessTaskType34(object oPC,object oNPC)
{
    object oArea = GetArea(oNPC);
    string sSuperString = QUEST_GetTaskSuperString(QUEST_TYPE_KILL_BY_AREA,GetTag(oArea),GetTag(oNPC));
    QUEST_ProcessTaskByOrder(oPC,1,QUEST_TYPE_KILL_BY_AREA,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,2,QUEST_TYPE_KILL_BY_AREA,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,3,QUEST_TYPE_KILL_BY_AREA,sSuperString);

    sSuperString = QUEST_GetTaskSuperString(QUEST_TYPE_KILL_BY_MONSTER,GetTag(oArea),GetTag(oNPC));
    QUEST_ProcessTaskByOrder(oPC,1,QUEST_TYPE_KILL_BY_MONSTER,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,2,QUEST_TYPE_KILL_BY_MONSTER,sSuperString);
    QUEST_ProcessTaskByOrder(oPC,3,QUEST_TYPE_KILL_BY_MONSTER,sSuperString);
}






void QUEST_ReturnReward(object oPC)
{
    int iQuest1 = GetLocalInt(oPC,"QUEST_ORDER_1");
    int iQuest2 = GetLocalInt(oPC,"QUEST_ORDER_2");
    int iQuest3 = GetLocalInt(oPC,"QUEST_ORDER_3");

    if (iQuest1)
    {
        QUEST_ProcessReward(1,oPC,iQuest1);
    }
    if (iQuest2)
    {
        QUEST_ProcessReward(2,oPC,iQuest2);
    }
    if (iQuest3)
    {
        QUEST_ProcessReward(3,oPC,iQuest3);
    }
}







