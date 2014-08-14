//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_koze_q_inc"

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

case id_Kuzebilehojelena: no_nazev = "kuzi bileho jelena"; break;
case id_Kuzecernehomedveda: no_nazev = "kuzi cerneho medveda"; break;
case id_Kuzegrizzlyho: no_nazev = "kuzi grizzliho"; break;
case id_Kuzehnedehomedveda: no_nazev = "kuzi hnedeho medveda"; break;
case id_Kuzejaguara: no_nazev = "kuzi jaguara"; break;
case id_Kuzejelena: no_nazev = "kuzi jelena"; break;
case id_Kuzejezevce: no_nazev = "kuzi jezevce"; break;
case id_Kuzekocky: no_nazev = "kuzi kocky"; break;
case id_Kuzekrysy: no_nazev = "kuzi krysy"; break;
case id_Kuzelednihomedveda: no_nazev = "kuzi ledniho medveda"; break;
case id_Kuzeleoparda: no_nazev = "kuzi leoparda"; break;
case id_Kuzelitehomedveda: no_nazev = "kuzi liteho medveda"; break;
case id_Kuzelitehotygra: no_nazev = "kuzi liteho tygra"; break;
case id_Kuzelva: no_nazev = " kuzi lva"; break;
case id_Kuzemalara: no_nazev = "kuzi melara"; break;
case id_Kuzenetopyra: no_nazev = "kuzi netopyra"; break;
case id_Kuzepantera: no_nazev = " kuzi pantera"; break;
case id_Kuzeprasete: no_nazev = "kuzi prasete"; break;
case id_Kuzepumy: no_nazev = "kuzi pumy"; break;
case id_Kuzeskalnihomedveda: no_nazev = "kuzi skalniho medveda"; break;
case id_Kuzevlka: no_nazev = "kuzi vlka"; break;
case id_Kuzevola: no_nazev = "kuzi vola"; break;
case id_Kuzeworgha: no_nazev = "kuzi worga"; break;
case id_Kuzezimnihovlka: no_nazev = "kuzi zimniho vlka"; break;
case id_Hadikuze: no_nazev = "hadich kuzi"; break;
case id_Kuzetygrodlaka: no_nazev = " kzi tygrodlaka"; break;
case id_Kuzealansijskehotygra: no_nazev = "kuzi alansijskeho tygra"; break;
case id_Kuzebarghesta: no_nazev = "kuzi barghesta"; break;
case id_Kuzegorily: no_nazev = "kuzi gorily"; break;
case id_Kuzekrenshara: no_nazev = "kuzi krenshara"; break;
case id_Kuzekrokodyla: no_nazev = "kuzi krokodyla"; break;
case id_Kuzelitehovlka: no_nazev = "kuzi liteho vlka"; break;
case id_Kuzeprastarehovlka: no_nazev = "kuzi prastareho vlka"; break;
case id_Kuzerosomaka: no_nazev = "kuzi rosomaka"; break;
case id_Kuzesneznehotygra: no_nazev = "kuzi snezneho tygra"; break;
case id_Kuzesovomedveda: no_nazev = "kuzi sovomedveda"; break;
case id_Kuzesavlozubekocky: no_nazev = "kuzi savlozube kocky"; break;
case id_Kuzesedehotrhace: no_nazev = "kuzi sedeho trhace"; break;
case id_Kuzetygra: no_nazev = "kuzi tygra"; break;
case id_Kuzevelkehoworgha: no_nazev = " kuzi velkeho worgha"; break;
case id_Kuzeyettiho: no_nazev = "kuzi yettiho"; break;
case id_Kuzezralokav: no_nazev = "kuzi zraloka"; break;
case id_Krovkybrouka: no_nazev = "krovek brouka"; break;
case id_Krovkyrohace: no_nazev = "krovek rohace"; break;
case id_Peribeldskehoorla: no_nazev = " peri bledskeho orla"; break;
case id_Peritritona: no_nazev = " peri tritona"; break;
case id_Perihavrana: no_nazev = "peri havrana"; break;
case id_Peripapouska: no_nazev = "peri papouska"; break;
case id_Perisovy: no_nazev = "peri sovy"; break;
case id_Perizesokola: no_nazev = "peri sokola"; break;
case id_Ptaciperi: no_nazev = "ptaciho peri"; break;
case id_Supinybuleta: no_nazev = "supin buleta"; break;
}

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

if (no_pocet==0 ) SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

else SpeakString(" Zrovna potrebuji dodavku materialu. Kdyz mi tedy prineses " + no_pomocna + "  " +  no_nazev + " tak ti za ne zaplatim o pulku vice, nez kterykoliv jiny obchodnik. " );
}
