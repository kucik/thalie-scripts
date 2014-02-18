//ku_baliky_inc

#include "aps_include"

struct q_balik
{
  int iFrom;
  int iTo;
  string sTo;
  int iDifficulty;
}


int ku_bal_GetRandomRoute(int iID) {
  struct q_balik route;
  route.iTo = 0;

  string sSql = "SELECT r.npc_1, r.npc_2, r.difficulty, n.address FROM sq_bal_routes r, sq_bal_npc n WHERE r.npc_1 = '"+IntToString(iID)+"' AND n.id = r.npc_2 ORDER BY RAND() LIMIT 0,1;";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    route.iFrom = StringToInt(SQLGetData(1));
    route.iTo = StringToInt(SQLGetData(2));
    route.iDifficulty = StringToInt(SQLGetData(3));
    route.sTo = SQLGetData(4);
  }
  else {
    SpeakString("Chyba! Není mozne vybrat trasu baliku!");
  }

  return quest;
}


