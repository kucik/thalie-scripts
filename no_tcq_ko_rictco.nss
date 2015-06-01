//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_tcq_ko_inc"

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

/*case id_no_suse_obyc:no_nazev = " obycejnych susenych kuzi"; break;
case id_no_suse_leps :no_nazev = " lepsich susenych kuzi"; break;
case id_no_suse_kval :no_nazev = " kvalitnich susenych kuzi"; break;
case id_no_suse_mist:no_nazev = " mistrovskych susenych kuzi"; break;
case id_no_suse_velm :no_nazev = " velmistrovskych susenych kuzi"; break;*/

case id_no_kuze_obyc :no_nazev = " obycejnych kuzi"; break;
case id_no_kuze_leps :no_nazev = " lepsich kuzi"; break;
case id_no_kuze_kval :no_nazev = " kvalitnich kuzi"; break;
case id_no_kuze_mist :no_nazev = " mistrovskych kuzi"; break;
case id_no_kuze_velm :no_nazev = " velmistrovskych kuzi"; break;

case id_no_kozk_obyc :no_nazev = " obycejnych kozek"; break;
case id_no_kozk_leps :no_nazev = " lepsich kozek"; break;
case id_no_kozk_kval :no_nazev = " kvalitnich kozek"; break;
case id_no_kozk_mist :no_nazev = " mistrovskych kozek"; break;
case id_no_kozk_velm :no_nazev = " velmistrovskych kozek"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim trikrat vice, nez kterykoliv jiny obchodnik. " );
}
