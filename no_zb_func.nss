#include "ku_libtime"
//#include "no_zb_inc"
#include "tc_xpsystem_inc"
//#include "no_sl_inc"
//#include "no_ke_inc"
//#include "no_dr_inc"
#include "no_nastcraft_ini"
#include "ku_items_inc"
#include "tc_functions"

#include "ku_persist_inc"

/////////////////////////////////////
///  dela vsemozne sici vyrobky s tagama:
///
//podle tagu veci zjisti kolik teho je, jejich cislo a ulozi je na :
// zarizeni do int no_kov_1  no_kov_2 no_kov_procenta no_druh_vyrobku no_druh_nasada
///
/////////////////////////////////

int no_pocet;
string no_nazev;
int no_DC;
int no_bonus_vylepseni;
int jy_kritik; //sèítavá kritický bonus k dmg, aby vïaka nemu na konci vyhodnotil, aký presne prida ako vlastnos predmetu
int no_max_bonus; //urci, do jake kategorie zbran patri - 1 jednoruc , 2 jednoruc velka, 3 obouruc
int no_magicky_bonus;
int no_secny_bonus;
int no_bodny_bonus;

void no_zjistiobsah(string no_tagveci);
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

void  no_udelejjmeno(object no_Item);
// podle no:zjistisutry udela celkocej nazec predmetu.

void no_cenavyrobku(object no_Item);
// nastavi cenu vyrobku

//void no_nazevsutru(int kamen1,int kamen2);
//udela na OBJECT_SELF no_nazevsutru  string s nazvem


void no_vynikajicikus(object no_Item);
// prida nahodne neco dobreho, kdyz bude vynikajici vyrobek !

// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_kov_co_pridavam, int no_kov_pridame_procenta );

//zkusi nejak zmenit vzhled.
void no_udelej_vzhled(object no_Item);

void no_udelejzbran(object no_pec);
//udela vyrobek + mu udeli vlastnosti podle pouzitych prisad


void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_pouzitykov(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_pouzitykov
void no_forma(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_drevo
void no_prisada(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_tetiva
void no_nasada(object no_Item,object no_pec, int no_mazani);
// napise pekne na pec cislo nasady.
void no_vyrobek (object no_Item, object no_pec, int no_mazani);
// nastavi promennou no_sperk

///////////////funkce pro ovladani zarizeni//////////////////////////////

void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare
void no_reknimat(object no_oPC);
// rekne kolik procent je jakeho materialu
void no_zamkni(object no_oPC);
// zamkne a pak odemkne + prehrava animacku

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item);
//pridava procenta k vyrobkum, bo se nam to tam moc pletlo, + to bylo 2krat


//pomaha pridavat % polotovaru, kdyztak predava hotovvej vyrobek, pridava xpy..
void no_xp_zb (object no_oPC, object no_pec);

// prida jakemukoliv polotovaru nasadu, ktera je zrovna hozeny do kovadliny
void no_xp_pridej_nasadu(object no_oPC, object no_pec);

//vyrobi polotovar se vsemi nutnymi tagy apod.
void no_xp_vyrobpolotovar(object no_oPC, object no_pec);

void no_vzhled_zbrane(object no_oPC,int meneny_model,int meneny_index, int zmena);

void no_vzhled_puvo(object no_oPC);

void no_vzhled_zapa(object no_oPC);

void no_visual(object no_oPC, int no_grafika);


//////////////////////////////////////////////////////////////////////////////////////////
void no_pohybklikacu(object no_oPC, object no_pec);

/////////zacatek zavadeni funkci//////////////////////////////////////////////

void no_zjistiobsah(string no_tagveci)
//podle tagu veci zjisti kolik teho je, jejich cislo a ulozi je na :
// zarizeni do int no_kov_1  no_kov_2 no_kov_procenta no_druh_vyrobku no_druh_nasada
{

string no_pouzitavec="";

SetLocalInt(OBJECT_SELF,"no_kov_1",0);
SetLocalString(OBJECT_SELF,"no_kov_1","");
SetLocalInt(OBJECT_SELF,"no_kov_2",0);
SetLocalString(OBJECT_SELF,"no_kov_2","");
SetLocalInt(OBJECT_SELF,"no_kov_procenta",0);
SetLocalString(OBJECT_SELF,"no_kov_procenta","");
SetLocalInt(OBJECT_SELF,"no_druh_nasada",0);
SetLocalString(OBJECT_SELF,"no_druh_nasada","");
SetLocalInt(OBJECT_SELF,"no_druh_vyrobku",0);
SetLocalString(OBJECT_SELF,"no_druh_vyrobku","");

                               ///no_zb_XX_01_02_03_4
                               ///01 - no_kov_1  02-no_kov_procenta  03-no_kov_2  4-no_druh_nasada
string no_druh_vyrobku = GetStringLeft(no_tagveci,8);
// budem do nej ukaladat co to ma za tip
no_druh_vyrobku = GetStringRight(no_druh_vyrobku,2);

SetLocalString(OBJECT_SELF,"no_druh_vyrobku",no_druh_vyrobku);

/////zjistime pouzity kov1/////////////
no_pouzitavec = GetStringLeft(no_tagveci,11);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_kov_1",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_kov_1",(StringToInt(no_pouzitavec)));

/////zjistime pouzita procenta/////////////
no_pouzitavec = GetStringLeft(no_tagveci,14);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_kov_procenta",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_kov_procenta",(StringToInt(no_pouzitavec)));

/////zjistime pouzity kov 2/////////////
no_pouzitavec = GetStringLeft(no_tagveci,17);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_kov_2",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_kov_2",(StringToInt(no_pouzitavec)));

/////zjistime pouzitou nasadu/////////////
no_pouzitavec = GetStringLeft(no_tagveci,19);
no_pouzitavec = GetStringRight(no_pouzitavec,1);
SetLocalString(OBJECT_SELF,"no_druh_nasada",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_druh_nasada",(StringToInt(no_pouzitavec)));


SetLocalInt(OBJECT_SELF,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_kov_1")); // tam je ulozene cislo pridavaneho kamene
SetLocalInt(OBJECT_SELF,"no_ve_mat",GetLocalInt(OBJECT_SELF,"no_kov_2"));
SetLocalInt(OBJECT_SELF,"no_hl_proc",GetLocalInt(OBJECT_SELF,"no_kov_procenta"));


}////////konec no_zjisti_obsah



/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////udela jmeno celkoveho vyrobku at uz to je cokoliv///////////////////////////////
void  no_udelejjmeno(object no_Item)
{
no_zjistiobsah(GetTag(no_Item)); // prptoze pro meno to vetsinou potrebujem prenastavit.
string no_jmeno = "";


if   (GetLocalInt(OBJECT_SELF,"no_kov_1") != GetLocalInt(OBJECT_SELF,"no_kov_2")) {
switch (GetLocalInt(OBJECT_SELF,"no_kov_1"))  {
case 1: { no_jmeno = "Cino-";
            break;    }
case 2: { no_jmeno = "Medeno-";
            break;    }
case 3: { no_jmeno = "Vermajlovo-";
            break;    }
case 4: { no_jmeno = "Zelezo-";
            break;    }
case 5: { no_jmeno = "Zlato-";
            break;    }
case 6: { no_jmeno = "Platino-";
            break;    }
case 7: { no_jmeno = "Mithrilo-";
            break;    }
case 8: { no_jmeno = "Adamtino-";
            break;    }
case 9: { no_jmeno = "Titano-";
            break;    }
case 10: { no_jmeno = "Stribro-";
            break;    }
case 11: { no_jmeno = "Stino-";
            break;    }
case 12: { no_jmeno = "Meteoriticko-";
            break;    }
}//konec switche
  }//kdyz nemame stejne kovy ve slitine

switch (GetLocalInt(OBJECT_SELF,"no_kov_2"))  {
case 1: { no_jmeno = no_jmeno +"Cinov";
            break;    }
case 2: { no_jmeno = no_jmeno +"Meden";
            break;    }
case 3: { no_jmeno = no_jmeno +"Vermajlov";
            break;    }
case 4: { no_jmeno = no_jmeno +"Zelezn";
            break;    }
case 5: { no_jmeno = no_jmeno +"Zlat";
            break;    }
case 6: { no_jmeno = no_jmeno +"Platinov";
            break;    }
case 7: { no_jmeno = no_jmeno +"Mithrilov";
            break;    }
case 8: { no_jmeno = no_jmeno +"Adamtinov";
            break;    }
case 9: { no_jmeno = no_jmeno +"Titanov";
            break;    }
case 10: { no_jmeno =no_jmeno + "Stribrn";
            break;    }
case 11: { no_jmeno =no_jmeno + "Stinov";
            break;    }
case 12: { no_jmeno = no_jmeno +"Meteoritick";
            break;    }
}// kdyz mame stejny kov, nebo druhy kov, tak je to stejnej nazev.


if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") no_jmeno = no_jmeno + "y dlouhy mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dy") no_jmeno = no_jmeno + "a dyka";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_jmeno = no_jmeno +"y kratky mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ba") no_jmeno = no_jmeno +"y bastard";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vm") no_jmeno = no_jmeno +"y velky mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ka") no_jmeno = no_jmeno +"a katana";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ra") no_jmeno = no_jmeno +"y rapir";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sc") no_jmeno = no_jmeno +"y scimitar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ha") no_jmeno = no_jmeno +"a halapartna";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ko") no_jmeno = no_jmeno +"e kopi";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ks") no_jmeno = no_jmeno +"a kosa";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tr") no_jmeno = no_jmeno +"y trojzubec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bc") no_jmeno = no_jmeno +"y okovany bic";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "km") no_jmeno = no_jmeno +"a kama";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ku") no_jmeno = no_jmeno +"e kukri";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sr") no_jmeno = no_jmeno +"y srp";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ds") no_jmeno = no_jmeno +"a dvojsecna sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dm") no_jmeno = no_jmeno +"y oboustranny mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dp") no_jmeno = no_jmeno +"y straslivy palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "os") no_jmeno = no_jmeno +"a vela sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "rs") no_jmeno = no_jmeno +"a rucni sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ts") no_jmeno = no_jmeno +"a trpaslici sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bs") no_jmeno = no_jmeno +"a bitevni sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lc") no_jmeno = no_jmeno + "y lehky cep";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tc") no_jmeno = no_jmeno +"y tezky cep";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lk") no_jmeno = no_jmeno +"e lehke kladivo";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") no_jmeno = no_jmeno +"e valecne kladivo";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kj") no_jmeno = no_jmeno +"y kyj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pa") no_jmeno = no_jmeno + "y palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "re") no_jmeno = no_jmeno +"y remdih";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ma") no_jmeno = no_jmeno +"e obri kladivo";
// 25.12.2009
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hu") no_jmeno = no_jmeno +"a hul";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x2") no_jmeno = no_jmeno +"e sai";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x3") no_jmeno = no_jmeno +"y obourucni falchion";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x4") no_jmeno = no_jmeno +"y katar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x5") no_jmeno = no_jmeno +"e nunchaku";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x6") no_jmeno = no_jmeno +"e sap";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x7") no_jmeno = no_jmeno +"y obourucni scimitar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x8") no_jmeno = no_jmeno +"y tezky palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y1") no_jmeno = no_jmeno +"y rtutovy obri mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y2") no_jmeno = no_jmeno +"y rtutovy dlouhy mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y3") no_jmeno = no_jmeno +"y mauguv oboustrany mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ss") no_jmeno = no_jmeno +"e jednorucni kopi";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hp") no_jmeno = no_jmeno +"y krumpac";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lp") no_jmeno = no_jmeno +"y lehky krumpac";

switch (GetLocalInt(OBJECT_SELF,"no_druh_nasada")){
case 0: {  no_jmeno = no_jmeno + " bez rukojeti ";
        break;}
case 1: {no_jmeno =no_jmeno +" s vrbovou rukojeti"   ;
         break; }
case 2: {no_jmeno =no_jmeno +" s orechovou rukojeti"  ;
         break; }
case 3: {no_jmeno =no_jmeno +" s dubovou rukojeti"  ;
         break; }
case 4: {no_jmeno =no_jmeno +" s mahagonovou rukojeti" ;
         break; }
case 5: {no_jmeno =no_jmeno +" s tisovou rukojeti"  ;
         break; }
case 6: {no_jmeno =no_jmeno +" s jilmovou rukojeti"  ;
         break; }
case 7: {no_jmeno =no_jmeno +" s rukojeti ze zelezneho dubu"  ;
         break; }
case 8: {no_jmeno =no_jmeno +" s rukojeti z prastareho dubu"  ;
         break; }
}//konec switche kovu


SetName(no_Item,no_jmeno);


//////nastavi description predmetu //////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") no_jmeno ="tento Dlouhy mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dy") no_jmeno ="tuto Dyku";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_jmeno = "tento Kratky mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ba") no_jmeno = "tento Bastard";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vm") no_jmeno ="tento Velky mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ka") no_jmeno = "tato Katana";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ra") no_jmeno = "tento Rapir";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sc") no_jmeno = "tento Scimitar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ha") no_jmeno = "tato Halapartna";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ko") no_jmeno = "toto Kopi";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ks") no_jmeno = "tato Kosa";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tr") no_jmeno = "tento Trojzubec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bc") no_jmeno = "tento Okovany bic";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "km") no_jmeno = "tato Kama";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ku") no_jmeno = "toto Kukri";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sr") no_jmeno ="tento Srp";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ds") no_jmeno = "tato Dvojsecna sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dm") no_jmeno = "tento Oboustranny mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dp") no_jmeno = "tento Straslivy palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "os") no_jmeno = "tato Vela sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "rs") no_jmeno = "tato Rucni sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ts") no_jmeno = "tato Trpaslici sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bs") no_jmeno = "tato Bitevni sekera";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lc") no_jmeno = "tento Lehky cep";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tc") no_jmeno = "tento Tezky cep";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lk") no_jmeno = "toto Lehke kladivo";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") no_jmeno = "toto Valecne kladivo";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kj") no_jmeno = "tento Kyj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pa") no_jmeno ="tento Palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "re") no_jmeno = "tento Remdih";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ma") no_jmeno = "toto Obri kladivo";
//25.12.2009
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hu") no_jmeno = "tuto hul";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x2") no_jmeno = "tento sai";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x3") no_jmeno = "tento obourucni falchion";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x4") no_jmeno = "tento katar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x5") no_jmeno = "tyto nunchaki";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x6") no_jmeno = "tento sap";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x7") no_jmeno = "tento obourucni scimitar";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x8") no_jmeno = "tento tezky palcat";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y1") no_jmeno = "tento rtutovy velky mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y2") no_jmeno = "tento rtutovy dlouhy mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y3") no_jmeno = "tento muguv dvojity mec";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ss") no_jmeno = "toto jednorucni kopi";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hp") no_jmeno = "tento krumpac";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lp") no_jmeno = "tento lehky krumpac";


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

} //konec udelej jmeno



//////////////////// nastavi cenu vyrobku  /////////////////////////////////////////
void no_cenavyrobku(object no_Item)
{
no_zjistiobsah(GetTag(no_Item));
// vetsinou cenu nastavujem az po menu .

int no_cena_kuze = 1;
int no_cena_kuze2 = 1;
int no_cena_kuze3 = 1;
int no_cena_kuze4 = 1;
float no_koeficient = 1.0;


//1kov
switch (GetLocalInt(OBJECT_SELF,"no_kov_1")){
case 1: {no_cena_kuze = no_cena_tin;    //nahrano z no_sl_inc
         break; }
case 2: {no_cena_kuze = no_cena_copp;
         break; }
case 3: {no_cena_kuze = no_cena_bron;
         break; }
case 4: {no_cena_kuze = no_cena_iron;
         break; }
case 5: {no_cena_kuze = no_cena_gold;
         break; }
case 6: {no_cena_kuze = no_cena_plat;
         break; }
case 7: {no_cena_kuze = no_cena_mith;
         break; }
case 8: {no_cena_kuze = no_cena_adam;
         break; }
case 9: {no_cena_kuze = no_cena_tita;
         break; }
case 10: {no_cena_kuze = no_cena_silv;
         break; }
case 11: {no_cena_kuze = no_cena_stin;
         break; }
case 12: {no_cena_kuze = no_cena_mete;
         break; }
}//konec switche

//2 kov
switch (GetLocalInt(OBJECT_SELF,"no_kov_2")){
case 1: {no_cena_kuze2 = no_cena_tin;    //nahrano z no_sl_inc
         break; }
case 2: {no_cena_kuze2 = no_cena_copp;
         break; }
case 3: {no_cena_kuze2 = no_cena_bron;
         break; }
case 4: {no_cena_kuze2 = no_cena_iron;
         break; }
case 5: {no_cena_kuze2 = no_cena_gold;
         break; }
case 6: {no_cena_kuze2 = no_cena_plat;
         break; }
case 7: {no_cena_kuze2 = no_cena_mith;
         break; }
case 8: {no_cena_kuze2 = no_cena_adam;
         break; }
case 9: {no_cena_kuze2 = no_cena_tita;
         break; }
case 10: {no_cena_kuze2 = no_cena_silv;
         break; }
case 11: {no_cena_kuze2 = no_cena_stin;
         break; }
case 12: {no_cena_kuze2 = no_cena_mete;
         break; }
}  //konec switche



if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") {no_koeficient = 1.005;
                                                            no_cena_kuze=no_cena_kuze + no_cena_mala;} //no:_ke_inc
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dy") {no_koeficient = 1.00;
                                                                no_cena_kuze=no_cena_kuze + no_cena_mala;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ba") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vm") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ka") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_zahn;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ra") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_zahn;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sc") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_zahn;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ha") {no_koeficient = 1.006;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ko") {no_koeficient = 1.0035;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ks") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tr") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bc") {no_koeficient = 1.003;
                                                                no_cena_kuze=no_cena_kuze + no_cena_mala;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "km") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_mala;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ku") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_mala;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sr") {no_koeficient = 1.003;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ds") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dm") {no_koeficient = 1.0125;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dp") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_mala;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "os") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "rs") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ts") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bs") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lc") {no_koeficient = 1.0035;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tc") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lk") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") {no_koeficient = 1.006;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kj") {no_koeficient = 1.001;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pa") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "re") {no_koeficient = 1.006;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ma") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
//25.12.2009//
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hu") {no_koeficient = 1.007;
                                                               no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x2") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x3") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x4") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x5") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x6") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x7") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x8") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y1") {no_koeficient = 1.006;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y2") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y3") {no_koeficient = 1.008;
                                                                no_cena_kuze=no_cena_kuze + no_cena_velk;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ss") {no_koeficient = 1.007;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hp") {no_koeficient = 1.005;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lp") {no_koeficient = 1.004;
                                                                no_cena_kuze=no_cena_kuze + no_cena_stre;}
if ( GetLocalInt(OBJECT_SELF,"no_druh_nasada") !=0  ) {

switch (GetLocalInt(OBJECT_SELF,"no_druh_nasada")){
                case 1: {no_cena_kuze3 = no_cena_nasa_vrb;
                break; }
                case 2: {no_cena_kuze3 = no_cena_nasa_ore;
                break; }
                case 3: {no_cena_kuze3 = no_cena_nasa_dub;
                break; }
                case 4: {no_cena_kuze3 = no_cena_nasa_mah;
                break; }
                case 5: {no_cena_kuze3 = no_cena_nasa_tis;
                break; }
                case 6: {no_cena_kuze3 = no_cena_nasa_jil;
                break; }
                case 7: {no_cena_kuze3 = no_cena_nasa_zel;
                break; }
                case 8: {no_cena_kuze3 = no_cena_nasa_pra;
                break; }
                }// konec switche
} //konec kdyz mame nasadu

int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
int no_menu_max_procent = 10;
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl

int no_material_prisady =  GetLocalInt(OBJECT_SELF,"no_hl_mat");
if ( GetLocalInt(OBJECT_SELF,"no_kov_procenta")< no_menu_max_procent/2 ) {
no_material_prisady =  GetLocalInt(OBJECT_SELF,"no_ve_mat");
if (NO_zb_DEBUG == TRUE) SendMessageToPC(no_oPC, "Jako prisadu sme pozivali vedl.kov, takze od ni odvodime cenu.");
}

switch (no_material_prisady){
case 1: {no_cena_kuze4 = no_cena_zb_prisada1;
         break; }
case 2: {no_cena_kuze4 = no_cena_zb_prisada2;
         break; }
case 3: {no_cena_kuze4 = no_cena_zb_prisada3;
         break; }
case 4: {no_cena_kuze4 = no_cena_zb_prisada4;
         break; }
case 5: {no_cena_kuze4 = no_cena_zb_prisada5;
         break; }
case 6: {no_cena_kuze4 = no_cena_zb_prisada6;
         break; }
case 7: {no_cena_kuze4 = no_cena_zb_prisada7;
         break; }
case 8: {no_cena_kuze4 = no_cena_zb_prisada8;
         break; }
case 9: {no_cena_kuze4 = no_cena_zb_prisada9;
         break; }
case 10: {no_cena_kuze4 = no_cena_zb_prisada10;
         break; }
case 11: {no_cena_kuze4 = no_cena_zb_prisada11;
         break; }
case 12: {no_cena_kuze4 = no_cena_zb_prisada12;
         break; }
}  //switch podle prisady

/////////20%zisk jako vzdy/////////////////
if ( GetLocalInt(OBJECT_SELF,"no_druh_nasada") ==0  ) {
SetLocalInt(no_Item,"tc_cena",FloatToInt (no_koeficient*no_zb_nasobitel2*(1.0*no_cena_kuze + 1.0*no_cena_kuze2) ));
}
if ( GetLocalInt(OBJECT_SELF,"no_druh_nasada") !=0  ) {
SetLocalInt(no_Item,"tc_cena",FloatToInt(no_koeficient* no_zb_nasobitel*(1.01*no_cena_kuze+1.01*no_cena_kuze2+ 1.01*no_cena_kuze3+no_cena_kuze4) ));
}

if (NO_zb_DEBUG == TRUE) {SendMessageToPC (no_oPC,"nastavena cena :" + IntToString(GetLocalInt(no_Item,"tc_cena")) ); }

}   //konec no_udelejcenu



void no_vynikajicikus(object no_Item)
{
int no_random = d100() - TC_getLevel(no_oPC,TC_kovar);
if (no_random < (TC_dej_vlastnost(TC_kovar,no_oPC)/4+1) ) {
////sance vroby vyjimecneho kusu stoupa s lvlem craftera
if  (GetIsDM(no_oPC)== TRUE) no_random = no_random -50;//DM maji vetsi sanci vyjimecneho kusu
FloatingTextStringOnCreature("Podarilo se ti vyrobit vyjimecny kus !", no_oPC,TRUE);

no_random = Random(30)+1;

switch (no_random)  {
case 1: {
                    itemproperty no_ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Skretodrv'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                    break;}
case 2: {
                  itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,d2());
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),no_Item);
                SetName(no_Item,GetName(no_Item) + "  'Mrazilka'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 3: {
                    itemproperty no_ip = ItemPropertyACBonusVsSAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,1);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Neutralizer'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 4: {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,d2());
               AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
               SetName(no_Item,GetName(no_Item) + "  'Kyselinac'");
               SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 5: {
                  itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                   SetName(no_Item,GetName(no_Item) + "  'Zhouba obru'");
                   SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 130);
                   break;}
case 6: {
                  itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Pichlavec'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case 7: {
                   itemproperty no_ip =ItemPropertySkillBonus(SKILL_SPOT,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Lepsi oko'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 8: {
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nezlomna vule'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case  9: {
                itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,d2());
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                 SetName(no_Item,GetName(no_Item) + "  'Uzemnovac'");
                SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 10:  {
                itemproperty no_ip =ItemPropertySkillBonus(SKILL_HIDE,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Schovka'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case  11:  {
                itemproperty no_ip =ItemPropertySkillBonus(SKILL_APPRAISE,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Vyjednavac'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 12:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba elementalu'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 13:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELF,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba elfu'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 14:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMAN,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba lidi'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 15:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HALFLING,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba pulciku'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 16:  {
                 itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_2);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Sekac'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 17:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_HOLY),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba zlounu'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 18:  {
                itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Rychlovka'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 19:  {
               itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Horici'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                   break;}
case 20:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba vlkodlaku'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 21:  {
                   itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Vlastenec'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 22:  {         itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_HOLY),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nicitel zlaku'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 23:  {               itemproperty no_ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Drakobijec'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 1500);
                   break;}
case 24:  {
                itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Ocelova hlava'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 150);
                   break;}
case 25:  {
                itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,d4());
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
               SetName(no_Item,GetName(no_Item) + "  'Zemnitel'");
               SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 150);
                   break;}
case 26:  {
               itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,d4());
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
               SetName(no_Item,GetName(no_Item) + "  'Nebojsa'");
                SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 250);
                   break;}
case 27:  {
                   itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,d4());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                SetName(no_Item,GetName(no_Item) + "  'Nezlomna mysl'");
               SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 250);
                   break;}
case 28:  {
                 itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_NEUTRAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_HOLY),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Neutralizator'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case 29:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_SONIC),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nicitel chaosu'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case 30:  {
                 itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_EVIL),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nicitel dobra'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}


         }//konec switche


       }//konec if vyjimecna vec se podari

}//konec veci navic

// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_kov_co_pridavam, int no_kov_pridame_procenta )
{
//int no_max_bonus; //urci, do jake kategorie zbran patri - 1 jednoruc , 2 jednoruc velka, 3 obouruc
//int no_magicky_bonus;
//int no_secny_bonus;
//int no_bodny_bonus;
switch   (no_kov_co_pridavam){

        case 1:  {  switch (no_kov_pridame_procenta) {
             //cin
                        case 2: {
                                    break;  }
                        case 4: { no_bonus_vylepseni = no_bonus_vylepseni -7;
                                    break;  }
                        case 6: { no_bonus_vylepseni = no_bonus_vylepseni -6;
                                    break;  }
                        case 8: { no_bonus_vylepseni = no_bonus_vylepseni -6;
                                    break;  }
                        case 10: { no_bonus_vylepseni = no_bonus_vylepseni -5;
                                    break;  }
                        case 12: { no_bonus_vylepseni = no_bonus_vylepseni -5;
                                    break;  }
                        case 14: { no_bonus_vylepseni = no_bonus_vylepseni -4;
                                    break;  }
                        case 16: { no_bonus_vylepseni = no_bonus_vylepseni -4;
                                    break;  }
                        case 18: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                    break;  }
                        case 20: { no_bonus_vylepseni = no_bonus_vylepseni -2;
                                    break;  }

                        } //konec vnitrniho switche
               break;     }//konec cinu
        case 2:  {  switch (no_kov_pridame_procenta) {
             //med
                        case 2: {
                                    break;  }
                        case 4: {
                                    break;  }
                        case 6: {   no_bonus_vylepseni = no_bonus_vylepseni -5;
                                    break;  }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni -5;
                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni -5;
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni -4;
                                    break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni -3;
                                    break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni -2;
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni -1;
                                    break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }

                        } //konec vnitrniho switche
               break;     }//konec medi
        case 3:  {  switch (no_kov_pridame_procenta) {
             //vermajl
                        case 2: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                    break;  }
                        case 4: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,2),no_Item);
                                    break;  }
                        case 6: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                    break;  }
                        case 8: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,4),no_Item);
                                    break;  }
                        case 10: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                    break;  }
                        case 12: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,6),no_Item);
                                    break;  }
                        case 14: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,8),no_Item);
                                    break;  }
                        case 16: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,8),no_Item);
                                    break;  }
                        case 18: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),no_Item);
                                    break;  }
                        case 20: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_PARRY,10),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec vermajl
        case 4:  {  switch (no_kov_pridame_procenta) {
             //zelezo
                        case 2: {   break;  }
                        case 4: {   break;  }
                        case 6: {   break;  }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    if (no_max_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    if (no_max_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                break;    }//konec zeleza
        case 5:  {  switch (no_kov_pridame_procenta) {
             //zlato
                        case 2: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,1),no_Item);
                                    break;  }
                        case 4: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,2),no_Item);
                                    break;  }
                        case 6: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,3),no_Item);
                                    break; }
                        case 8: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,3),no_Item);
                                    break;  }
                        case 10: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,4),no_Item);
                                    break;  }
                        case 12: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,4),no_Item);
                                    break;  }
                        case 14: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,5),no_Item);
                                    break;  }
                        case 16: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,5),no_Item);
                                    break;  }
                        case 18: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,6),no_Item);
                                    break;  }
                        case 20: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,6),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec zlata
        case 6:  {  switch (no_kov_pridame_procenta) {
             //platina
                        case 2: {  if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                   break;  }
                        case 4: {  if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                   break;  }
                        case 6: {  if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                   break; }
                        case 8: {  if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                   break;  }
                        case 10: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +1;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +2;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +3;
                                   break;  }
                        case 12: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +1;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +2;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +3;
                                   break;  }
                        case 14: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +2;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +3;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +4;
                                   break;  }
                        case 16: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +2;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +3;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +4;
                                   break;  }
                        case 18: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +3;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +4;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +5;
                                   break;  }
                        case 20: { if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +3;
                                   if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +4;
                                   if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +5;
                                   break;  }
                        } //konec vnitrniho switche
               break;     }//konec platiny
        case 7:  {  switch (no_kov_pridame_procenta) {
             //mithril
                        case 2: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    break;  }
                        case 4: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    break;  }
                        case 6: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break; }
                        case 8: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 10: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 12: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 14: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 16: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 18: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 20: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec mithril
        case 8:  {  switch (no_kov_pridame_procenta) {
             //adamantit
                        case 2: {
                                    break;  }
                        case 4: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 6: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break; }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    if (no_max_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    if (no_max_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    if (no_max_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    if (no_max_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    if (no_max_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec adamantinu
        case 9:  {  switch (no_kov_pridame_procenta) {
             //titan
                        case 2: {   jy_kritik = jy_kritik +1;
                                    break;  }
                        case 4: {   jy_kritik = jy_kritik +2;
                                    break;  }
                        case 6: {   jy_kritik = jy_kritik +3;
                                    break; }
                        case 8: {   jy_kritik = jy_kritik +4;
                                    break;  }
                        case 10: {  jy_kritik = jy_kritik +5;
                                    break;  }
                        case 12: {  jy_kritik = jy_kritik +6;
                                    break;  }
                        case 14: {  jy_kritik = jy_kritik +7;
                                    break;  }
                        case 16: {  jy_kritik = jy_kritik +9;
                                    break;  }
                        case 18: {  jy_kritik = jy_kritik +10;
                                    break;  }
                        case 20: {  jy_kritik = jy_kritik +11;
                                    break;  }
                        } //konec vnitrniho switche
               break; }//konec titanu
        case 10:  {  switch (no_kov_pridame_procenta) {
             //stribro
                        case 2: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,1),no_Item);
                                   break;  }
                        case 4: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,2),no_Item);
                                    break;  }
                        case 6: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,3),no_Item);
                                    break; }
                        case 8: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,3),no_Item);
                                    break;  }
                        case 10: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,4),no_Item);
                                    break;  }
                        case 12: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,4),no_Item);
                                    break;  }
                        case 14: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,5),no_Item);
                                    break;  }
                        case 16: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,5),no_Item);
                                    break;  }
                        case 18: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,6),no_Item);
                                    break;  }
                        case 20: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,6),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                break;    }//konec stribra
        case 11:  {  switch (no_kov_pridame_procenta) {
             //stinova ocel
                        case 2: {
                                    break;  }
                        case 4: {
                                    break;  }
                        case 6: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break; }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    //jy_kritik = jy_kritik +1;
                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    //jy_kritik = jy_kritik +1;
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    //jy_kritik = jy_kritik +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                    break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    //jy_kritik = jy_kritik +2;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                    break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    //jy_kritik = jy_kritik +2;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    //jy_kritik = jy_kritik +3;
                                    if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                   break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    //jy_kritik = jy_kritik +3;
                                    if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +3;
                                   break;  }
                        } //konec vnitrniho switche
                break;    }//konec stinove oceli
        case 12:  {  switch (no_kov_pridame_procenta) {
             //meteoricka ocel
                        case 2: {   //no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 4: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    //jy_kritik = jy_kritik +1;
                                    break;  }
                        case 6: {   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    //jy_kritik = jy_kritik +1;
                                    break; }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    //jy_kritik = jy_kritik +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    //jy_kritik = jy_kritik +2;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +1;
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    //jy_kritik = jy_kritik +2;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                    break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    //jy_kritik = jy_kritik +3;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +2;
                                    break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    //jy_kritik = jy_kritik +3;
                                    if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +3;
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    //jy_kritik = jy_kritik +4;
                                    if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +0;
                                    if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +3;
                                    break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +5;
                                    //jy_kritik = jy_kritik +4;
                                    if (no_max_bonus==1) no_magicky_bonus = no_magicky_bonus +1;
                                    if (no_max_bonus==2) no_magicky_bonus = no_magicky_bonus +2;
                                    if (no_max_bonus==3) no_magicky_bonus = no_magicky_bonus +4;
                                    break;  }
                        } //konec vnitrniho switche
                break;    }//konec meteoriticke oceli



}// switch no_kov_pridame_procenta


} //konec pridavani vlastnosti


void no_udelej_vzhled(object no_Item)
{
// Creates a new copy of an item, while making a single change to the appearance of the item.
// Helmet models and simple items ignore iIndex.
// iType                            iIndex                      iNewValue
// ITEM_APPR_TYPE_SIMPLE_MODEL      [Ignored]                   Model #
// ITEM_APPR_TYPE_WEAPON_COLOR      ITEM_APPR_WEAPON_COLOR_*    1-4
// ITEM_APPR_TYPE_WEAPON_MODEL      ITEM_APPR_WEAPON_MODEL_*    Model #
// ITEM_APPR_TYPE_ARMOR_MODEL       ITEM_APPR_ARMOR_MODEL_*     Model #
// ITEM_APPR_TYPE_ARMOR_COLOR       ITEM_APPR_ARMOR_COLOR_*     0-175
//object CopyItemAndModify(object oItem, int nType, int nIndex, int nNewValue, int bCopyVars=FALSE)
DestroyObject(no_Item);
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "km")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ks")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "tr")&  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bc")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "sr")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ds") & (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "dm") & (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ku")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ma")& (GetStringLeft(GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),1)!= "x")& (GetStringLeft(GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),1)!= "y")   )
{
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,d4(),TRUE));
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_MODEL_BOTTOM,d4(),TRUE));
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,d4(),TRUE));
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_MODEL_MIDDLE,d4(),TRUE));
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,d4(),TRUE));
DestroyObject(no_Item = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_MODEL_TOP,d4(),TRUE));
}
no_Item = CopyItem(no_Item,no_oPC,TRUE);
no_udelejjmeno(no_Item);
no_vynikajicikus(no_Item);
}


void no_udelejzbran(object no_pec)
{
if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Vyrabim zbran" );

///no_zb_XX_01_02_03_4
///01 - no_kov_1  02-no_kov_procenta  03-no_kov_2  4-no_druh_nasada

//int no_max_bonus; //urci, do jake kategorie zbran patri - 1 jednoruc , 2 jednoruc velka, 3 obouruc
//////nastavi description predmetu //////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dy") no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr")   no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ba")   no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vm")   no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ka")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ra")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sc")   no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ha")     no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ko")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ks")     no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tr")      no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bc")  no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "km")      no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ku")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sr")      no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ds")  no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dm")  no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dp")  no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "os")      no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "rs")    no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ts")  no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bs")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lc")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tc")      no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lk")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk")    no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kj")    no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pa")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "re")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ma")     no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hu")     no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x2")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x3")    no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x4")    no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x5")     no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x6")  no_max_bonus = 1;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x7") no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x8")      no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y1")  no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y2")  no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y3")   no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ss")   no_max_bonus = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hp")   no_max_bonus = 3;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lp")   no_max_bonus = 1;

if ( no_max_bonus ==1 ) {
switch (d2()){
case 1: FloatingTextStringOnCreature("Juj, co to je? to je louskacek na orechy ? " ,no_oPC,FALSE);
case 2: FloatingTextStringOnCreature("No tohle? to se sikovne vejde do kapsy ! " ,no_oPC,FALSE);
}
}

 if ( no_max_bonus ==2 ) {
switch (d2()){
case 1: FloatingTextStringOnCreature("No, na dve ruky lehka, na jednu tak akorat !" ,no_oPC,FALSE);
case 2: FloatingTextStringOnCreature("No ke stitu se to bude celkem hodit. " ,no_oPC,FALSE);
}
}

if ( no_max_bonus ==3 ) {
switch (d2()){
case 1: FloatingTextStringOnCreature("no tak na tohel aby pulcikum narostli dalsi dve ruce ! " ,no_oPC,FALSE);
case 2: FloatingTextStringOnCreature("No to je aspon poradnej kus zbrane. To bude drtit hlava nehlava ! " ,no_oPC,FALSE);
}
}

int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
int no_menu_max_procent = 10;
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
if (GetLocalInt(no_pec,"no_kov_1")  == GetLocalInt(no_pec,"no_kov_2") )
{
SetLocalInt(no_pec,"no_kov_procenta",no_menu_max_procent);
if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame kov1=kov2, nastavuju max. pocet %" );
}

if (GetLocalInt(no_pec,"no_kov_procenta")  == no_menu_max_procent )
{
SetLocalInt(no_pec,"no_kov_2",GetLocalInt(no_pec,"no_kov_1"));
if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame max.procent,at to nemate, nastavuju kov2, na hodnotu kov1" );
}

no_bonus_vylepseni = 0;
jy_kritik = 0;

///vyrobime zbran no_Item na OVJECT:SELF, protoze ji zmodifikujem a az pak dame hraci..
no_Item=CreateItemOnObject("no_zb_" + GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),OBJECT_SELF,1,"no_zb_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_procenta")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_druh_nasada") );

// do tohohle budem ukladat, jak se meni enchentamnet bonus a pridame ho tam az na konci.

// pridavame podle kovu procenta.
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_kov_1"),GetLocalInt(no_pec,"no_kov_procenta") );

//kdyz neni druhy jako prvni material, tak udelame maxprocenta-hl.mat.procenta vlastnosti.
if  (GetLocalInt(no_pec,"no_kov_procenta")  != no_menu_max_procent )  {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_kov_2"),no_menu_max_procent - GetLocalInt(no_pec,"no_kov_procenta") );
}

switch ( GetLocalInt(OBJECT_SELF,"no_druh_nasada")) {
case 1: {   if ( no_bonus_vylepseni >0 ){
              no_bonus_vylepseni = 0;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet" ,no_oPC,FALSE);   }
            break;}
case 2: {   if ( no_bonus_vylepseni >1 ){
              no_bonus_vylepseni = 1;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni <0 )&(no_max_bonus ==3 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );
            }
            break;}
case 3: {   if ( no_bonus_vylepseni >2 ){
              no_bonus_vylepseni = 2;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni <1 )&(no_max_bonus >1 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 4: {   if ( no_bonus_vylepseni >3 ){
              no_bonus_vylepseni = 3;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet" ,no_oPC,FALSE);   }
            if (( no_bonus_vylepseni <2 )&(no_max_bonus >0 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 5: {   if ( no_bonus_vylepseni >3 ){
              no_bonus_vylepseni = 3;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet" ,no_oPC,FALSE);   }
            if (( no_bonus_vylepseni <2 )&(no_max_bonus >0 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 6: {   if ( no_bonus_vylepseni >3 ){
              no_bonus_vylepseni = 3;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni <1 )&(no_max_bonus >2 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_2),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni ==2 )&(no_max_bonus >1 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 7: {   if ( no_bonus_vylepseni >4 ){
              no_bonus_vylepseni = 4;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni <2 )&(no_max_bonus >2 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_2),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni ==3 )&(no_max_bonus >1 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 8: {   if ( no_bonus_vylepseni >5 ){
              no_bonus_vylepseni = 5;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi rukojet",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni <3 )&(no_max_bonus >2 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_3),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni==3 )&(no_max_bonus >1 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_2),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            if (( no_bonus_vylepseni ==4 )&(no_max_bonus >1 )){
              AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1),no_Item);
              FloatingTextStringOnCreature(" Hm, takhle kvalitni rukojet nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
} //konec switche nasady


//úprava by Jachyra: nikdy sa neurobí vylepšenie vyššie ako povo¾uje samotný no_kov_1
switch ( GetLocalInt(OBJECT_SELF,"no_kov_1")) {
case 1: {   if ( no_bonus_vylepseni >0 ){
              no_bonus_vylepseni = 0;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov" ,no_oPC,FALSE);   }
            break;}
case 2: {   if ( no_bonus_vylepseni >0 ){
              no_bonus_vylepseni = 0;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 3: {   if ( no_bonus_vylepseni >1 ){
              no_bonus_vylepseni = 1;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 4: {   if ( no_bonus_vylepseni >2 ){
              no_bonus_vylepseni = 2;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 5: {
            break;}
case 6: {
            break;}
case 7: {   if ( no_bonus_vylepseni >3 ){
              no_bonus_vylepseni = 3;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 8: {   if ( no_bonus_vylepseni >4 ){
              no_bonus_vylepseni = 4;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 9: {
            break;}
case 10: {
            break;}
case 11: {   if ( no_bonus_vylepseni >5 ){
              no_bonus_vylepseni = 5;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
case 12: {   if ( no_bonus_vylepseni >5 ){
              no_bonus_vylepseni = 5;
              FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi primarni kov",no_oPC,FALSE );   }
            break;}
} //koniec úprava by Jachyra


//úprava by Jachyra: pri pridávaní vlastností napoèítalo kritik a teraz ho vyhodnotí a pod¾a toho pridá
if ( jy_kritik ==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1),no_Item);
if ( jy_kritik ==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2),no_Item);
if ( jy_kritik ==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_3),no_Item);
if ( jy_kritik ==4) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d4),no_Item);
if ( jy_kritik ==5) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d6),no_Item);
if ( jy_kritik ==6) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d8),no_Item);
if ( jy_kritik ==7) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d4),no_Item);
if ( jy_kritik ==8) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_1d10),no_Item);
if ( jy_kritik ==9) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d6),no_Item);
if ( jy_kritik ==10) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d8),no_Item);
if ( jy_kritik ==11) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d10),no_Item);
if ( jy_kritik >11) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(IP_CONST_DAMAGEBONUS_2d12),no_Item);
//koniec úprava by Jachyra



if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame vylepseni= " + IntToString(no_bonus_vylepseni) );
if (no_bonus_vylepseni>0) {
  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(no_bonus_vylepseni),no_Item);
}
if (no_bonus_vylepseni<0) {
  no_bonus_vylepseni=0 - no_bonus_vylepseni; //obracime, protoge penalty je kladne cislo.
  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementPenalty(no_bonus_vylepseni),no_Item);
}

if  (no_magicky_bonus>0) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,no_magicky_bonus),no_Item);


no_cenavyrobku(no_Item);
//zkusi nejak zmenit vzhled.
no_udelej_vzhled(no_Item);

}



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
{
/////////////////musime nejdrive prenastavit, kdyby nahodou byl jen 1 material ///////
/////////////////////////////////////////////////////////////////////////////////////
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
int no_menu_max_procent = 10;
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl

if ((GetLocalInt(OBJECT_SELF,"no_hl_proc"))  == no_menu_max_procent )
{
//jinak nepozna, ze ktereho stacku ma odecist pruty
SetLocalInt(no_pec,"no_ve_mat",GetLocalInt(no_pec,"no_hl_mat"));
if (NO_zb_DEBUG == TRUE) { SendMessageToPC(no_oPC,"%hl mat = max%, nastavuju vedlmat=hlmat." );
                        }
}

if ((GetLocalInt(OBJECT_SELF,"no_hl_proc"))  < no_menu_max_procent/2 )
{
int no_menu_hlavni_material = GetLocalInt(no_pec,"no_hl_mat");
//jinak nepozna, ze ktereho stacku ma odecist pruty
SetLocalInt(no_pec,"no_hl_mat",GetLocalInt(no_pec,"no_ve_mat"));
SetLocalInt(no_pec,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc") ));
SetLocalInt(no_pec,"no_ve_mat",no_menu_hlavni_material);
if (NO_zb_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Kvuli prutum prehazuju vedl s hlavnim" );   }
}

////////////////////////zacatek prohledavani/////////////////////////////////
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

 if (GetStringLeft(GetResRef(no_Item),7) != "tc_prut") {   //kdyz neni nalegovany kov, tak pokracujeme ve vybirani
 no_Item = GetNextItemInInventory(no_pec);
 continue;      }

 // if(GetStringLeft(GetResRef(no_Item),7) == "tc_prut"){
 //vsechny pruty takhle zacinaji urychli to procedura

       if(GetResRef(no_Item) == "tc_prut1")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",1);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==1)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",1);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);
                }
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",1);
                no_snizstack(no_Item,no_mazani);}
                              //znicime prisadu
    } //konec cin


       if(GetResRef(no_Item) == "tc_prut2")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",2);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==2) & (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")))
                    {SetLocalInt(no_pec,"no_pouzitykov2",2);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",2);
                no_snizstack(no_Item,no_mazani);  }
                            //znicime prisadu
    } //konec med

       if(GetResRef(no_Item) == "tc_prut3")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",3);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==3)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",3);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",3);
                no_snizstack(no_Item,no_mazani);  }
                            //znicime prisadu
    } //konec bronz

       if(GetResRef(no_Item) == "tc_prut4")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",4);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==4)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",4);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",4);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec zelezo

       if(GetResRef(no_Item) == "tc_prut11")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",5);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==5)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",5);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",5);
                no_snizstack(no_Item,no_mazani);  }
                            //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "tc_prut8")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",6);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==6)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",6);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",6);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut7")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",7);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==7)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",7);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",7);
                no_snizstack(no_Item,no_mazani);}
                              //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut5")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                   SetLocalInt(no_pec,"no_pouzitykov1",8);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==8)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",8);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",8);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut10")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",9);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==9)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",9);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",9);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut9")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",10);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==10)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")))
                    {SetLocalInt(no_pec,"no_pouzitykov2",10);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",10);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut12")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",11);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==11)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",11);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",11);
                no_snizstack(no_Item,no_mazani); }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "tc_prut13")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitykov1")==0) {
                SetLocalInt(no_pec,"no_pouzitykov1",12);
                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==12)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitykov2",12);
                    no_snizstack(no_Item,no_mazani);   }
               no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitykov1")!=0) {
                SetLocalInt(no_pec,"no_pouzitykov2",12);
                no_snizstack(no_Item,no_mazani); }

                        //znicime prisadu
    } //konec

 // }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame kov
}



void no_forma(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_forma
//////
////////////////////////////////////////////

{no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

    if(GetResRef(no_Item) == "cnrmoldsmall")           // do promene no_drevo ulozime nazev dreva
    { SetLocalInt(no_pec,"no_forma",1);
    no_snizstack(no_Item,no_mazani);                   // znicime drevo
    break;      }
    if(GetResRef(no_Item) == "tc_form_tenk")
    { SetLocalInt(no_pec,"no_forma",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
    if(GetResRef(no_Item) == "cnrmoldmedium")
    { SetLocalInt(no_pec,"no_forma",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
    if(GetResRef(no_Item) == "cnrmoldlarge")
    { SetLocalInt(no_pec,"no_forma",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
    if(GetResRef(no_Item) == "tc_form_zahn")
    { SetLocalInt(no_pec,"no_forma",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_prisada(object no_Item, object no_pec, int no_mazani)
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {



 if(GetStringLeft(GetResRef(no_Item),11) == "no_zb_pris_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_zb_pris_01")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_prisada",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_zb_pris_02")
    { SetLocalInt(no_pec,"no_prisada",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_zb_pris_03")
    { SetLocalInt(no_pec,"no_prisada",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_04")
    { SetLocalInt(no_pec,"no_prisada",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_05")
    { SetLocalInt(no_pec,"no_prisada",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_06")
    { SetLocalInt(no_pec,"no_prisada",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_07")
    { SetLocalInt(no_pec,"no_prisada",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_08")
    { SetLocalInt(no_pec,"no_prisada",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_09")
    { SetLocalInt(no_pec,"no_prisada",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_10")
    { SetLocalInt(no_pec,"no_prisada",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_11")
    { SetLocalInt(no_pec,"no_prisada",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_zb_pris_12")
    { SetLocalInt(no_pec,"no_prisada",12);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame prisady
}



void no_nasada(object no_Item,object no_pec, int no_mazani)
// napise pekne na pec cislo nasady.
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetResRef(no_Item),8) == "tc_nasa_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetResRef(no_Item) == "tc_nasa_vrb")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_nasada",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_nasa_ore")
    { SetLocalInt(no_pec,"no_nasada",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_nasa_dub")
    { SetLocalInt(no_pec,"no_nasada",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_nasa_mah")
    { SetLocalInt(no_pec,"no_nasada",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_nasa_tis")
    { SetLocalInt(no_pec,"no_nasada",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_nasa_jil")
    { SetLocalInt(no_pec,"no_nasada",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_nasa_zel")
    { SetLocalInt(no_pec,"no_nasada",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_nasa_pra")
    { SetLocalInt(no_pec,"no_nasada",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }  //konec if resref nasady
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame nasadu
}






void no_vyrobek (object no_Item, object no_pec, int no_mazani)
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if((GetStringLeft(GetResRef(no_Item),6) == "no_zb_")& (GetStringLeft(GetResRef(no_Item),10) != "no_zb_pris"))
{

//// musime davat resref, bo tzo jinak vezme i polotvary, jako vyrobky..


 //vsechny vyrobky v kovarine  takhle zacinaji, kdyz by to nahodou byla nejaka blbost, tak
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
AssignCommand(no_oPC,DelayCommand(0.2,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE)));
//   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));
}


////////Znici tlacitka z inventare ///////////////////////
void no_znicit(object no_oPC)
{
no_Item = GetFirstItemInInventory(no_oPC);

 while (GetIsObjectValid(no_Item)) {

 if  (GetStringLeft(GetResRef(no_Item),10) != "prepinac00")
 {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 001 - 003
 }
 DestroyObject(no_Item);
 no_Item = GetNextItemInInventory(no_oPC);
}

//no_Item = GetFirstItemInInventory(no_oPC);
// while (GetIsObjectValid(no_Item)) {
//
// if(GetResRef(no_Item) != "prepinac003") {
// no_Item = GetNextItemInInventory(no_oPC);
// continue;     //znicim vsechny prepinace 003
// }
// DestroyObject(no_Item);
// no_Item = GetNextItemInInventory(no_oPC);
//}
}

void no_reknimat(object no_oPC)
// rekne kolik procent je jakeho materialu
{
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
string no_menu_nazev_kovu;
string no_menu_nazev_kovu2;
string no_menu_nazev_procenta;
string no_menu_nazev_procenta2;
int no_menu_max_procent = 10;

//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }


if (GetLocalInt(OBJECT_SELF,"no_hl_proc")  < no_menu_max_procent/2 )
{
//jinak nepozna, ze ktereho stacku ma odecist pruty
int no_menu_hlavni_material = GetLocalInt(OBJECT_SELF,"no_hl_mat");
SetLocalInt(OBJECT_SELF,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_ve_mat"));
SetLocalInt(OBJECT_SELF,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc"))  );
SetLocalInt(OBJECT_SELF,"no_ve_mat",no_menu_hlavni_material);
if (NO_zb_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Reknutim co to je za material prehazujem" );   }
}

switch (GetLocalInt(OBJECT_SELF,"no_hl_mat")) {
case 0: {no_menu_nazev_kovu = "cin";
         SetLocalInt(OBJECT_SELF,"no_hl_mat",1); break;}
case 1: {no_menu_nazev_kovu = "cin";    break;}
case 2: {no_menu_nazev_kovu = "med";   break;}
case 3: {no_menu_nazev_kovu = "vermajl";   break;}
case 4: {no_menu_nazev_kovu = "zelezo";   break;}
case 5: {no_menu_nazev_kovu = "zlato";   break;}
case 6: {no_menu_nazev_kovu = "platina";   break;}
case 7: {no_menu_nazev_kovu = "mithril";   break;}
case 8: {no_menu_nazev_kovu = "adamantin";   break;}
case 9: {no_menu_nazev_kovu = "titan";   break;}
case 10: {no_menu_nazev_kovu = "stribro";   break;}
case 11: {no_menu_nazev_kovu = "stinova ocel";   break;}
case 12: {no_menu_nazev_kovu = "meteoriticka ocel";   break;}
}

switch (GetLocalInt(OBJECT_SELF,"no_ve_mat")) {
case 0: {no_menu_nazev_kovu2 = "cin";
        SetLocalInt(OBJECT_SELF,"no_ve_mat",1); break;}
case 1: {no_menu_nazev_kovu2 = "cin";    break;}
case 2: {no_menu_nazev_kovu2 = "med";   break;}
case 3: {no_menu_nazev_kovu2 = "vermajl";   break;}
case 4: {no_menu_nazev_kovu2 = "zelezo";   break;}
case 5: {no_menu_nazev_kovu2 = "zlato";   break;}
case 6: {no_menu_nazev_kovu2 = "platina";   break;}
case 7: {no_menu_nazev_kovu2 = "mithril";   break;}
case 8: {no_menu_nazev_kovu2 = "adamantin";   break;}
case 9: {no_menu_nazev_kovu2 = "titan";   break;}
case 10: {no_menu_nazev_kovu2 = "stribro";   break;}
case 11: {no_menu_nazev_kovu2 = "stinova ocel";   break;}
case 12: {no_menu_nazev_kovu2 = "meteoriticka ocel";   break;}
}
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl

switch (GetLocalInt(OBJECT_SELF,"no_hl_proc")) {
case 0: {// int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
         if (no_level >16) {
         no_menu_nazev_procenta = "200";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",20);  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_nazev_procenta = "180";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",18);  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_nazev_procenta = "160";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",16);  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_nazev_procenta = "140";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",14);  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_nazev_procenta = "120";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",12);  }
         else if ((no_level <5)) {
         no_menu_nazev_procenta = "100";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",10);  }
         break;}
case 20: {no_menu_nazev_procenta = "200";    break;}
case 18: {no_menu_nazev_procenta = "180";    break;}
case 16: {no_menu_nazev_procenta = "160";    break;}
case 14: {no_menu_nazev_procenta = "140";    break;}
case 12: {no_menu_nazev_procenta = "120";    break;}
case 10: {no_menu_nazev_procenta = "100";    break;}
case 8: {no_menu_nazev_procenta = "80";   break;}
case 6: {no_menu_nazev_procenta = "60";   break;}
case 4: {no_menu_nazev_procenta = "40";   break;}
case 2: {no_menu_nazev_procenta = "20";   break;}
}


if (NO_zb_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta=" + no_menu_nazev_procenta );}

no_menu_nazev_procenta2 =IntToString( 10*no_menu_max_procent - StringToInt(no_menu_nazev_procenta));

if (NO_zb_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta2=" + no_menu_nazev_procenta2 );}

if ((no_menu_nazev_kovu!=no_menu_nazev_kovu2)&(StringToInt(no_menu_nazev_procenta)!=10*no_menu_max_procent))  {

FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu + " a " + no_menu_nazev_procenta2 + "%" + no_menu_nazev_kovu2,no_oPC,FALSE );
}
if  ((no_menu_nazev_kovu==no_menu_nazev_kovu2) || (StringToInt(no_menu_nazev_procenta)==10*no_menu_max_procent)) {
no_menu_nazev_procenta = IntToString(10*no_menu_max_procent);
FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu ,no_oPC,FALSE );
if (NO_zb_DEBUG == TRUE) {SendMessageToPC(no_oPC,"(no_menu_nazev_procenta2== 0");}
}


}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
PlaySound("as_cv_smithhamr2");
DelayCommand(6.0,PlaySound("as_cv_smithhamr2"));
  location locAnvil = GetLocation(OBJECT_SELF);
  vector vEffectPos = GetPositionFromLocation(locAnvil);
  vEffectPos.z += 1.0;
  location locEffect = Location( GetAreaFromLocation(locAnvil), vEffectPos,GetFacingFromLocation(locAnvil) );

  ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect);
  DelayCommand(1.7, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY,FALSE), locEffect));
  DelayCommand(2.4, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
  DelayCommand(3.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_SPARKS_PARRY,FALSE),locEffect));
  DelayCommand(3.8, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
  DelayCommand(4.6,ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));
  DelayCommand(5.9, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_SPARKS_PARRY), locEffect));

AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9, 1.5, no_zb_delay));

    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_zb_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_zb_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));

// PlaySound("al_mg_crystalic1");
}


void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item)
//////////////prida procenta nehotovym vrobkum/////////////////////////////////
{string no_tag_vyrobku = GetTag(no_Item);
        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_kovar);}
 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
         string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

DestroyObject(no_Item);




no_Item = CreateItemOnObject("no_polot_zb",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
no_udelejjmeno(no_Item);
SetName(no_Item,GetName(no_Item) + "  *"+ no_nazev_procenta + "%*");
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_zb_clos_kov",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si vyrobu" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }

}


///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_zb (object no_oPC, object no_pec)
{
int no_druh=0;
int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
if  (GetIsDM(no_oPC)== TRUE) no_level=no_level+20;

no_Item = GetFirstItemInInventory(no_pec);

while (GetIsObjectValid(no_Item)) {
if  (GetResRef(no_Item) == "no_polot_zb")
        {
        no_zjistiobsah(GetTag(no_Item));
        break;
        }//pokud resref = no_polot_zb      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
 }    /// konec while

/// davam to radsi uz sem, bo se pak i podle toho nastavuje cena..
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dl") no_DC = 20;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dy") no_DC = 12;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_DC = 15;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ba") no_DC = 23;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vm") no_DC = 25;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ka") no_DC = 30;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ra") no_DC = 17;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sc") no_DC = 15;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ha") no_DC = 22;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ko") no_DC = 12;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ks") no_DC = 14;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tr") no_DC = 23;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bc") no_DC = 10;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "km") no_DC = 14;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ku") no_DC = 15;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "sr") no_DC = 11;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ds") no_DC = 28;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dm") no_DC = 29;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "dp") no_DC = 27;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "os") no_DC = 18;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "rs") no_DC = 8;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ts") no_DC = 17;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bs") no_DC = 24;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lc") no_DC = 13;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "tc") no_DC = 28;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lk") no_DC = 17;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "vk") no_DC = 19;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kj") no_DC = 6;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pa") no_DC = 18;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "re") no_DC = 21;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ma") no_DC = 23;
// 25.12.2009
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hu") no_DC = 10;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x2") no_DC = 12;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x3") no_DC = 13;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x4") no_DC = 16;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x5") no_DC = 18;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x6") no_DC = 20;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x7") no_DC = 26;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "x8") no_DC = 27;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y1") no_DC = 28;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y2") no_DC = 29;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "y3") no_DC = 30;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ss") no_DC = 28;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hp") no_DC = 24;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "lp") no_DC = 22;
int no_menu_max_procent = 10;

//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }


if (GetLocalInt(OBJECT_SELF,"no_druh_nasada") == 0 ) {
//to znamena, ze zatim nemame hotovo
no_DC = no_DC + (GetLocalInt(OBJECT_SELF,"no_kov_procenta")*GetLocalInt(OBJECT_SELF,"no_kov_1"))/4 + (( no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_kov_procenta"))*GetLocalInt(OBJECT_SELF,"no_kov_2"))/4 - 10*no_level;
// = max. 30+ (20*12)/4 + (0*12)/4 = 85  //tzn 9lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_kov_1"));
//no_druh = 1212   = meteocel+meteocel
}

if (GetLocalInt(OBJECT_SELF,"no_druh_nasada") != 0 ) {
//to znamena, ze budemem mit hotovo
no_DC = 5+ no_DC + ((GetLocalInt(OBJECT_SELF,"no_kov_procenta")*GetLocalInt(OBJECT_SELF,"no_kov_1")))/2 + (((no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_kov_procenta"))*GetLocalInt(OBJECT_SELF,"no_kov_2")))/2 + (10*GetLocalInt(OBJECT_SELF,"no_druh_nasada"))/2 - 10*no_level;
// = 5+ max. 30+ (20*12)/2 + (0*12)/2 + (10*8)/2 = 195  //tzn 20lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_kov_1") + GetLocalString(OBJECT_SELF,"no_kov_2")+ GetLocalString(OBJECT_SELF,"no_druh_nasada"));
//no_druh = 11021   = stinova ocel + med + vrba
}




if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"no_druh= " + IntToString(no_druh));


if (no_druh>0 ) {
////6brezen/////
if  (GetLocalFloat(no_Item,"no_suse_proc")==0.0) SetLocalFloat(no_Item,"no_suse_proc",10.0);


// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
        if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();

 if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));


if (no_hod <= no_chance ) {

        float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");

        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
                         TC_setXPbyDifficulty(no_oPC,TC_kovar,no_chance,TC_dej_vlastnost(TC_kovar,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_kovar,no_chance,TC_dej_vlastnost(TC_kovar,no_oPC));
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

            if (NO_zb_DEBUG == TRUE){no_procenta = no_procenta +30.0; }
            if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej
        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek

                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

// if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                        if (no_druh < 13) { //nedodelana zbran
                        no_Item=CreateItemOnObject("no_zb_" + GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),no_oPC,1,"no_zb_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_procenta")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_druh_nasada") );
                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyNoDamage(),no_Item);
                        no_udelejjmeno(no_Item);
                        no_cenavyrobku(no_Item);   }
    ///////////// dodelame zbran uplne /////////////////////////////////////////////
                        if ((no_druh > 13)& (no_druh < 12129 ) )
                        {    no_udelejzbran(no_pec);    }
/// }////////////////// konec dodelavky zbrane ///////////////////////////////



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

         FloatingTextStringOnCreature("Vyrobek se rozpadl",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) {FloatingTextStringOnCreature("Na vykovku se objevily okuje",no_oPC,FALSE ); }

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu
        if (no_procenta > 0.0 ) {
         no_vytvorprocenta(no_oPC,no_procenta,no_Item);
                            }



         }//konec else no_hod >no_chance

         }// konec kdyz jsme meli nejakej no_druh

}    ////konec no_xp_zb




void no_xp_pridej_nasadu(object no_oPC, object no_pec)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
no_zjistiobsah(GetLocalString(no_pec,"no_vyrobek"));
//SetLocalInt(OBJECT_SELF,"no_kov_1",0);
//SetLocalString(OBJECT_SELF,"no_kov_1","");
//SetLocalInt(OBJECT_SELF,"no_kov_2",0);
//SetLocalString(OBJECT_SELF,"no_kov_2","");
//SetLocalInt(OBJECT_SELF,"no_kov_procenta",0);
//SetLocalString(OBJECT_SELF,"no_kov_procenta","");
//SetLocalInt(OBJECT_SELF,"no_druh_nasada",0);
//SetLocalString(OBJECT_SELF,"no_druh_nasada","");
//SetLocalInt(OBJECT_SELF,"no_druh_vyrobku",0);
//SetLocalString(OBJECT_SELF,"no_druh_vyrobku","");
//podle tagu veci zjisti kolik je kovu a takovy ty pitomosti + jejich cislo a ulozi je na OBJECT_SELF

// kdyz je mensi, nez 60, tak to znamena, ze potrebujeme spravnejsi prisadu
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
int no_menu_max_procent = 10;
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl

////////////puvodni zenni, ale kdyz se to nastavilo, polotovar to blbe dodeallo...
//int no_prisadovy_material = GetLocalInt(no_pec,"no_hl_mat");
//if (GetLocalInt(no_pec,"no_hl_proc") < (no_menu_max_procent/2)  ) {
//no_prisadovy_material  = GetLocalInt(no_pec,"no_ve_mat");
//if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC, "potrebujem prisadu vedlejsiho materialu");
//}


//////////NOVE ZNENI:  bere se to z vyrobku :////////////////////
int no_prisadovy_material = GetLocalInt(no_pec,"no_kov_1");

if (GetLocalInt(no_pec,"no_hl_proc") < (no_menu_max_procent/2)  ) {
no_prisadovy_material  = GetLocalInt(no_pec,"no_ve_mat");
if (NO_zb_DEBUG == TRUE) SendMessageToPC(no_oPC, "potrebujem prisadu vedlejsiho materialu");
}

////////////////////////////////////////////////////////////

if (GetLocalInt(no_pec,"no_nasada") ==0)  FloatingTextStringOnCreature("Bude potreba rukojet!",no_oPC,FALSE);
if (GetLocalInt(no_pec,"no_prisada") ==0) FloatingTextStringOnCreature("Bude potreba kovarska prisada!",no_oPC,FALSE);
if ((GetLocalInt(no_pec,"no_prisada")!=no_prisadovy_material)& (GetLocalInt(no_pec,"no_prisada") !=0)) FloatingTextStringOnCreature("Potrebujes kovarskou prisadu kovu, ktereho je tam vice !",no_oPC,FALSE);

//tak, kdyz mame vsechno spravne, tak udelame :
if ((GetLocalInt(no_pec,"no_nasada") != 0 ) & ( GetLocalInt(no_pec,"no_prisada")==no_prisadovy_material))
{
            if (NO_zb_DEBUG == TRUE) SendMessageToPC(no_oPC, "polotovar: no_zb_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kov_1")+ "_" + GetLocalString(no_pec,"no_kov_procenta")+"_" + GetLocalString(no_pec,"no_kov_2")+ "_"+IntToString(GetLocalInt(no_pec,"no_nasada")));
            CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kov_1")+ "_" + GetLocalString(no_pec,"no_kov_procenta")+"_" + GetLocalString(no_pec,"no_kov_2")+ "_"+IntToString(GetLocalInt(no_pec,"no_nasada")));
            no_zamkni(no_oPC);
            no_prisada(no_Item,OBJECT_SELF,TRUE);
            no_vyrobek(no_Item,OBJECT_SELF,TRUE);
            no_nasada(no_Item,OBJECT_SELF,TRUE);
            DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));

            }
} // konec no_xp_pridej_nasadu


//////////////////////////////////////////////////////////////////////////////////////////
void no_xp_vyrobpolotovar(object no_oPC, object no_pec)
// vytvori polotovar
{
///kdyz 100% hlavniho, musime dat vedlejsi = hlavnimu.
//if (GetLocalInt(OBJECT_SELF, "no_hl_proc")==10) {
//SetLocalInt(OBJECT_SELF,"no_ve_mat",(GetLocalInt(OBJECT_SELF, "no_hl_mat")));
//if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC, "jenom hlavni material, prehazuju material i vedlejsimu");
//            }
string no_tag = "";
string no_tag2 = "";
string no_tag3 = "";

if ((((GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))   ||  (( (GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))                   )
{


no_tag = IntToString(GetLocalInt(no_pec,"no_hl_mat")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tag) ==1) {no_tag =  "0" + no_tag; }
if (GetStringLength(no_tag) ==2) {no_tag = no_tag;} // ulozi nam to string nazev kamene.

no_tag2 = IntToString(GetLocalInt(no_pec,"no_ve_mat")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tag2) ==1) {no_tag2 =  "0" + no_tag2; }
if (GetStringLength(no_tag2) ==2) {no_tag2 = no_tag2;} // ulozi nam to string nazev kamene.

no_tag3 = IntToString(GetLocalInt(OBJECT_SELF,"no_hl_proc")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tag3) ==1) {no_tag3 =  "0" + no_tag3; }
if (GetStringLength(no_tag3) ==2) {no_tag3 = no_tag3;} // ulozi nam to string nazev kamene.

if (NO_zb_DEBUG == TRUE) SendMessageToPC(no_oPC, "polotovar: no_zb_XX_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");

////////////////////////////////////////////////////////////////////////////////////////////
//////////////takovej male pozmeneni zadanych veci, bo kdo to zacne, tak to dopadne.///////////
//////////////////////////////////////////////////////////////////////////////////////////////
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
int no_menu_max_procent = 10;
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
if (no_tag  == no_tag2 )
{
string no_tag3 = IntToString(no_menu_max_procent);
if (GetStringLength(no_tag3) ==1) {no_tag3 =  "0" + no_tag3; }
if (GetStringLength(no_tag3) ==2) {no_tag3 = no_tag3;}

if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame kov1=kov2, nastavuju max= " + no_tag3+ "0%" );
}

if (GetLocalInt(OBJECT_SELF,"no_hl_proc")  == no_menu_max_procent )
{
no_tag2 = no_tag;
//jinak nepozna, ze ktereho stacku ma odecist pruty
SetLocalInt(no_pec,"no_ve_mat",GetLocalInt(no_pec,"no_hl_mat"));
if ( NO_zb_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame max.procent,at to nemate, nastavuju kov2, na hodnotu kov1" );
}
///////////////////////////////////////////////////////////////////////////////////


switch (GetLocalInt(OBJECT_SELF,"no_menu")) {
        case 10:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_dl_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);
                    }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 11:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_dy_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 12:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_kr_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 13:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ba_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 14:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_vm_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);   }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 15:   {if  (GetLocalInt(no_pec,"no_forma") == 5 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ka_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste zahnutou formu",no_oPC,FALSE );
                    break;}
        case 16:   {if  (GetLocalInt(no_pec,"no_forma") == 2 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ra_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste tenkou formu",no_oPC,FALSE );
                    break;}
        case 17:   {if  (GetLocalInt(no_pec,"no_forma") == 2 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_sc_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste tenkou formu",no_oPC,FALSE );
                    break;}
        case 20:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ha_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 21:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ko_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 22:   {if  (GetLocalInt(no_pec,"no_forma") == 5 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ks_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste zahnutou formu",no_oPC,FALSE );
                    break;}
        case 23:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_tr_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 31:   {if  (GetLocalInt(no_pec,"no_forma") == 2 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_bc_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste tenkou formu",no_oPC,FALSE );
                    break;}
        case 32:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_km_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 33:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ku_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 34:   {if  (GetLocalInt(no_pec,"no_forma") == 5 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_sr_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste zahnutou formu",no_oPC,FALSE );
                    break;}
        case 41:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ds_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 42:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_dm_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 43:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_dp_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 51:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_os_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 52:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_rs_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 53:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ts_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 54:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_bs_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 61:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_lc_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);  }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 62:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_tc_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 63:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_lk_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE);}
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 64:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_vk_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 65:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_kj_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 66:  { if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_pa_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 67:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_re_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 68:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ma_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
       // 25.12.2009
        case 24:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_hu_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}

        case 70:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x2_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 71:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x3_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 72:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x4_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 73:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x5_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 74:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x6_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 75:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x7_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 76:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_x8_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 18:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_y1_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 19:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_y2_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
        case 79:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_y3_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
       case 25:   {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_ss_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}
        case 77:   {if  (GetLocalInt(no_pec,"no_forma") == 4 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_hp_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste velkou formu",no_oPC,FALSE );
                    break;}
         case 78:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zb",no_pec,1,"no_zb_lp_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zb_delay,no_xp_zb(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    no_forma(no_Item,OBJECT_SELF,TRUE); }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}


        } //konec switche

 }//if spravne kovy


else // ((( (GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))   ||  ( ((GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))                   )
{FloatingTextStringOnCreature("pro zacatek kovani je treba umistit dva spravne ingoty kovu",no_oPC,FALSE );
}

} // konec vyrob polotovar



///////////////vzhledy zbrani 26 zari  ///////////////////

void no_vzhled_zbrane(object no_oPC,int meneny_model,int meneny_index, int zmena)
///meneny model = ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_TYPE_WEAPON_COLOR
///meneny index = ITEM_APPR_TYPE_WEAPON_MODEL_BOTTOM , MIDDLE, TOP
// zmena = +1/-1  tedy predchozi, nebo puvodni
{
object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC);
if ( GetIsObjectValid(oItem) == TRUE )     {

int no_aktualni_vzhled = GetItemAppearance(oItem,meneny_model,meneny_index);
FloatingTextStringOnCreature(" Puvodni vzhled cislo: " + IntToString(no_aktualni_vzhled) ,no_oPC ,FALSE);


object no_item_modify;
no_item_modify = CopyItemAndModify(oItem,meneny_model,meneny_index,no_aktualni_vzhled + zmena, TRUE);
//FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,no_oPC ,FALSE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(no_aktualni_vzhled + zmena) ,no_oPC ,FALSE);


if (GetIsObjectValid(no_item_modify) == FALSE ) {
//pokud by nahodou mel uz moc divne cislo (male ci velke ) vzhled 1 to nikdy nezkazi
//int no_platny_index = 1;
//1 pro 90% zbrani, ale nektere to maji trosku jinak:
//no_item_modify = CopyItemAndModify(oItem,meneny_model,meneny_index,no_platny_index, TRUE);
//if (GetIsObjectValid(no_item_modify) == FALSE )  {
//DestroyObject(no_item_modify);
//no_platny_index = 11;
//no_item_modify = CopyItemAndModify(oItem,meneny_model,meneny_index,no_platny_index, TRUE);
//}
//if (GetIsObjectValid(no_item_modify) == FALSE )  {
//DestroyObject(no_item_modify);
//no_platny_index = 12;
//no_item_modify = CopyItemAndModify(oItem,meneny_model,meneny_index,no_platny_index, TRUE);

FloatingTextStringOnCreature("Neplatny vzhled ! Vracim puvodni ",no_oPC ,FALSE);
}

if (GetIsObjectValid(no_item_modify) == TRUE ) { DestroyObject(oItem); }

AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(no_item_modify,INVENTORY_SLOT_RIGHTHAND)));

}//pokud je v prave ruce platna vec


}

void no_vzhled_puvo(object no_oPC)
{
//
object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC);
if ( GetIsObjectValid(oItem) == TRUE )     {

DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM, GetLocalInt(OBJECT_SELF,"no_zbran_bot_las"), TRUE);
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_BOTTOM, GetLocalInt(OBJECT_SELF,"no_zbran_bot_barva_las"), TRUE);
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE, GetLocalInt(OBJECT_SELF,"no_zbran_mid_las"), TRUE);
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_MIDDLE, GetLocalInt(OBJECT_SELF,"no_zbran_mid_barva_las"), TRUE);
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP, GetLocalInt(OBJECT_SELF,"no_zbran_top_las"), TRUE);
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_TOP, GetLocalInt(OBJECT_SELF,"no_zbran_top_barva_las"), TRUE);
AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND)));
}
}

void no_vzhled_zapa(object no_oPC)
{



object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC);
/////////tak mame vynulovano z minuleho pouziti///////////////

if ( GetIsObjectValid(oItem) == TRUE )     {
string no_zbran_jmenovzhledu = "";
int no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM);
SetLocalInt(OBJECT_SELF,"no_zbran_bot_las",no_apperance);
no_zbran_jmenovzhledu =IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_BOTTOM);
SetLocalInt(OBJECT_SELF,"no_zbran_bot_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE);
SetLocalInt(OBJECT_SELF,"no_zbran_mid_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_MIDDLE);
SetLocalInt(OBJECT_SELF,"no_zbran_mid_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP);
SetLocalInt(OBJECT_SELF,"no_zbran_top_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_TOP);
SetLocalInt(OBJECT_SELF,"no_zbran_top_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
SetLocalString(OBJECT_SELF,"no_zbran_jmenovzhledu",no_zbran_jmenovzhledu);

FloatingTextStringOnCreature(" Zbran byla ulozena s cisly: " +no_zbran_jmenovzhledu ,no_oPC,FALSE);
//jeste ulozime objekt, kdyby byl neplatny vzhled stitu !
SetLocalObject(OBJECT_SELF, "no_" + GetName( GetPCSpeaker()) ,oItem);
} //kdyz je zbran valid object

}


void no_visual(object no_oPC, int no_grafika)
{

if (GetGold(no_oPC)<5000) FloatingTextStringOnCreature("Nemas dostatek penez",no_oPC,FALSE);

object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC);
if ( GetIsObjectValid(oItem) == TRUE )    {

//pridavame graficky efekt
if (( no_grafika < 10) & (GetGold(no_oPC)>4999) ) {

//AssignCommand(no_oPC,DelayCommand(0.1,ActionUnequipItem(oItem)));

//object modifikovany_item = CopyItem(oItem,OBJECT_SELF,TRUE);
//DestroyObject(oItem); //puvodni objekt
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(no_grafika),oItem);
//oItem = CopyItem(modifikovany_item,no_oPC,TRUE);
//DestroyObject(modifikovany_item);
//AssignCommand(no_oPC,DelayCommand(0.2,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND)));
TakeGoldFromCreature(5000,no_oPC,TRUE);
}

//kdyz mame odebrat graficky efekt :
if ( no_grafika == 10) {
//AssignCommand(no_oPC,DelayCommand(0.1,ActionUnequipItem(oItem)));
//object modifikovany_item = CopyItem(oItem,OBJECT_SELF,TRUE);
//DestroyObject(oItem); //puvodni objekt
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_ACID));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_COLD));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_EVIL));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_HOLY));
RemoveItemProperty(oItem,ItemPropertyVisualEffect(ITEM_VISUAL_SONIC));

//////////presne z NWN lexiconu ///////////////////
itemproperty ipLoop=GetFirstItemProperty(oItem);
//Loop for as long as the ipLoop variable is valid
while (GetIsItemPropertyValid(ipLoop))
   {
   //If ipLoop is a true seeing property, remove it
   if (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_VISUALEFFECT)
      RemoveItemProperty(oItem, ipLoop);
   //Next itemproperty on the list...
   ipLoop=GetNextItemProperty(oItem);
   }

//oItem = CopyItem(modifikovany_item,no_oPC,TRUE);
//DestroyObject(modifikovany_item);
//DestroyObject(oItem);
//AssignCommand(no_oPC,DelayCommand(0.2,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND)));
}//kdyz mame odstrant efekt

}//kdyz je predmet validni

}

