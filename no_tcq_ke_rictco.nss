//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_ke_inc"

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

/*case id_no_cist_jil: no_nazev = "kbeliku vycisteneho jilu"; break;
case id_no_cist_pise: no_nazev = "kbeliku vycisteneho pisku"; break; */
//vyrobky
case id_mala_forma: no_nazev = " malych forem "; break;
case id_sklenena_lahev: no_nazev = "sklenenych lahvi"; break;
case id_tenka_forma : no_nazev = "tenkych forem"; break;
case id_sklenena_ampule : no_nazev = "sklenenych ampuli"; break;
case id_stredni_forma : no_nazev = "strednich forem"; break;
case id_velka_forma: no_nazev = "velkych forem"; break;
case id_zahnuta_forma: no_nazev = "zahnutych forem"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim trikrat vice, nez kterykoliv jiny obchodnik. " );
}
