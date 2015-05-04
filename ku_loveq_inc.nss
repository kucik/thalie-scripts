//ku_loveq_inc

#include "ku_libtime"
#include "aps_include"

struct loveq_q
{
    int id;
    string sTag;
    string sName;
    string sTrofejName;
};

int ku_GetNumberOfTrophy() {

  string sSql = "SELECT count(*) FROM static_quests WHERE quest = 'lovec_trofeji' AND name = 'trofej';";
//  SpeakString(sSql);
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    return StringToInt(SQLGetData(1));
  }
  else
    return 0;
}

struct loveq_q ku_lqGetRandomTrophy() {
  struct loveq_q quest;

  string sSql = "SELECT id, param1, param2, param3 from static_quests WHERE quest = 'lovec_trofeji' AND name = 'trofej' ORDER BY RAND() LIMIT 0,1;";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    quest.id = StringToInt(SQLGetData(1));
    quest.sName = SQLGetData(2);
    quest.sTag = SQLGetData(3);
    quest.sTrofejName = SQLGetData(4);
  }
  else {
    SpeakString("Chyba! Není mozne vybrat quest!");
  }

  return quest;
}

struct loveq_q dumpTrophy() {
  struct loveq_q quest;

  string sSql = "SELECT id, param1, param2, param3 from static_quests WHERE quest = 'lovec_trofeji' AND name = 'trofej';";
  SQLExecDirect(sSql);
  while(SQLFetch() == SQL_SUCCESS) {
//    quest.id = StringToInt(SQLGetData(1));
    quest.sName = SQLGetData(2);
    quest.sTag = SQLGetData(3);
    quest.sTrofejName = SQLGetData(4);
    object oItem = GetObjectByTag(quest.sTag);
    if(GetIsObjectValid(oItem))
      WriteTimestampedLogEntry(quest.sTag+"|"+GetResRef(oItem)+"|"+GetName(oItem)+"|"+quest.sTrofejName+"|"+quest.sName);
  }

  return quest;
}
