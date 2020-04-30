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
        switch (iTaskType)
        {
            case 1:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetTag;
                iValue = TASK_STATE_ACTIVE;
            break;
            case 2:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag;
                iValue = TASK_STATE_ACTIVE;
            break;
            case 3:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag;
                iValue = iTargetCount;
            break;
            case 4:
                sTaskSuperTag = IntToString(iTaskType)+"#"+sTargetAreaTag+"#"+sTargetAreaTag;
                iValue = iTargetCount;
            break;
            default:
                return;
            break;
        }
        sTaskSuperTag = IntToString(iOrder)+"_"+ sTaskSuperTag;
        SetLocalInt(oPC,sTaskSuperTag,iValue);
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


string QUEST_LoadQuestInfo(object oPC,int iQuestId)
{
    string sResult = "";
    string sName,sDescription,sId,sLevel,sGP,sXP;
    string sSql = "SELECT Q.Name FROM th_quest Q where Q.Id="+IntToString(iQuestId);
    SQLExecDirect(sSql);
    if (SQLFetch() == SQL_SUCCESS)
    {
        sName = SQLGetData(1);
        sResult = sName+"\n";
        string sSql = "SELECT T.Text FROM th_task T where T.QuestId="+IntToString(iQuestId);
        SQLExecDirect(sSql);
        while (SQLFetch() == SQL_SUCCESS)
        {
            sName = SQLGetData(1);
            sResult += "- "+sName+"\n";
        }











        sResult += "\n";
    }


    return sResult;
}


