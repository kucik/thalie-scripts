//no_love_q_gener
//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

//#include "no_love_q_inc"
#include "ku_libtime"
#include "ku_loveq_inc"

int no_nahoda;
int no_pocet;
//  string no_pomocna;  //jen pro debug


void main()

{
  // Uz je zadany quest
  if(GetLocalInt(OBJECT_SELF,"lovec_q_lastquest") > ku_GetTimeStamp() )
    return;

  if(Random(100) > 75) { //  Vygeneruj quest s 25% sanci
    SetLocalInt(OBJECT_SELF,"lovec_q_lastquest",ku_GetTimeStamp(0,20));
    SetLocalInt(OBJECT_SELF,"lovec_q_qid",0);
                                          //20 minut v pripade ze zadny quest neni

    return;
  }

  // Generate quest
  struct loveq_q quest;

  quest = ku_lqGetRandomTrophy();
  SetLocalInt(OBJECT_SELF,"lovec_q_qid",quest.id);
  SetLocalString(OBJECT_SELF,"lovec_q_qname",quest.sName);
  SetLocalString(OBJECT_SELF,"lovec_q_qtag",quest.sTag);
  SetLocalInt(OBJECT_SELF,"lovec_q_lastquest",ku_GetTimeStamp(0,720)); // zachova si quest celej restart


}

