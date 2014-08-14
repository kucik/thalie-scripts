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

                if(Random(100) > 75) { //  Vygeneruj quest s 25% sanci
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,40));
                                             //40 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_koze_q_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {

case id_Kuzebilehojelena: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzebilehojelena); break;
case id_Kuzecernehomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzecernehomedveda); break;
case id_Kuzegrizzlyho: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzegrizzlyho); break;
case id_Kuzehnedehomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzehnedehomedveda); break;
case id_Kuzejaguara: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzejaguara); break;
case id_Kuzejelena: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzejelena); break;
case id_Kuzejezevce: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzejezevce); break;
case id_Kuzekocky: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekocky); break;
case id_Kuzekrysy: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekrysy); break;
case id_Kuzelednihomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzelednihomedveda); break;
case id_Kuzeleoparda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeleoparda); break;
case id_Kuzelitehomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzelitehomedveda); break;
case id_Kuzelitehotygra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzelitehotygra); break;
case id_Kuzelva: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzelva); break;
case id_Kuzemalara: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzemalara); break;
case id_Kuzenetopyra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzenetopyra); break;
case id_Kuzepantera: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzepantera); break;
case id_Kuzeprasete: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeprasete); break;
case id_Kuzepumy: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzepumy); break;
case id_Kuzeskalnihomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeskalnihomedveda); break;
case id_Kuzevlka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzevlka); break;
case id_Kuzevola: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzevola); break;
case id_Kuzeworgha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeworgha); break;
case id_Kuzezimnihovlka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzezimnihovlka); break;
case id_Hadikuze: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Hadikuze); break;
case id_Kuzetygrodlaka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzetygrodlaka); break;
case id_Kuzealansijskehotygra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzealansijskehotygra); break;
case id_Kuzebarghesta: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzebarghesta); break;
case id_Kuzegorily: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzegorily); break;
case id_Kuzekrenshara: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekrenshara); break;
case id_Kuzekrokodyla: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekrokodyla); break;
case id_Kuzelitehovlka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzelitehovlka); break;
case id_Kuzeprastarehovlka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeprastarehovlka); break;
case id_Kuzerosomaka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzerosomaka); break;
case id_Kuzesneznehotygra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzesneznehotygra); break;
case id_Kuzesovomedveda: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzesovomedveda); break;
case id_Kuzesavlozubekocky: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzesavlozubekocky); break;
case id_Kuzesedehotrhace: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzesedehotrhace); break;
case id_Kuzetygra: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzetygra); break;
case id_Kuzevelkehoworgha: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzevelkehoworgha); break;
case id_Kuzeyettiho: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzeyettiho); break;
case id_Kuzezralokav: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzezralokav); break;
case id_Krovkybrouka: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krovkybrouka); break;
case id_Krovkyrohace: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Krovkyrohace); break;
case id_Peribeldskehoorla: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Peribeldskehoorla); break;
case id_Peritritona: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Peritritona); break;
case id_Perihavrana: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Perihavrana); break;
case id_Peripapouska: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Peripapouska); break;
case id_Perisovy: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Perisovy); break;
case id_Perizesokola: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Perizesokola); break;
case id_Ptaciperi: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Ptaciperi); break;
case id_Supinybuleta: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Supinybuleta); break;

    }
              // test
             // pro test  SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzekrokodyla);
             //test 2

// SetLocalString(OBJECT_SELF,"no_nazevveci",resref_Kuzejezevce);
// SetLocalInt(OBJECT_SELF,"no_poptavka",id_Kuzejezevce);

//     no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");
//    SendMessageToPC(no_oPC, "//debug info: bylo vygenerovano : " + no_nazev);
    no_nahoda = 10 + Random(30); //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",no_nahoda);                   // zapamatuje si tenhle quest :
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,240)); //  240 minut
   }                                                                    //  =4hod REAL
}
