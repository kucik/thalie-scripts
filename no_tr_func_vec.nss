#include "ku_libtime"
//#include "no_tr_inc_vec"
#include "tc_xpsystem_inc"
//#include "no_dr_inc"
//#include "no_sl_inc"
#include "no_nastcraft_ini"
#include "ku_items_inc"
#include "ku_persist_inc"
#include "tc_functions"

/////////////////////////////////////
///  dela vsemozne truhlarske vyrobky s tagama:
///
///  boty: no_tr_kr_01_02
/// 01-kuze  02 pouzite drevo, 02 pouzity kov
///
/////////////////////////////////

int no_pocet;
string no_nazev;
int no_DC;

void SetToulecName(object oToulec,string sZkratkaTyp,int iDrevo, int iKov);
//nastavenie mena pre tulce šípov/šipiek

void no_zjistiobsah(string no_tagveci);
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

void  no_udelejjmeno(object no_Item);
// podle no:zjistisutry udela celkocej nazec predmetu.

void no_cenavyrobku(object no_Item);
// nastavi cenu vyrobku

void no_nazevsutru(int no_sutr);
//udela na OBJECT_SELF no_nazevsutru  string s nazvem


void no_vynikajicikus(object no_Item);
// prida nahodne neco dobreho, kdyz bude vynikajici vyrobek !

void no_krluk(object no_pec);
//udela vyrobek + mu udeli vlastnosti podle prvniho kamene.
void no_dlluk(object no_pec);
//udela vyrobek + mu udeli vlastnosti podle prvniho kamene.
void no_mlkus(object no_pec);
//udela na vyrobku vlastnosti druheho kamene
void no_vlkus(object no_pec);
//udela na vyrobku vlastnosti druheho kamene
void no_sipy(object no_pec);
//udela na vyrobku vlastnosti druheho kamene
void no_sipky(object no_pec);
//udela na vyrobku vlastnosti druheho kamene
void no_stit(object no_pec, int no_druh_stitu);

void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_no_pouzitykov(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_pouzitykov
void no_drevo(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_drevo
void no_tetiva(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_tetiva
void no_peri(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_peri
void no_nyty(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_nyty
void no_vyrobek (object no_Item, object no_pec, int no_mazani);
// nastavi promennou no_sperk

///////////////funkce pro ovladani zarizeni//////////////////////////////

void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare
void no_zamkni(object no_oPC);
// zamkne a pak odemkne + prehrava animacku

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item);
//pridava procenta k vyrobkum, bo se nam to tam moc pletlo, + to bylo 2krat

void no_xp_tr (object no_oPC, object no_pec);
//pomaha pridavat % polotovaru, kdyztak predava hotovvej vyrobek, pridava xpy..

void no_xp_pridej_tetivu(object no_oPC, object no_pec);
// prida jakemukoliv polotovaru kamen, ktery je zrovna hozeny do pece.
void no_xp_krluk(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovar kratkeho luku
void no_xp_dlluk(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovar dlouheho luku
void no_xp_mlkus(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovark male kuse
void no_xp_vlkus(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovark velke kuse
void no_xp_sipy(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovar
void no_xp_sipky(object no_oPC, object no_pec, int no_druh_kuze);
// vytvori polotovar
void no_xp_stit(object no_oPC, object no_pec, int no_druh_kuze, int no_druh_stitu);
// vytvori polotovar


//////////////////////////////////////////////////////////////////////////////////////////
void no_pohybklikacu(object no_oPC, object no_pec);


//nastavenie mena pre tulce šípov a šipiek
/*
Drevo 1 - 8
Kov 1 - 12
Typ:
si - sip
sp - sipka
*/
void SetToulecName(object oToulec,string sZkratkaTyp,int iDrevo, int iKov)
{
string sDrevo;
string sTyp = "";
string sKov;
string sName;
if (sZkratkaTyp == "si")
{
  sTyp = "Sip" ;
}
if (sZkratkaTyp == "sp")
{
  sTyp = "Sipka";
}

switch (iDrevo)
{
case 1:
sDrevo = "z Vrby";
break;
case 2:
sDrevo = "z Orechu";
break;
case 3:
sDrevo = "z Dubu";
break;
case 4:
sDrevo = "z Mahagonu";
break;
case 5:
sDrevo = "z Tisu";
break;
case 6:
sDrevo = "z Jilmu";
break;
case 7:
sDrevo = "z Zelezneho Dubu";
break;
case 8:
sDrevo = "z Prastareho Dubu";
break;
default:
sDrevo = "";
}

switch (iKov)
{
case 1:
sKov = "s Cinovym Zdobenim";
break;
case 2:
sKov = "s Medenym Zdobenim";
break;
case 3:
sKov = "s Bronzovym Zdobenim";
break;
case 4:
sKov = "s Zeleznym Zdobenim";
break;
case 5:
sKov = "se Zlatym Zdobenim";
break;
case 6:
sKov = "s Platinovym Zdobenim";
break;
case 7:
sKov = "s Mithrilovym Zdobenim";
break;
case 8:
sKov = "s Adamantitovym Zdobenim";
break;
case 9:
sKov = "s Titanovym Zdobenim";
break;
case 10:
sKov = "se Stribrnym Zdobenim";
break;
case 11:
sKov = "se Zdobenim ze Stinove Oceli";
break;
case 12:
sKov = "s Meteorickym Zdobenim";
break;
default:
sKov = "";
}

sName = "Toulec - "+sTyp+" "+sDrevo +" " + sKov;
SetName(oToulec,sName);

//prebrate z no_udelejjmeno()
//kuciks work :
SetStolenFlag(no_Item,0);
SetPlotFlag(no_Item,0);

ku_SetItemDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + sName + " vyrobil " + GetName(no_oPC) + "."+ "                // crft. v.:"+ no_verzecraftu+ " //");

SetLocalString(no_Item, "no_verze_craftu",no_verzecraftu);
SetPlotFlag(no_Item,1);
}




/////////zacatek zavadeni funkci//////////////////////////////////////////////

void no_zjistiobsah(string no_tagveci)
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku
{

string no_pouzitavec="";
int no_pocetsutru=0;
SetLocalInt(OBJECT_SELF,"no_pouzite_drevo",0);
SetLocalString(OBJECT_SELF,"no_pouzite_drevo","");
SetLocalInt(OBJECT_SELF,"no_druh_vyrobku",0);
SetLocalString(OBJECT_SELF,"no_druh_vyrobku","");
SetLocalInt(OBJECT_SELF,"no_kov_luku",0);
SetLocalString(OBJECT_SELF,"no_kov_luku","");



// tag vsech luku a sipu atd.  :  no_tr_XX_01_02  01-drevo 02-kov

string no_druh_vyrobku = GetStringLeft(no_tagveci,8);
// budem do nej ukaladat co to ma za tip
no_druh_vyrobku = GetStringRight(no_druh_vyrobku,2);
// kr = kratky luk
// dl = dlouhy luk
// mk = mala kus
// vk = velka kus
// si = sip
// sp = sipka
SetLocalString(OBJECT_SELF,"no_druh_vyrobku",no_druh_vyrobku);

/////zjistime pouziti drevo/////////////
no_pouzitavec = GetStringLeft(no_tagveci,11);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_pouzite_drevo",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_pouzite_drevo",(StringToInt(no_pouzitavec)));


/////zjistime 1 sutr/////////////
no_pouzitavec = GetStringLeft(no_tagveci,14);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_kov_luku",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_kov_luku",(StringToInt(no_pouzitavec)));


}////////konec no_zjisti_obsah

void no_nazevkovu(int no_sutr)
//ulozi do string no_nazev_kov no OBVJECT_SELF stringovej nazev kovu
{
switch(no_sutr) {
case 1:  SetLocalString(OBJECT_SELF,"no_nazev_kov","cinovym"); break;
case 2:  SetLocalString(OBJECT_SELF,"no_nazev_kov","medenym"); break;
case 3:  SetLocalString(OBJECT_SELF,"no_nazev_kov","bronzovym"); break;
case 4:  SetLocalString(OBJECT_SELF,"no_nazev_kov","zeleznym"); break;
case 5:  SetLocalString(OBJECT_SELF,"no_nazev_kov","zlatym"); break;
case 6:  SetLocalString(OBJECT_SELF,"no_nazev_kov","platinovym"); break;
case 7:  SetLocalString(OBJECT_SELF,"no_nazev_kov","mitrilovym"); break;
case 8:  SetLocalString(OBJECT_SELF,"no_nazev_kov","adamantinovym"); break;
case 9:  SetLocalString(OBJECT_SELF,"no_nazev_kov","titanovym"); break;
case 10:  SetLocalString(OBJECT_SELF,"no_nazev_kov","stribrnym"); break;
case 11:  SetLocalString(OBJECT_SELF,"no_nazev_kov","stinovym"); break;
case 12:  SetLocalString(OBJECT_SELF,"no_nazev_kov","meteoritickym"); break;
}//konec switche
} //konec no_nazevsutru

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////udela jmeno celkoveho vyrobku at uz to je cokoliv///////////////////////////////
void  no_udelejjmeno(object no_Item)
{
no_zjistiobsah(GetTag(no_Item)); // prptoze pro meno to vetsinou potrebujem prenastavit.
string no_jmeno = "";


if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
no_jmeno = "Kratky luk z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {
no_jmeno = "Dlouhy luk z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {
no_jmeno = "Mala kus z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {
no_jmeno = "Velka kus z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") {
no_jmeno = "Toulec - Sipy z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "_b") {
no_jmeno = "Toulec - Sipy z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") {
no_jmeno = "Toulec - Sipky z  " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "_c") {
no_jmeno = "Toulec - Sipky z  " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
no_jmeno = "Maly stit z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
no_jmeno = "Velky stit z " ;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
no_jmeno = "Paveza z " ;  }


switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){

case 1: {no_jmeno =no_jmeno +"vrby"   ;
         break; }
case 2: {no_jmeno =no_jmeno +"orechu"  ;
         break; }
case 3: {no_jmeno =no_jmeno +"dubu"  ;
         break; }
case 4: {no_jmeno =no_jmeno +"mahagonu" ;
         break; }
case 5: {no_jmeno =no_jmeno +"tisu"  ;
         break; }
case 6: {no_jmeno =no_jmeno +"jilmu"  ;
         break; }
case 7: {no_jmeno =no_jmeno +"zelezneho dubu"  ;
         break; }
case 8: {no_jmeno =no_jmeno +"prastareho dubu"  ;
         break; }

}//konec switche kovu

if ((GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0)&((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp")  || (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si")))
{ no_jmeno = no_jmeno + " bez hlavice" ;  }
else if ((GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0)&((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms")  || (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs")|| (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps")))
{no_jmeno = no_jmeno + " bez nytu" ;  }
else if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0) {
no_jmeno = no_jmeno + " bez tetivy" ;  }



if (GetLocalInt(OBJECT_SELF,"no_kov_luku") != 0)
{no_nazevkovu(GetLocalInt(OBJECT_SELF,"no_kov_luku"));
no_jmeno =( no_jmeno + " s " +  GetLocalString(OBJECT_SELF,"no_nazev_kov")+ " zdobenim" );
                      }


SetName(no_Item,no_jmeno);



//kuciks work :
SetStolenFlag(no_Item,0);
SetPlotFlag(no_Item,0);
int no_iPrice= GetGoldPieceValue(no_Item);
int no_iLevel;
int iRow = 0;
while( StringToInt(Get2DAString("itemvalue","MAXSINGLEITEMVALUE",iRow)) < no_iPrice) {
no_iLevel++;
iRow ++;
}
// Level je vzdy radek + 1;
no_iLevel = no_iLevel+1;

ku_SetItemDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "."+ "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");

//SetDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "."+ "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
//SetLocalString(no_Item,"no_popisek","Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "."+ "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
SetLocalString(no_Item, "no_verze_craftu",no_verzecraftu);
SetPlotFlag(no_Item,1);


//////nastavi description predmetu //////////
string no_jmeno2 = "";
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {no_jmeno = "kratkem luku";
                                                            no_jmeno2 =  "tento kratky luk";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {no_jmeno = "dlouhem luku";
                                                            no_jmeno2 =  "Tento dlouhy luk";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {no_jmeno = "male kusi";
                                                            no_jmeno2 =  "Tuto malou kusi";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {no_jmeno = "velke kusi";
                                                            no_jmeno2 =  "Tuto velkou kusi";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") {no_jmeno = "sipu";
                                                            no_jmeno2 =  "Tyto sipy";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") {no_jmeno = "sipce";
                                                            no_jmeno2 =  "Tyto sipky";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {no_jmeno = "malem stitu";
                                                            no_jmeno2 =  "Tento maly stit";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {no_jmeno = "velkem stitu";
                                                            no_jmeno2 =  "Tento velky stit";   }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {no_jmeno = "paveze";
                                                            no_jmeno2 =  "Tuto pavezu ";   }

//SetDescription(no_Item,"Na tomto" + no_jmeno + " je vyryto: " + no_jmeno2 + " vyrobil " + GetName(no_oPC) + ".");

} //konec udelej jmeno



//////////////////// nastavi cenu vyrobku  /////////////////////////////////////////
void no_cenavyrobku(object no_Item)
{
// no_zjistiobsah(no_Item);
// vetsinou cenu nastavujem az po menu .

int no_cena_kuze = 1;
float no_koeficient = 1.0;
float no_cena_kuzeXX; //kvuli sipum

//kdybychom nemeli kov,tak se napise jen tohleto
switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
case 1: {no_cena_kuze = no_cena_nasa_vrb;      //nahrano z no_ke_inc
         break; }
case 2: {no_cena_kuze = no_cena_nasa_ore;
         break; }
case 3: {no_cena_kuze = no_cena_nasa_dub;
         break; }
case 4: {no_cena_kuze = no_cena_nasa_mah;
         break; }
case 5: {no_cena_kuze = no_cena_nasa_tis;
         break; }
case 6: {no_cena_kuze = no_cena_nasa_jil;
         break; }
case 7: {no_cena_kuze = no_cena_nasa_zel;
         break; }
case 8: {no_cena_kuze = no_cena_nasa_pra;
         break; }

}//konec switche


if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0  ) {

switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
case 1: {no_cena_kuze =no_cena_kuze + no_cena_moridla1;
         break; }
case 2: {no_cena_kuze =no_cena_kuze + no_cena_moridla2;
         break; }
case 3: {no_cena_kuze =no_cena_kuze + no_cena_moridla3;
         break; }
case 4: {no_cena_kuze =no_cena_kuze + no_cena_moridla4;
         break; }
case 5: {no_cena_kuze =no_cena_kuze + no_cena_moridla5;
         break; }
case 6: {no_cena_kuze = no_cena_kuze +no_cena_moridla6;
         break; }
case 7: {no_cena_kuze = no_cena_kuze +no_cena_moridla7;
         break; }
case 8: {no_cena_kuze = no_cena_kuze +no_cena_moridla8;
         break; }
}  //konec switche

switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")){
case 1: {no_cena_kuze =no_cena_kuze + no_cena_tin;
         break; }
case 2: {no_cena_kuze =no_cena_kuze + no_cena_copp;
         break; }
case 3: {no_cena_kuze =no_cena_kuze + no_cena_bron;
         break; }
case 4: {no_cena_kuze =no_cena_kuze + no_cena_iron;
         break; }
case 5: {no_cena_kuze =no_cena_kuze + no_cena_gold;
         break; }
case 6: {no_cena_kuze = no_cena_kuze +no_cena_plat;
         break; }
case 7: {no_cena_kuze = no_cena_kuze +no_cena_mith;
         break; }
case 8: {no_cena_kuze = no_cena_kuze +no_cena_adam;
         break; }
case 9: {no_cena_kuze = no_cena_kuze +no_cena_tita;
         break; }
case 10: {no_cena_kuze = no_cena_kuze +no_cena_silv;
         break; }
case 11: {no_cena_kuze = no_cena_kuze +no_cena_stin;
         break; }
case 12: {no_cena_kuze = no_cena_kuze +no_cena_mete;
         break; }

}  //konec switche

}//if dodelany luk (kovluku>0)

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {no_koeficient = 1.0;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {no_koeficient = 1.005;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {no_koeficient = 1.011;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {no_koeficient = 1.0125; }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") { no_koeficient = 1.0;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") { no_koeficient = 1.012;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") { no_koeficient = 1.01;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") { no_koeficient = 1.012;  }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") { no_koeficient = 1.0125;  }

//////nastavi cenu
SetLocalFloat(no_Item,"tc_cena",(no_tr_nasobitel *1.01*no_cena_kuze * no_koeficient));
if (no_tr_debug == TRUE) SendMessageToPC(no_oPC,"normalni cena: " + IntToString(no_cena_kuze));

//////// u vsech truhlarskych vyrobku se pouziva float na misto int, bo by sipy prisli moc drahe.
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") )
{
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0)    {
        no_cena_kuzeXX = ( no_tr_nasobitel *no_cena_kuze * no_koeficient ) /198;
        } //mame 198 sipek


//if ( (FloatToInt(no_cena_kuze))  < 1)  { no_cena_kuze = 1.0;  }
SetLocalFloat(no_Item,"tc_cena",(no_cena_kuzeXX));
SetLocalInt(no_Item,"tc_cena",0);

        if (no_tr_debug == TRUE) SendMessageToPC(no_oPC,"mame sipky: " + FloatToString(no_cena_kuzeXX));
        if ( FloatToInt(no_cena_kuzeXX*99)<0 ) {
        SetLocalFloat(no_Item,"tc_cena",0.1);
        SetLocalInt(no_Item,"tc_cena",0);
        if (no_tr_debug == TRUE) SendMessageToPC(no_oPC,"mame malou cenu: " + FloatToString(no_cena_kuzeXX));
        }

}

if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs")||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") )
{
switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
case 1: {no_cena_kuze = no_cena_nasa_vrb;      //nahrano z no_ke_inc
         break; }
case 2: {no_cena_kuze = no_cena_nasa_ore;
         break; }
case 3: {no_cena_kuze = no_cena_nasa_dub;
         break; }
case 4: {no_cena_kuze = no_cena_nasa_mah;
         break; }
case 5: {no_cena_kuze = no_cena_nasa_tis;
         break; }
case 6: {no_cena_kuze = no_cena_nasa_jil;
         break; }
case 7: {no_cena_kuze = no_cena_nasa_zel;
         break; }
case 8: {no_cena_kuze = no_cena_nasa_pra;
         break; }

}//konec switche

switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")){
case 1: {no_cena_kuze =no_cena_kuze + no_cena_tin;
         break; }
case 2: {no_cena_kuze =no_cena_kuze + no_cena_copp;
         break; }
case 3: {no_cena_kuze =no_cena_kuze + no_cena_bron;
         break; }
case 4: {no_cena_kuze =no_cena_kuze + no_cena_iron;
         break; }
case 5: {no_cena_kuze =no_cena_kuze + no_cena_gold;
         break; }
case 6: {no_cena_kuze = no_cena_kuze +no_cena_plat;
         break; }
case 7: {no_cena_kuze = no_cena_kuze +no_cena_mith;
         break; }
case 8: {no_cena_kuze = no_cena_kuze +no_cena_adam;
         break; }
case 9: {no_cena_kuze = no_cena_kuze +no_cena_tita;
         break; }
case 10: {no_cena_kuze = no_cena_kuze +no_cena_silv;
         break; }
case 11: {no_cena_kuze = no_cena_kuze +no_cena_stin;
         break; }
case 12: {no_cena_kuze = no_cena_kuze +no_cena_mete;
         break; }

}  //konec switche

switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")){
case 1: {no_cena_kuze =no_cena_kuze + no_cena_nytu1;
         break; }
case 2: {no_cena_kuze =no_cena_kuze + no_cena_nytu2;
         break; }
case 3: {no_cena_kuze =no_cena_kuze + no_cena_nytu3;
         break; }
case 4: {no_cena_kuze =no_cena_kuze + no_cena_nytu4;
         break; }
case 5: {no_cena_kuze =no_cena_kuze + no_cena_nytu5;
         break; }
case 6: {no_cena_kuze = no_cena_kuze +no_cena_nytu6;
         break; }
case 7: {no_cena_kuze = no_cena_kuze +no_cena_nytu7;
         break; }
case 8: {no_cena_kuze = no_cena_kuze +no_cena_nytu8;
         break; }
case 9: {no_cena_kuze = no_cena_kuze +no_cena_nytu9;
         break; }
case 10: {no_cena_kuze = no_cena_kuze +no_cena_nytu10;
         break; }
case 11: {no_cena_kuze = no_cena_kuze +no_cena_nytu11;
         break; }
case 12: {no_cena_kuze = no_cena_kuze +no_cena_nytu12;
         break; }

}  //konec switche

SetLocalFloat(no_Item,"tc_cena",(no_tr_nasobitel *1.01*no_cena_kuze * no_koeficient));
}//if je to stit

if (no_tr_debug == TRUE) SendMessageToPC(no_oPC,"vysledna cena = " + FloatToString(no_cena_kuzeXX));

}   //konec no_udelejcenu

void no_vynikajicikus(object no_Item)
{
int no_random = d100() - TC_getLevel(no_oPC,TC_truhlar);
if (no_random < (TC_dej_vlastnost(TC_truhlar,no_oPC)/4+1) ) {
////sance vroby vyjimecneho kusu stoupa s lvlem craftera
if  (GetIsDM(no_oPC)== TRUE) no_random = no_random -50;//DM maji vetsi sanci vyjimecneho kusu
FloatingTextStringOnCreature("Podarilo se ti vyrobit vyjimecny kus !", no_oPC,TRUE);

no_random = Random(22)+1;

//if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "si") &  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "sp") )
//{
//FloatingTextStringOnCreature("U sipu ci sipek nelze vyrobit vyjimecny kus!", no_oPC,TRUE);
//}// konec sipek, ci sipu

//if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps"))
//{ //mame stity.

switch (no_random)  {
case 1: {
                  //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,3+d4() ),no_Item);
                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_APPRAISE,2),no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Obchodnik'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 100);
                  break;}
case 2: {
                  itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,d2());
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Uzemnovac'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                  break;}
case 3: {
                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_HEAL,2),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Lecitel'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 100);
                  break;}
case 4: {
                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Pevnestuj'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 200);
                  break;}
case 5: {
                  itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,d2());
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Kyselostit'");
                  break;}

case 6: {
                   itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,d2());
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Chladak'");
                  break;}
case 7: {
                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_LORE,2),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Poznavac'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 8: {
                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PERFORM,2),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Barduv stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 9: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Drtikost'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}

case 10: {         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_LISTEN,2),no_Item);
                     SetName(no_Item,GetName(no_Item) + "  'Zvukovy stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 11: {
                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_TAUNT,2),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Silak'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 12: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Vyvolavacuv stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 13: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Ohnivy stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 14: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Protijedovy stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 15: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Strachoprdel'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 16: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Negativni stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 17: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POSITIVE,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Positivni stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 18: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Zvukovy stit'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 19: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Oddalovac smrti'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 20: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,d2() ),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Silna mysl'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 21: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Sila'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}
case 22: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1),no_Item);
                                    SetName(no_Item,GetName(no_Item) + "  'Uhybac'");
                  SetLocalFloat(no_Item,"tc_cena",GetLocalFloat(no_Item,"tc_cena")+ 150);
                  break;}

       }  //konec switche
       //}//if stity

       }//konec if vyjimecna vec se podari


/////////////pokud to bude stit, udelame jinej vzhled.
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") ||  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps"))
{

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") no_random = 10+d20(2);
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") no_random = 20+d100(2);
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") no_random = 20+d100(2);

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
        if ( (( no_random>33) & (no_random <49))  || (( no_random>60) & (no_random <65)) )
        no_random == 15;
}     ///odstrani pruhledne stity
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
        if ( ( no_random>43) & (no_random <50) )
        no_random == 25;
}     ///odstrani pruhledne stity
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
        if ( ( no_random>13) & (no_random <20) )
        no_random == 25;
}     ///odstrani pruhledne stity



object no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_SIMPLE_MODEL,2,no_random,TRUE);


while (GetIsObjectValid(no_Item_modified)==FALSE) {
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") no_random = 10+d20(2);
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") no_random = 20+d100(2);
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") no_random = 20+d100(2);


if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
        if ( (( no_random>33) & (no_random <49))  || (( no_random>60) & (no_random <65)) )
        no_random == 15;
}     ///odstrani pruhledne stity
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
        if ( ( no_random>43) & (no_random <50) )
        no_random == 25;
}     ///odstrani pruhledne stity
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
        if ( ( no_random>13) & (no_random <20) )
        no_random == 25;
}     ///odstrani pruhledne stity

no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_SIMPLE_MODEL,1,no_random,TRUE);
}

ku_SetItemDescription(no_Item_modified, GetDescription(no_Item));

DestroyObject(no_Item);
}

//////////////////////////////////

}//konec veci navic



//////////kratkej luk//////////
void no_krluk(object no_pec)
{
     //zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_01",no_oPC,1,"no_tr_kr_01_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);

                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 2:   {
               //orech + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_02",no_oPC,1,"no_tr_kr_02_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 3:   {
               //dub + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_03",no_oPC,1,"no_tr_kr_03_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                                 }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_04",no_oPC,1,"no_tr_kr_04_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 5:   {
               //tis + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_05",no_oPC,1,"no_tr_kr_05_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                  break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_luku
               no_Item=CreateItemOnObject("no_tr_kr_06",no_oPC,1,"no_tr_kr_06_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 7:   {
               //zelezny dub+ + no_kov_krluku
               no_Item=CreateItemOnObject("no_tr_kr_07",no_oPC,1,"no_tr_kr_07_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_krluku
               no_Item=CreateItemOnObject("no_tr_kr_08",no_oPC,1,"no_tr_kr_08_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          }//konec switche
}//////////koniec no_krluk//////////



//////////dlouhy luk//////////
void no_dlluk(object no_pec )
{
     //zarizeni do int no_pouzita_kuze  no_prvnisutr no_druhysutr no_pocetsutru no_druh_vyrobku
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_dlouheholuku
               no_Item=CreateItemOnObject("no_tr_dl_01",no_oPC,1,"no_tr_dl_01_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);

                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 2:   {
               //orech + no_kov_dlouhyluku
               no_Item=CreateItemOnObject("no_tr_dl_02",no_oPC,1,"no_tr_dl_02_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 3:   {
               //dub + no_kov_dlouhyluku
               no_Item=CreateItemOnObject("no_tr_dl_03",no_oPC,1,"no_tr_dl_03_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                                 }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_dlouhyluku
               no_Item=CreateItemOnObject("no_tr_dl_04",no_oPC,1,"no_tr_dl_04_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 5:   {
               //tis + no_kov_dlouhyluku
               no_Item=CreateItemOnObject("no_tr_dl_05",no_oPC,1,"no_tr_dl_05_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                  break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_dlouheholuku
               no_Item=CreateItemOnObject("no_tr_dl_06",no_oPC,1,"no_tr_dl_06_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 7:   {
               //zelezny dub+ + no_kov_dlouhyluk
               no_Item=CreateItemOnObject("no_tr_dl_07",no_oPC,1,"no_tr_dl_07_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_dlouhyluk
               no_Item=CreateItemOnObject("no_tr_dl_08",no_oPC,1,"no_tr_dl_08_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          }//konec switche
}//////////koniec no_dlluk//////////



//////////mala kus//////////
void no_mlkus(object no_pec )
{
     //zarizeni do int no_pouzita_kuze  no_prvnisutr no_druhysutr no_pocetsutru no_druh_vyrobku
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_01",no_oPC,1,"no_tr_mk_01_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 2:   {
               //orech + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_02",no_oPC,1,"no_tr_mk_02_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 3:   {
               //dub + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_03",no_oPC,1,"no_tr_mk_03_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                                 }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_04",no_oPC,1,"no_tr_mk_04_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 5:   {
               //tis + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_05",no_oPC,1,"no_tr_mk_05_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                  break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_06",no_oPC,1,"no_tr_mk_06_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 7:   {
               //zelezny dub+ + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_07",no_oPC,1,"no_tr_mk_07_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_malakus
               no_Item=CreateItemOnObject("no_tr_mk_08",no_oPC,1,"no_tr_mk_08_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          }//konec switche
}//////////koniec no_mlkus//////////



//////////velka kus//////////
void no_vlkus(object no_pec )
{
     // zarizeni do int no_pouzita_kuze  no_prvnisutr no_druhysutr no_pocetsutru no_druh_vyrobku
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_01",no_oPC,1,"no_tr_vk_01_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 2:   {
               //orech + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_02",no_oPC,1,"no_tr_vk_02_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 3:   {
               //dub + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_03",no_oPC,1,"no_tr_vk_03_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 2:  {
                                 break;  }
                    case 3:  {
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(1),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                                 }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_04",no_oPC,1,"no_tr_vk_04_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 6:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(2),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 5:   {
               //tis + no_kov_velekkuse
               no_Item=CreateItemOnObject("no_tr_vk_05",no_oPC,1,"no_tr_vk_05_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackPenalty(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(d2()),no_Item);
                                 break;  }
                    case 4:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                break;  }
                    case 6:  {
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(3),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                  break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_06",no_oPC,1,"no_tr_vk_06_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(4),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 7:   {
               //zelezny dub+ + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_07",no_oPC,1,"no_tr_vk_07_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_7),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(5),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(7),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(7),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(7),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(7),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_velkekuse
               no_Item=CreateItemOnObject("no_tr_vk_08",no_oPC,1,"no_tr_vk_08_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(1+d2()),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_9),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(6),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(7),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(8),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(8),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(3+d2()),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAttackBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(8),no_Item);
                                 break;  }
                    }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
     }//konec switche
}//////////koniec no_vlkus//////////



//////////sipy//////////
void no_sipy(object no_pec )
{
     //zarizeni do int no_druh_vyrobku, no_pouzite_drevo, no_kov_luku
     string sZkratkaTyp = "si";
     int iDrevo = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
     int iKov = GetLocalInt(OBJECT_SELF,"no_kov_luku");
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_sipu
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_7");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_5");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_3");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 2:   {
               //orech + no_kov_sipu
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_6");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_4");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_2");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_1");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_1");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_1");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_1");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_1");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_2");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 3:   {
               //dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_4");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_3");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_1");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_2");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_2");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_2");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_2");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_2");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_1d4");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_2");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_4");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_2");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_3");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_3");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_3");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_3");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_3");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_stun_14");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_1d6");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_2");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_3");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 5:   {
               //tis + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_3");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_1");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_1");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_1d4");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_1d4");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_1d4");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_1d4");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_1d4");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_stun_16");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_1d8");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_3");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d6");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_2");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_0");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_2");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_1d8");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_1d8");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_1d8");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_1d8");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_1d8");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_stun_20");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_1d10");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d6");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d8");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 7:   {
               //zelezny dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgp_1");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_3");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_4");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_1d10");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_1d10");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_1d10");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_1d10");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_1d10");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_stun_22");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_1d12");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d8");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d10");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_def_2");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_4");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgb_6");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_dmgbpi_1d12");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_acid_1d12");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_cold_1d12");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_elec_1d12");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_fire_1d12");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_stun_24");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_divund_2d8");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d10");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipy",no_oPC,1,"toulec_bow_magic_1d12");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
     }//konec switche
}//////////konec sipy//////////



//////////sipky//////////
void no_sipky(object no_pec )
{
     //zarizeni do int no_druh_vyrobku, no_pouzite_drevo, no_kov_luku
     string sZkratkaTyp = "sp";
     int iDrevo = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
     int iKov = GetLocalInt(OBJECT_SELF,"no_kov_luku");
     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")){
          case 1:   {
               //vrba + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_5");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_4");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_3");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 2:   {
               //orech + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_5");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_4");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_2");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_1");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_1");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_1");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_1");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_1");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_2");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 3:   {
               //dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_4");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_3");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_1");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_2");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_2");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_2");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_2");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_2");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_1d4");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_2");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_4");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_2");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_3");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_3");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_3");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_3");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_3");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_stun_14");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_1d6");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_2");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_3");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 5:   {
               //tis + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_3");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_1");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_1");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_1d6");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_1d6");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_1d6");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_1d6");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_1d6");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_stun_18");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_1d10");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_3");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d6");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_2");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_0");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_3");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_1d8");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_1d8");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_1d8");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_1d8");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_1d8");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_stun_20");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_1d12");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d6");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d8");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 7:   {
               //zelezny dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgp_1");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_3");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_4");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_1d10");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_1d10");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_1d10");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_1d10");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_1d10");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_stun_22");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_1d12");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d8");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d10");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                    case 1:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_def_2");
                                 break;  }
                    case 2:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_4");
                                 break;  }
                    case 3:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgb_6");
                                 break;  }
                    case 4:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_dmgbpi_1d12");
                                 break;  }
                    case 5:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_acid_1d12");
                                 break;  }
                    case 6:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_cold_1d12");
                                 break;  }
                    case 7:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_elec_1d12");
                                 break;  }
                    case 8:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_fire_1d12");
                                 break;  }
                    case 9:  {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_stun_26");
                                 break;  }
                    case 10: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_divund_2d8");
                                 break;  }
                    case 11: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d10");
                                 break;  }
                    case 12: {   no_Item=CreateItemOnObject("shjy_zaklad_sipk",no_oPC,1,"toulec_cro_magic_1d12");
                                 break;  }
               }//konec vnitrniho switche
               SetToulecName(no_Item, sZkratkaTyp, iDrevo, iKov);
               no_cenavyrobku(no_Item);
               AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),no_Item);
               break; }
     }//konec switche
}//////////konec sipky//////////



//////////stity 6. dubna edit Karolina//////////
void no_stit(object no_pec, int no_druh_stitu)
{
     if ( no_druh_stitu==1 ) {
        no_Item=CreateItemOnObject("no_tr_ms",no_oPC,1,"no_tr_ms"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
     }
     if ( no_druh_stitu==2 ) {
        no_Item=CreateItemOnObject("no_tr_vs",no_oPC,1,"no_tr_vs"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
     }
     if ( no_druh_stitu==3 ) {
        no_Item=CreateItemOnObject("no_tr_ps",no_oPC,1,"no_tr_ps"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_" + GetLocalString(OBJECT_SELF,"no_kov_luku"));
     }

     switch (GetLocalInt(OBJECT_SELF,"no_pouzite_drevo")) {
          //case podla no_pouzite_drevo
          case 1:  {
               //vrba + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14),no_Item);
                                  break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);

                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS),no_Item);

                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }

          case 2:   {
               //orech + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_5_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);

                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }

          case 3:   {
               //dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_10_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);

                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 4:   {
               //mahagon + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_15_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);

                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 5:   {
               //tis + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_15_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 6:   {
               //jilm + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 break;  }
                    case 4:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_20),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_15_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,8),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                  break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 7:   {
               //zelezny dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 4:  {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 break;  }
                    case 5:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_20),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,6),no_Item);
                                break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,5),no_Item);
                                break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
          case 8:   {
               //prastary dub + no_kov_luku
               switch (GetLocalInt(OBJECT_SELF,"no_kov_luku")) {
                   case 1:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,2),no_Item);
                                 break;  }
                    case 2:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_SHIELD,1),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2),no_Item);
                                 break;  }
                    case 3:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
                                 break;  }
                    case 4:  {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,3),no_Item);
                                 break;  }
                    case 5:  {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_25),no_Item);
                                break;  }
                    case 6:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24),no_Item);
                                 break;  }
                    case 7:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                 break;  }
                    case 8:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,3),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_30_LBS),no_Item);
                                 break;  }
                    case 9:  {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,6),no_Item);
                                 break;  }
                    case 10: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,5),no_Item);
                                 break;  }
                    case 11: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                 break;  }
                    case 12: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(5),no_Item);
                                 AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                 break;  }
               }//konec vnitrniho switche
               no_udelejjmeno(no_Item);
               no_cenavyrobku(no_Item);
               no_vynikajicikus(no_Item);
               break; }
     }//konec switche
}//kones no_stit









/////////zacatek zavadeni funkci//////////////////////////////////////////////
void no_snizstack(object no_Item, int no_mazani)
{
int no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                           if (no_mazani == TRUE) DestroyObject(no_Item);

                    }
    else   {  if (no_mazani == TRUE) { //DestroyObject(no_Item);
              //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
              SetItemStackSize(no_Item,no_stacksize-1);
              } }
}


//////////////////////////////////////////////////////////////////////
//////////zacatek zjistovani co je vevnitr////////////////////////////
/////////////////////////////////////////////////////////////////////
void no_pouzitykov(object no_Item, object no_pec, int no_mazani)
{no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetResRef(no_Item),7) == "tc_prut"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetResRef(no_Item) == "tc_prut1")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_pouzitykov",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_prut2")
    { SetLocalInt(no_pec,"no_pouzitykov",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_prut3")
    { SetLocalInt(no_pec,"no_pouzitykov",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut4")
    { SetLocalInt(no_pec,"no_pouzitykov",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut11")
    { SetLocalInt(no_pec,"no_pouzitykov",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut8")
    { SetLocalInt(no_pec,"no_pouzitykov",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut7")
    { SetLocalInt(no_pec,"no_pouzitykov",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut5")
    { SetLocalInt(no_pec,"no_pouzitykov",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut10")
    { SetLocalInt(no_pec,"no_pouzitykov",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut9")
    { SetLocalInt(no_pec,"no_pouzitykov",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut12")
    { SetLocalInt(no_pec,"no_pouzitykov",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_prut13")
    { SetLocalInt(no_pec,"no_pouzitykov",12);
    no_snizstack(no_Item,no_mazani);
    break;      }

  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame kov
}



void no_drevo(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_drevo      cislo urci drevo
//////
////////////////////////////////////////////


{      // do no_moridlo ulozi cislo moridla
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

                              // pro luky budem brat late
                              // pro kuse berem brat desky
   if(GetStringLeft(GetResRef(no_Item),6) == "tc_lat")     {
//////////////kdyz jo, tak je to lat/////////////////////////////////////////
     if(GetResRef(no_Item) == "tc_lat_vrb")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_drevo",1);
    no_snizstack(no_Item,no_mazani);                           //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_lat_ore")
    { SetLocalInt(no_pec,"no_drevo",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_lat_dub")
    { SetLocalInt(no_pec,"no_drevo",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_lat_mah")
    { SetLocalInt(no_pec,"no_drevo",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_lat_tis")
    { SetLocalInt(no_pec,"no_drevo",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_lat_jil")
    { SetLocalInt(no_pec,"no_drevo",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_lat_zel")
    { SetLocalInt(no_pec,"no_drevo",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_lat_pra")
    { SetLocalInt(no_pec,"no_drevo",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }
/////////////kdyz je to lat////////////////
   if(GetStringLeft(GetResRef(no_Item),7) == "tc_desk")     {

//////////////kdyz jo, tak je to lat/////////////////////////////////////////
     if(GetResRef(no_Item) == "tc_desk_vrb")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_drevo",11);
    no_snizstack(no_Item,no_mazani);                           //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_desk_ore")
    { SetLocalInt(no_pec,"no_drevo",12);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_desk_dub")
    { SetLocalInt(no_pec,"no_drevo",13);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_desk_mah")
    { SetLocalInt(no_pec,"no_drevo",14);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_desk_tis")
    { SetLocalInt(no_pec,"no_drevo",15);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_desk_jil")
    { SetLocalInt(no_pec,"no_drevo",16);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_desk_zel")
    { SetLocalInt(no_pec,"no_drevo",17);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_desk_pra")
    { SetLocalInt(no_pec,"no_drevo",18);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }

  no_Item = GetNextItemInInventory(no_pec);
  }  //tak uz osekane drevo
}


void no_tetiva(object no_Item, object no_pec, int no_mazani)
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetTag(no_Item),11) == "no_tr_teti_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_tr_teti_01")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_tetiva",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_tr_teti_02")
    { SetLocalInt(no_pec,"no_tetiva",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_tr_teti_03")
    { SetLocalInt(no_pec,"no_tetiva",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_teti_04")
    { SetLocalInt(no_pec,"no_tetiva",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_teti_05")
    { SetLocalInt(no_pec,"no_tetiva",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_teti_06")
    { SetLocalInt(no_pec,"no_tetiva",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_teti_07")
    { SetLocalInt(no_pec,"no_tetiva",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_teti_08")
    { SetLocalInt(no_pec,"no_tetiva",8);
    no_snizstack(no_Item,no_mazani);
    break;      }

  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame tetivu
}


void no_peri(object no_Item, object no_pec, int no_mazani)
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetTag(no_Item),11) == "no_tr_peri_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_tr_peri_01")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_peri",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_tr_peri_02")
    { SetLocalInt(no_pec,"no_peri",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_tr_peri_03")
    { SetLocalInt(no_pec,"no_peri",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_peri_04")
    { SetLocalInt(no_pec,"no_peri",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_peri_05")
    { SetLocalInt(no_pec,"no_peri",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_peri_06")
    { SetLocalInt(no_pec,"no_peri",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_peri_07")
    { SetLocalInt(no_pec,"no_peri",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_peri_08")
    { SetLocalInt(no_pec,"no_peri",8);
    no_snizstack(no_Item,no_mazani);
    break;      }

  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame peri
}


void no_nyty(object no_Item, object no_pec, int no_mazani)
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetTag(no_Item),11) == "no_tr_nyty_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_tr_nyty_01")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_nyty",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_tr_nyty_02")
    { SetLocalInt(no_pec,"no_nyty",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_tr_nyty_03")
    { SetLocalInt(no_pec,"no_nyty",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_nyty_04")
    { SetLocalInt(no_pec,"no_nyty",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_nyty_05")
    { SetLocalInt(no_pec,"no_nyty",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_nyty_06")
    { SetLocalInt(no_pec,"no_nyty",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_nyty_07")
    { SetLocalInt(no_pec,"no_nyty",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_tr_nyty_08")
    { SetLocalInt(no_pec,"no_nyty",8);
    no_snizstack(no_Item,no_mazani);
    break;      }

                   if(GetTag(no_Item) == "no_tr_nyty_09")
    { SetLocalInt(no_pec,"no_nyty",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetTag(no_Item) == "no_tr_nyty_10")
    { SetLocalInt(no_pec,"no_nyty",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetTag(no_Item) == "no_tr_nyty_11")
    { SetLocalInt(no_pec,"no_nyty",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetTag(no_Item) == "no_tr_nyty_12")
    { SetLocalInt(no_pec,"no_nyty",12);
    no_snizstack(no_Item,no_mazani);
    break;      }

  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame nyty
}

void no_vyrobek (object no_Item, object no_pec, int no_mazani)
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
{no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if((GetStringLeft(GetResRef(no_Item),6) == "no_tr_")& (GetStringLeft(GetResRef(no_Item),10) != "no_tr_teti")& (GetStringLeft(GetResRef(no_Item),10) != "no_tr_peri")& (GetStringLeft(GetResRef(no_Item),10) != "no_tr_nyty"))
{
 //vsechny vyrobky z siti takhle zacinaji, kdyz by to nahodou byla nejaka blbost, tak
 // stejne to z tagu nepujde poznat, co by to bylo a nejak se to kousne.
 // bohuzel sem zapomel, ze tetiva a peri ma take tag no_tr_
    SetLocalString(OBJECT_SELF,"no_vyrobek",GetTag(no_Item));  // ulozime tag veci!!
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;    //  }
  }  //konec if resref no_si_
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame sperk
}





////////z kovariny prevzate preotevreni pece s upravami  ////////////////////////////////////////
void no_reopen(object no_oPC)
{
AssignCommand(no_oPC,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE));
//   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));
}


////////Znici tlacitka z inventare ///////////////////////
void no_znicit(object no_oPC)
{
no_Item = GetFirstItemInInventory(no_oPC);

 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac001") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 001
 }
 DestroyObject(no_Item);
 no_Item = GetNextItemInInventory(no_oPC);
}

no_Item = GetFirstItemInInventory(no_oPC);
 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac003") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 003
 }
 DestroyObject(no_Item);
 no_Item = GetNextItemInInventory(no_oPC);
}
}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);

AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_tr_delay));
    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_tr_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_tr_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));

PlaySound("as_cv_sawing1");
}


void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item)
//////////////prida procenta nehotovym vrobkum/////////////////////////////////
{string no_tag_vyrobku = GetTag(no_Item);

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_truhlar);}

 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
         string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

DestroyObject(no_Item);

no_Item = CreateItemOnObject("no_polot_tr",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
no_udelejjmeno(no_Item);
SetName(no_Item,GetName(no_Item) + "  *"+ no_nazev_procenta + "%*");
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_tr_clos_vec",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si vyrobu" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }


}


///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_tr (object no_oPC, object no_pec)
{
int no_druh=0;
int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
int no_level = TC_getLevel(no_oPC,TC_truhlar);  // TC truhlar = 32
if  (GetIsDM(no_oPC)== TRUE) no_level=no_level+20;

no_Item = GetFirstItemInInventory(no_pec);
while (GetIsObjectValid(no_Item)) {

if  (GetResRef(no_Item) == "no_polot_tr")
{
no_zjistiobsah(GetTag(no_Item));
/// davam to radsi uz sem, bo se pak i podle toho nastavuje cena..
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

/////////////////////////kratky luk//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 10 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 10 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  kratky luk - konec  //////////////////////////////////////////////////////////////////////

/////////////////////////dlouhy luk//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 12 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 12 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  dlouhy luk - konec  //////////////////////////////////////////////////////////////////////

////////////////////////mala kus//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 14 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 14 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  mala kus - konec  //////////////////////////////////////////////////////////////////////

///////////////////////// velka kus//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 16 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 16 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  velka kus - konec  //////////////////////////////////////////////////////////////////////

///////////////////////// sipy//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 1 +  5*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 1 + 6* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 5* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  sipy - konec  //////////////////////////////////////////////////////////////////////

///////////////////////// sipky//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 1 +  5*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 1 + 6* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 5* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  sipky - konec  //////////////////////////////////////////////////////////////////////

///////////////////////// mnaly stit//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 6 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 8 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}//// maly stit - konec  //////////////////////////////////////////////////////////////////////

///////////////////////// velky stit//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 8 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 10 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  velky stit- konec  //////////////////////////////////////////////////////////////////////

///////////////////////// paveza//////////////////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
      /// mame boty bez sutru
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") == 0 ) {
            no_druh = GetLocalInt(OBJECT_SELF,"no_pouzite_drevo");
            no_DC = 16 +  8*GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") -( 10*no_level );
            break; }
      /// mame boty s 1 sutrem
      if (GetLocalInt(OBJECT_SELF,"no_kov_luku") > 0 ) {
            no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_pouzite_drevo") + GetLocalString(OBJECT_SELF,"no_kov_luku"));
            no_DC = 14 + 11* GetLocalInt(OBJECT_SELF,"no_pouzite_drevo") + 8* GetLocalInt(OBJECT_SELF,"no_kov_luku") -( 10*no_level );
            break; }
}////  paveza - konec  //////////////////////////////////////////////////////////////////////






    }//pokud resref = no_polot_si      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//SendMessageToPC(no_oPC,"no_druh=" + IntToString(no_druh));
if (no_druh>0 ) {
//obtiznost kovu -5*lvlu

////6brezen/////
if  (GetLocalFloat(no_Item,"no_suse_proc")==0.0) SetLocalFloat(no_Item,"no_suse_proc",10.0);

// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
//SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();
//SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
if (no_hod <= no_chance ) {

         float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");
        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
                         TC_setXPbyDifficulty(no_oPC,TC_truhlar,no_chance,TC_dej_vlastnost(TC_truhlar,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_truhlar,no_chance,TC_dej_vlastnost(TC_truhlar,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
        //no_procenta = no_procenta + 5+ d20() + no_level ;  // = 12-45

    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

/*            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta + 0.1 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta + 0.2 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta + Random(4)/10.0 ;}
           else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta + Random(6)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.1;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.2;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.3;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.5;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.0;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.5;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.0;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.5;}
            else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.0;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.5;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta + Random(20)/10.0+ 4.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta + Random(20)/10.0 +4.5;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta + Random(20)/10.0 +5.0;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta + Random(20)/10.0 + 5.5;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta+ Random(20)/10.0 +6.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}*/

            no_procenta = no_procenta + (TC_getProgressByDifficulty(no_obtiznost_vyrobku) / 10.0);

                          if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;
                          if (no_tr_debug == TRUE   )  no_procenta = no_procenta + 50.0;


        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej
        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek

 DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek budou boty: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_kr_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_kr_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00" );
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if ((no_druh > 100)& (no_druh < 1216 ) )
    {    no_krluk(no_pec);    }
 }//////////////////konec kratky luk///////////////////////////////

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek budou rukavice: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_dl_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_dl_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))
    {    no_dlluk(no_pec);    }
    }////////////konec dlouhy luk

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek budou chranice: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_mk_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_mk_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if ((no_druh > 100) & (no_druh < 1216 ))
    {    no_mlkus(no_pec);    }
}//////////////////konec mala kus///////////////////////////////

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude opasek: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_vk_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_vk_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {    no_vlkus(no_pec);    }
}//////////////////konec velka kus///////////////////////////////

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude sip /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_si_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_si_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {    no_sipy(no_pec);
         }
}//////////////////konec sip///////////////////////////////

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude sipka: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_sp_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo"),no_oPC,1,"no_tr_sp_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {    no_sipky(no_pec);
         }
}//////////////////konec sipka///////////////////////////////

////////////////////////maly stit////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude sipka: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_ms",no_oPC,1,"no_tr_ms_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,10),no_Item);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR,5),no_Item);

    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {
         no_stit(no_pec,1);
         }
}//////////////////konec maly stit///////////////////////////////
////////////////////////velky stit////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude velky stit: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_vs",no_oPC,1,"no_tr_vs_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,10),no_Item);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR,5),no_Item);

    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {
         no_stit(no_pec,2);
         }
}//////////////////konec velky stit///////////////////////////////

////////////////////////paveza////////////////////////////////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
/////////////////vyrobek bude paveza: /////////////////////
    if (no_druh < 10) {
    no_Item=CreateItemOnObject("no_tr_ps",no_oPC,1,"no_tr_ps_"+ GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_00");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,10),no_Item);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR,5),no_Item);

    no_udelejjmeno(no_Item);
    no_cenavyrobku(no_Item);   }
    /////////////prvni sutr //////////////////////////////////////////////
    else if((no_druh > 100) & (no_druh < 1216 ))  //101-615 = legendarni s smaragdem
    {
         no_stit(no_pec,3);
         }
}//////////////////konec maly stit///////////////////////////////




                }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej
        no_vytvorprocenta(no_oPC,no_procenta,no_Item);
          }// kdyz neni 100%
        SendMessageToPC(no_oPC,"===================================");

       } /// konec, kdyz sme byli uspesni

else if (no_hod > no_chance )  {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////
    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta - 0.2 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta - 0.3 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta - Random(6)/10.0 ;}
            else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta - Random(8)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.3;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.4;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.5;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.9;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta - Random(20)/10.0 -1.5;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta - Random(20)/10.0 -2.0;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.1;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.5;}
           else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.5;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.8;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta - Random(20)/10.0- 6.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta - Random(20)/10.0 -6.6;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta- Random(20)/10.0 -7.5;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta - Random(20)/10.0 - 7.8;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta- Random(20)/10.0 -9.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta - Random(20)/10.0 -15.0;}

         if (no_procenta <= 0.0 ){
         DestroyObject(no_Item);

 DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
         FloatingTextStringOnCreature("Drevo se rozpadlo",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Na dreve se objevila prasklina",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu
if (no_procenta > 0.0 ) {
    no_vytvorprocenta(no_oPC,no_procenta,no_Item);
          }// kdyz neni 100%



         }//konec else

         }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_dr




void no_xp_pridej_tetivu(object no_oPC, object no_pec)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
no_zjistiobsah(GetLocalString(no_pec,"no_vyrobek"));
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

string no_tag = IntToString(GetLocalInt(no_pec,"no_pouzitykov")); // tam je ulozene cislo pridavaneho kamene
int no_delkastring = GetStringLength(no_tag);

if (no_delkastring ==1) {no_tag =  "0" + no_tag; }
if (no_delkastring ==2) {no_tag = no_tag;} // ulozi nam to string nazev kamene.

if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp" ) || (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si" ))  {
        if (GetLocalInt(no_pec,"no_pouzite_drevo") != GetLocalInt(no_pec,"no_peri") )
        {FloatingTextStringOnCreature("Toto nejsou spravne ingredience!",no_oPC,FALSE ); }
  }///if sip, nebo sipy

if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "sp" ) & (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "si" )& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "ms" )& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "vs" )& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") != "ps" ))  {
        if (GetLocalInt(no_pec,"no_pouzite_drevo") != GetLocalInt(no_pec,"no_tetiva") )
        {FloatingTextStringOnCreature("Toto nejsou spravne ingredience!",no_oPC,FALSE ); }
  }///if sip, nebo sipy

if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms" ) || (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs" )|| (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps" ))  {
if (GetLocalInt(no_pec,"no_pouzitykov")!=GetLocalInt(no_pec,"no_nyty"))    {
       FloatingTextStringOnCreature("Toto nejsou spravne ingredience!",no_oPC,FALSE );
        }
}


if (GetLocalInt(no_pec,"no_pouzite_drevo")==GetLocalInt(no_pec,"no_tetiva"))
{ ///////mame stejny lepidlo i kuzi, sutr mame urcite, bo: no_si_bot_onclose //////////////////////////

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_tetiva(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tento luk je jiz dokoncen",no_oPC,FALSE );  }
    } // konec if kratky luk
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_tetiva(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tento luk je jiz dokoncen",no_oPC,FALSE );  }
    } // konec if dlouhy luk

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "mk") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_tetiva(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tato kus je jiz dokoncena",no_oPC,FALSE );  }
    } // konec if mala kus

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_tetiva(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tato kus je jiz dokoncena",no_oPC,FALSE );  }
    } // konec if kratky luk
}// if stejne lepidlo jak kuze.


if (GetLocalInt(no_pec,"no_pouzite_drevo")==GetLocalInt(no_pec,"no_peri"))    {

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "si") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_peri(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tyto sipy jsou jiz dokonceny",no_oPC,FALSE );  }
    } // konec if sip

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sp") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_peri(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tyto sipky jsou jiz dokonceny",no_oPC,FALSE );  }
    } // konec if sip

        }//if mame peri

//////////////////stity 23 brezen ///////////////
if (GetLocalInt(no_pec,"no_pouzitykov")==GetLocalInt(no_pec,"no_nyty"))    {

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ms") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_nyty(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tento maly stit je jiz dokoncen",no_oPC,FALSE );  }
    } // konec if sip

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vs") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_nyty(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tento velky stit je jiz dokoncen",no_oPC,FALSE );  }
    } // konec if sip

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ps") {
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
        if (GetLocalInt(OBJECT_SELF,"no_kov_luku")==0)
        {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_" + GetLocalString(OBJECT_SELF,"no_pouzite_drevo")+ "_"  + no_tag);
        no_xp_tr(no_oPC,no_pec);
        no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
        no_nyty(no_Item,OBJECT_SELF,TRUE);
        no_vyrobek(no_Item,OBJECT_SELF,TRUE);
        }
        else if( GetLocalInt(OBJECT_SELF,"no_kov_luku")!=0)
              { FloatingTextStringOnCreature("Tato paveza je jiz dokoncena",no_oPC,FALSE );  }
    } // konec if sip

        }//if mame peri




} // konec no_xp_pridej tetivu

void no_xp_krluk(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
if  (GetLocalInt(OBJECT_SELF,"no_drevo")>10)
 { FloatingTextStringOnCreature("na kratky luk bude lepsi pouzit lat",no_oPC,FALSE );  }

switch (GetLocalInt(OBJECT_SELF,"no_drevo")) {
                             case 1:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_01_00");
                             no_xp_tr(no_oPC,no_pec);
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             break; }
                             case 2:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_02_00");
                             no_xp_tr(no_oPC,no_pec);
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             break; }
                             case 3:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 4:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 5:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 6:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 7:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 8:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_kr_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }
} // konec no_xp_boty


void no_xp_dlluk(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")>10)
 { FloatingTextStringOnCreature("na dlouhy luk bude lepsi pouzit lat",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
switch (GetLocalInt(OBJECT_SELF,"no_drevo")) {
                             case 1:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 2:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 3:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 4:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 5:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 6:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 7:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 8:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_dl_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }

        }
}

void no_xp_mlkus(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")<10)
 { FloatingTextStringOnCreature("na malou kusi bude lepsi pouzit desku",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
switch (GetLocalInt(OBJECT_SELF,"no_drevo")) {
                             case 11:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 12:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 13:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 14:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 15:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 16:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 17:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 18:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_mk_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }

        }
}

void no_xp_vlkus(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")<10)
 { FloatingTextStringOnCreature("na velkou kusi bude lepsi pouzit desku",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
switch (GetLocalInt(OBJECT_SELF,"no_drevo")) {
                             case 11:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 12:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 13:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 14:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 15:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 16:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 17:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 18:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vk_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }
 }
void no_xp_sipy(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")>10)
 { FloatingTextStringOnCreature("na sipy bude lepsi pouzit lat",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
switch (GetLocalInt(OBJECT_SELF,"no_drevo")) {
                             case 1:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 2:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 3:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 4:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 5:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 6:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 7:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 8:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_si_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }
}
void no_xp_sipky(object no_oPC, object no_pec, int no_druh_kuze)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")>10)
 { FloatingTextStringOnCreature("na sipky bude lepsi pouzit lat",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
    switch (no_druh_kuze) { //no_druh_kuze= druh dreva pouziteho
                             case 1:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 2:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 3:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 4:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 5:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 6:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 7:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 8:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_sp_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }
}

void no_xp_stit(object no_oPC, object no_pec, int no_druh_kuze, int no_druh_stitu)
// vytvori polotovar
{
if  (GetLocalInt(OBJECT_SELF,"no_drevo")<10)
 { FloatingTextStringOnCreature("na stity bude lepsi pouzit desku",no_oPC,FALSE );  }
//int no_level = TC_getLevel(no_oPC,TC_truhlar);
if (no_druh_stitu == 1) {
switch (no_druh_kuze) {
                             case 11:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 12:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 13:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 14:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 15:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 16:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 17:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 18:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ms_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }//konec case
        }//konec, pokud se jedna o maly stit

if (no_druh_stitu == 2) {
switch (no_druh_kuze) {
                             case 11:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 12:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 13:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 14:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 15:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 16:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 17:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 18:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_vs_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }//konec case
        }//konec, pokud se jedna o velky stit

if (no_druh_stitu == 3) {
switch (no_druh_kuze) {
                             case 11:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_01_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 12:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_02_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 13:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_03_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 14:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_04_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 15:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_05_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 16:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_06_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 17:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_07_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
                             case 18:   {CreateItemOnObject("no_polot_tr",no_pec,1,"no_tr_ps_08_00");
                             no_drevo(no_Item,OBJECT_SELF,TRUE);//true = smazu veci
                             no_xp_tr(no_oPC,no_pec);
                             break; }
        }//konec case
        }//konec, pokud se jedna o maly stit
}


