//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_ryby_q_inc"

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

case id_kapr: no_nazev = " peknych kapru "; break;
case id_kaprik: no_nazev = " kapriku potocnich "; break;
case id_masokraba: no_nazev = " kousku masa z kraba "; break;
case id_modrinka: no_nazev = " modrinek morskych"; break;
case id_okoun : no_nazev = " okounu "; break;
case id_pstruh : no_nazev = " pstruhu "; break;
case id_rak : no_nazev = " raku "; break;
case id_treska : no_nazev = " tresek "; break;
case id_uhor: no_nazev =  " uhoru "; break;
case id_zralok : no_nazev = " zraloku "; break;
case id_cejn : no_nazev = " cenjnu "; break;
case id_lin : no_nazev = " linu "; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna toho mam plnou hlavu. Dostal sem objednavku, kterou nestiham vyridit. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne dobre zaplatim " );
}
