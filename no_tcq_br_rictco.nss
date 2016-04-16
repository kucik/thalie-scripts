//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_br_inc"

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

/*
case id_brou_nefr :no_nazev = " brousenych nefritu"; break;
case id_brou_ohni :no_nazev = " brousenych ohnivych achatu"; break;
case id_brou_amet : no_nazev = " brousenych ametystu"; break;
case id_brou_fene : no_nazev = "brousenych fenelopu"; break;
case id_brou_mala : no_nazev = "brousenych malachitu"; break;
//case id_brou_safi : no_nazev = "brousenych safiru"; break;
//case id_brou_topa : no_nazev = "brousenych topazu"; break;
//case id_brou_gran : no_nazev = "brousenych granatu"; break;
//case id_brou_alex : no_nazev = "brousenych alexandritu"; break;
case id_brou_aven : no_nazev = "brousenych aventrurinu"; break;
//case id_brou_zive : no_nazev = "brousenych zivcu"; break;*/
//vynikajici
case id_fine_nefr : no_nazev = "vynikajicich nefritu"; break;
case id_fine_ohni : no_nazev = "vynikajicich ohnivych achatu"; break;
case id_fine_amet : no_nazev = "vynikajicich ametystu"; break;
case id_fine_fene : no_nazev = "vynikajicich fenelopu"; break;
case id_fine_mala: no_nazev = "vynikajicich malachitu"; break;
case id_fine_safi : no_nazev = "vynikajicich safiru "; break;
case id_fine_topa : no_nazev = "vynikajicich topazu"; break;
case id_fine_gran : no_nazev = "vynikajicich granatu"; break;
case id_fine_alex : no_nazev = "vynikajicich alexandritu"; break;
case id_fine_aven : no_nazev = "vynikjaicich aventurinu"; break;
case id_fine_zive : no_nazev = "vynikajicich zivcu"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim trikrat vice, nez kterykoliv jiny obchodnik. " );
}
