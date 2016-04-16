//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_sl_inc"

string no_nazev;
string no_pomocna;
int no_pocet;

void main()
{

no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");   //nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
no_pomocna = IntToString(no_pocet);
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


switch(zbozi) {
/*case id_no_cist_tin:  no_nazev = "kusu vycisteneho cinu"; break;
case id_no_cist_copp: no_nazev = "kusu vycistene medi"; break;
case id_no_cist_verm: no_nazev = "kusu vycisteneho vermajlu"; break;
case id_no_cist_iron: no_nazev = "kusu vycisteneho zeleza"; break;
case id_no_cist_gold: no_nazev = "kusu vycisteneho zlata"; break;
case id_no_cist_plat: no_nazev = "kusu vycistene platiny"; break;
case id_no_cist_mith: no_nazev = "kusu vycisteneho mithrilu"; break;
case id_no_cist_adam: no_nazev = "kusu vycisteneho adamantinu"; break;
case id_no_cist_tita: no_nazev = "kusu vycisteneho titanu"; break;
case id_no_cist_silv: no_nazev = "kusu vycisteneho stribra"; break;*/
//pruty
case id_no_prut_tin: no_nazev = " prutu cinu"; break;
case id_no_prut_copp: no_nazev = " prutu medi"; break;
case id_no_prut_verm: no_nazev = " prutu vermajlu"; break;
case id_no_prut_iron: no_nazev = " prutu zeleza"; break;
case id_no_prut_gold: no_nazev = " prutu zlata"; break;
case id_no_prut_plat: no_nazev = " prutu platiny"; break;
case id_no_prut_mith: no_nazev = " prutu mithrilu"; break;
case id_no_prut_adam: no_nazev = " prutu adamntinu"; break;
case id_no_prut_tita: no_nazev = " prutu titanu"; break;
case id_no_prut_silv: no_nazev = " prutu stribra"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim trikrat vice, nez kterykoliv jiny obchodnik. " );
}
