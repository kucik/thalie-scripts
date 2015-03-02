//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_koze_q_inc"
#include "ku_libtime"

int no_nahoda;
int no_pocet;
string no_nazev;
object no_oPC;
//  string no_pomocna;  //jen pro debug

void main()

{
  no_oPC = GetPCSpeaker();

  no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
  if (no_pocet > 0 ) // kdyz je vse sehnane, vygeneruje novy quest
    return;

                /// debug info pro zkouseni timeru

   //no_nahoda= GetLocalInt(OBJECT_SELF,"obch_q_lastquest");
   //no_pomocna= IntToString(no_nahoda);
   //SpeakString(" last quest: " + no_pomocna );

   //no_nahoda= ku_GetTimeStamp();
   //no_pomocna= IntToString(no_nahoda);
   //SpeakString(" time stamp: " + no_pomocna );
   //   SpeakString( " zkousi porovnavat" );

                 /// konec debug infa.. potom smazat


  if (GetLocalInt(OBJECT_SELF,"obch_q_lastquest") > ku_GetTimeStamp())
    return;

  if(Random(100) > 75) { //  Vygeneruj quest s 25% sanci
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,40));
                                             //40 minut v pripade ze zadny quest neni
    return;
  }

  struct pelt_q quest = tcq_GetRandomPelt();
  if(quest.id < 0)
    return;

  SetLocalString(OBJECT_SELF,"no_nazevveci",quest.sResRef);
  SetLocalString(OBJECT_SELF,"no_poptavka_name",quest.sName);
  SetLocalInt(OBJECT_SELF,"no_poptavka",quest.id);

// SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzejezevce);
// SetLocalInt(OBJECT_SELF,"no_poptavka",id_Kuzejezevce);

//     no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");
//    SendMessageToPC(no_oPC, "//debug info: bylo vygenerovano : " + no_nazev);
    no_nahoda = 10 + Random(30); //vygeneruje kolik toho chce
  SetLocalInt(OBJECT_SELF,"no_pocetveci",10 + Random(30));                   // zapamatuje si tenhle quest :
  SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,240)); //  240 minut
}
