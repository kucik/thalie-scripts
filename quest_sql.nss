const int TASK_STATE_INVALID = 0;
const int TASK_STATE_ACTIVE = -1;
const int TASK_STATE_FINISHED= 10000;
/*
Task ma autoincrement
INSERT INTO th_quest (Id, Label,XPReward,GPReward) VALUES (1,'Jizni hlidka',2000,500);
INSERT INTO th_task (QuestId, Label,QuestType,TargetName) VALUES (1,'Projdi Ivorsky lesik',2,'tsk_jh_1');
INSERT INTO th_task (QuestId, Label,QuestType,TargetName) VALUES (1,'Projdi Star doly',2,'tsk_jh_2');
INSERT INTO th_task (QuestId, Label,QuestType,TargetName) VALUES (1,'Projdi Uhlirske milire',2,'tsk_jh_3');
INSERT INTO th_task (QuestId, Label,QuestType,TargetName) VALUES (1,'Projdi Jezirko',2,'tsk_jh_4');
INSERT INTO th_task (QuestId, Label,QuestType,TargetAreaTag,TargetName,TargetCount) VALUES (1,'Zabij 5 jezevcu v ivorsky lesik',1,areax,'Jezevec',5);
INSERT INTO th_task (QuestId, Label,QuestType,TargetAreaTag,TargetName,TargetCount) VALUES (1,'Zabij 5 psu ve stare doly',1,areax,'Pes',5);
INSERT INTO th_task (QuestId, Label,QuestType,TargetAreaTag,TargetName,TargetCount) VALUES (1,'Zabij 5 brouku uhlirske milire',1,areax,'Brouk',5);
INSERT INTO th_task (QuestId, Label,QuestType,TargetAreaTag,TargetName,TargetCount) VALUES (1,'Zabij 3 obri mravence',1,areax,'Mravenec',3);




*/
#include "aps_include"
string QUEST_GetTaskSuperString(int iTaskType, string sTargetAreaTag, string sTargetTag)
{
    string sTaskSuperTag = "";
    switch (iTaskType)
    {
            case QUEST_TYPE_ENTER_TRIGGER:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetTag;
            break;
            case QUEST_TYPE_ENTER_AREA:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag;
            break;
            case QUEST_TYPE_KILL_BY_AREA:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag;
            break;
            case QUEST_TYPE_KILL_BY_MONSTER:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag+"#"+sTargetAreaTag;
            break;
            default:

            break;
    }
    return sTaskSuperTag;
}


void QUEST_CreateTaskList(object oPC, int iOrder, int iQuest)
{
    int iTaskType,iTargetCount,iValue;
    string sTargetAreaTag,sTargetTag,sTaskSuperTag;
    string sSql = "SELECT TaskType,TargetAreaTag,TargetTag,TargetCount FROM th_task where QuestId="+IntToString(iQuest)+";";
    SQLExecDirect(sSql);
    while (SQLFetch() == SQL_SUCCESS)
    {
        iTaskType = StringToInt(SQLGetData(1));
        sTargetAreaTag = SQLGetData(2);
        sTargetTag  = SQLGetData(3);
        iTargetCount = StringToInt(SQLGetData(4));
        sTaskSuperTag = QUEST_GetTaskSuperString(iTaskType, sTargetAreaTag,sTargetTag);
        switch (iTaskType)
        {
            case QUEST_TYPE_KILL_BY_AREA:
                iValue = iTargetCount;
            break;
            case QUEST_TYPE_KILL_BY_MONSTER:
                iValue = iTargetCount;
            break;
            default:
                iValue = TASK_STATE_ACTIVE;
            break;
        }

        sTaskSuperTag = IntToString(iOrder)+"_"+ sTaskSuperTag;
        SetLocalInt(oPC,sTaskSuperTag,iValue);
        if (QUEST_DEBUG) SendMessageToPC(oPC,"SuperTag:"+sTaskSuperTag+"!!!"+IntToString(iValue));
    }
}

void QUEST_LoadQuestsForBoard(object oPC, object oBoard)
{
    string sResult = "";
    string sName,sDescription,sId,sLevel,sGP,sXP;
    string sSql = "SELECT Q.Id,Q.Name,Q.Description,Q.RecommendedLevel,Q.XPReward,Q.GPReward FROM th_quest Q JOIN th_questboard B ON Q.Id=B.QuestId where B.QuestBoardTag='"+GetTag(oBoard)+"' and ("+IntToString(GetHitDice(oPC))+"<=Q.MaxLevel or Q.MaxLevel=0);";
    SQLExecDirect(sSql);
    while (SQLFetch() == SQL_SUCCESS)
    {
        sId = SQLGetData(1);
        sName = SQLGetData(2);
        sDescription = SQLGetData(3);
        sLevel = SQLGetData(4);
        sXP = SQLGetData(5);
        sGP = SQLGetData(6);
        sResult = sResult + sName+"\n";
        sResult = sResult + "Zakazka cislo: "+sId+"\n";
        sResult = sResult + "Doporucena uroven: "+sLevel+"\n";
        sResult = sResult + sDescription+"\n";
        sResult = sResult + "Zkusenosti: "+sXP+"\n";
        sResult = sResult + "Mince: "+sGP+"\n";
        sResult = sResult + "\n";
        sResult = sResult + "\n";
    }
    SetDescription(oBoard,sResult);
}


int QUEST_GetIsQuestValid(object oPC, object oBoard, int iQuest)
{
    string sResult = "";
    string sName,sDescription,sId,sLevel,sGP,sXP;
    string sSql = "SELECT Q.Id FROM th_quest Q JOIN th_questboard B ON Q.Id=B.QuestId where B.QuestBoardTag='"+GetTag(oBoard)+ "' and ("+IntToString(GetHitDice(oPC))+" <= Q.MaxLevel or Q.MaxLevel=0) and Q.Id="+IntToString(iQuest)+";";
    if (QUEST_DEBUG) SendMessageToPC(oPC,"Valid SQL:"+sSql);
    SQLExecDirect(sSql);

    if (SQLFetch() == SQL_SUCCESS)
    {
        return TRUE;
    }
    return FALSE;
}


string QUEST_LoadQuestInfo(int iOrder,object oPC,int iQuestId)
{
    string sResult = "";
    string sName,sQuestState,sState,sSuperString,sText,sAreaTag,sTargetTag,sTargetCount;
    int iTaskType,iTaskValue;
    string sSql = "SELECT Q.Name FROM th_quest Q where Q.Id="+IntToString(iQuestId);
    SQLExecDirect(sSql);
    if (SQLFetch() == SQL_SUCCESS)
    {
        int iReward = GetLocalInt(oPC,IntToString(iOrder)+"REWARD");
        sQuestState = "";
        if (iReward)
        {
            sQuestState = " - ODEVZDANO";
        }
        sName = SQLGetData(1);
        sResult = sResult + sName+sQuestState+"\n";
        string sSql = "SELECT T.Text,T.TaskType,T.TargetAreaTag,TargetTag,TargetCount FROM th_task T where T.QuestId="+IntToString(iQuestId);
        SQLExecDirect(sSql);
        while (SQLFetch() == SQL_SUCCESS)
        {
            sText = SQLGetData(1);
            iTaskType = StringToInt(SQLGetData(2));
            sAreaTag = SQLGetData(3);
            sTargetTag = SQLGetData(4);
            sTargetCount = SQLGetData(5);
            sSuperString = IntToString(iOrder)+"_"+QUEST_GetTaskSuperString(iTaskType,sAreaTag,sTargetTag);
            iTaskValue =  GetLocalInt(oPC,sSuperString);
            if (QUEST_DEBUG) SendMessageToPC(oPC,"OVEROVANI-SuperTag:"+sSuperString+"!!!"+IntToString(iTaskValue));
            sState = "";
            switch (iTaskType)
            {
                case QUEST_TYPE_ENTER_AREA:
                case QUEST_TYPE_ENTER_TRIGGER:
                    if (iTaskValue==TASK_STATE_FINISHED)
                    {
                        sState = " - HOTOVO";
                    }
                break;
                case QUEST_TYPE_KILL_BY_MONSTER:
                case QUEST_TYPE_KILL_BY_AREA:
                    if (iTaskValue==TASK_STATE_FINISHED)
                    {
                        sState = " - HOTOVO";
                    }
                    else
                    {
                        sState = " ("+IntToString(StringToInt(sTargetCount)-iTaskValue)+"/"+sTargetCount+")";
                    }
                break;
            }
            sResult += "- "+sText+sState+"\n";
        }
        sResult += "\n";
    }
    return sResult;
}



void QUEST_ProcessReward(int iOrder,object oPC,int iQuestId)
{
    int iReward = GetLocalInt(oPC,IntToString(iOrder)+"REWARD");
    if (iReward==1)
    {
        //Postava jiz odmenu dostala
        return;
    }

    string sResult = "";
    string sName,sState,sSuperString,sText,sAreaTag,sTargetTag;
    int iTaskType,iTaskValue;
    int iXPReward = 0;
    int iGPReward = 0;
    string sQuestName;
    //Zjistim zlato a zkusenosti
    string sSql = "SELECT Q.XPReward,Q.GPReward,Q.Name FROM th_quest Q where Q.Id="+IntToString(iQuestId);
    SQLExecDirect(sSql);
    if (SQLFetch() == SQL_SUCCESS)
    {
        iXPReward =StringToInt(SQLGetData(1));
        iGPReward = StringToInt(SQLGetData(2));
        sQuestName = SQLGetData(3);
    }
    else
    {
        return;
    }
    //Projdu tasky
    sSql = "SELECT T.TaskType,T.TargetAreaTag,TargetTag,T.Text FROM th_task T where T.QuestId="+IntToString(iQuestId);
    SQLExecDirect(sSql);
    while (SQLFetch() == SQL_SUCCESS)
    {
        iTaskType = StringToInt(SQLGetData(1));
        sAreaTag = SQLGetData(2);
        sTargetTag = SQLGetData(3);
        sText = SQLGetData(4);
        sSuperString = IntToString(iOrder)+"_"+QUEST_GetTaskSuperString(iTaskType,sAreaTag,sTargetTag);
        iTaskValue =  GetLocalInt(oPC,sSuperString);
        if (iTaskValue==TASK_STATE_FINISHED)
        {
            //Je to okej
        }
        else
        {
            if (QUEST_DEBUG) SendMessageToPC(oPC,IntToString(iOrder) + " - Nesplnen ukol -  "+sText);
            return;
        }
    }
    //Zavedu odmenu
    SendMessageToPC(oPC,"Ukol dokoncen: "+sQuestName);
    //Oznacim vybrani odmeny
    SetLocalInt(oPC,IntToString(iOrder)+"REWARD",TRUE);
    //Vyplatim odmenu
    SetXP(oPC,GetXP(oPC)+iXPReward);
    GiveGoldToCreature(oPC,iGPReward);
}
