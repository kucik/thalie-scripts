//tento skript by se mel zeptat, zda uz je neco nastavneho na prodej.
// jestli neni,mel by se spustit timer a az timer dobehne, tak by se mela vygenervoat dalsi shanka po predmetu.

#include "no_tcq_br_inc"
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
                                            //20 minut v pripade ze zadny quest neni
                return;
                                    }

    no_nahoda = 1 + Random(pocet_surovin); // pocet je v no_tcq_br_inc

    SetLocalInt(OBJECT_SELF,"no_poptavka",no_nahoda);
    switch(no_nahoda) {
/*  // brousene
case id_brou_nefr : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_nefr); break;
case id_brou_ohni : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_ohni); break;
case id_brou_amet : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_amet); break;
case id_brou_fene : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_fene); break;
case id_brou_mala : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_mala); break;
case id_brou_aven : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_brou_aven); break;*/
//vynikajici
case id_fine_nefr : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_nefr); break;
case id_fine_ohni : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_ohni); break;
case id_fine_amet : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_amet); break;
case id_fine_fene : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_fene); break;
case id_fine_mala : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_mala); break;
case id_fine_safi : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_safi); break;
case id_fine_topa : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_topa); break;
case id_fine_gran : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_gran); break;
case id_fine_alex : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_alex); break;
case id_fine_aven : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_aven); break;
case id_fine_zive : SetLocalString(OBJECT_SELF,"no_nazevveci",resref_fine_zive); break;
    }




    no_nahoda = 5 + Random(10); //vygeneruje kolik toho chce
    SetLocalInt(OBJECT_SELF,"no_pocetveci",5+Random(10));
    SetLocalInt(OBJECT_SELF,"obch_q_lastquest",ku_GetTimeStamp(0,120)); // zachova 2 hodiny real

}
}
