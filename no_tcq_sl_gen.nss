//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_sl_inc"
#include "ku_libtime"

#include "no_nastcraft_ini"
int no_nahoda;
int no_pocet;
//  string no_pomocna;  //jen pro debug

void main()

{
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
                SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,35));
                                            //10 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_koze_q_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {

  //vycistene veci
/*case id_no_cist_tin: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_tin); break;
case id_no_cist_copp: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_copp); break;
case id_no_cist_verm: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_verm); break;
case id_no_cist_iron: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_iron); break;
case id_no_cist_gold: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_gold); break;
case id_no_cist_plat: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_plat); break;
case id_no_cist_mith: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_mith); break;
case id_no_cist_adam: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_adam); break;
case id_no_cist_tita: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_tita); break;
case id_no_cist_silv: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_cist_silv); break; */
//pruty
case id_no_prut_tin: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_tin); break;
case id_no_prut_copp: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_copp); break;
case id_no_prut_verm: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_verm); break;
case id_no_prut_iron: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_iron); break;
case id_no_prut_gold: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_gold); break;
case id_no_prut_plat: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_plat); break;
case id_no_prut_mith: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_mith); break;
case id_no_prut_adam: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_adam); break;
case id_no_prut_tita: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_tita); break;
case id_no_prut_silv: SetLocalString(OBJECT_SELF,"no_nazevveci",resref_no_prut_silv); break;
    }




    no_nahoda = 5+Random(10); //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",5+Random(10));
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,120)); //
   }                                                                    //=2 hod REAL
}


// 16.4.2016 Odstraneny cistene kovy, nevyplati se.
