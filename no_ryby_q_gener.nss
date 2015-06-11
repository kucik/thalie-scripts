//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_ryby_q_inc"
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
  if (no_pocet==0 ) // kdyz je vse sehnane, vygeneruje novy quest
   {

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

                if(Random(100) > 85) { //  Vygeneruj quest s 25% sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,10));
                                             //10 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_ryby_q_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {

case id_kapr: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_kapr); break;
case id_kaprik: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_kaprik); break;
case id_masokraba: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_masokraba); break;
case id_modrinka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_modrinka); break;
case id_okoun : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_okoun); break;
case id_pstruh : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_pstruh); break;
case id_rak : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_rak); break;
case id_treska : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_treska); break;
case id_uhor: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_uhor); break;
case id_zralok : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_zralok); break;
case id_cejn : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_cejn); break;
case id_lin : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_lin); break;



    }
              // test
             // pro test  SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekrokodyla);

    no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");
    SendMessageToPC(no_oPC, "//debug info: bylo vygenerovano : " + no_nazev);
    no_nahoda = 2 + Random(5); //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);                   // zapamatuje si tenhle quest :
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,60)); //  60 minut
   }                                                                    //  =1hod REAL
}
