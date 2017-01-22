#include "ku_libtime"
//#include "no_pl_inc"
//#include "no_ko_inc"
//#include "no_sl_inc"
#include "tc_xpsystem_inc"
//#include "no_ko_inc"
#include "no_nastcraft_ini"
#include "ku_items_inc"
#include "ku_persist_inc"
#include "tc_functions"

/////////////////////////////////////
///  dela vsemozne sici vyrobky s tagama:
///
///  boty: no_tr_kr_01_02
/// 01-kuze  02 pouzite drevo, 02 pouzity kov
///
/////////////////////////////////

int no_pocet;
string no_nazev;
int no_DC;
int no_bonus_vylepseni;
//int no_vulnear_elektrika;
int no_disciple;
int no_soak_bonus;
int no_decrease_obratnost;


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

void no_udelejzbroj(object no_pec);
//udela vyrobek + mu udeli vlastnosti podle pouzitych prisad


void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_pouzitykov(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_pouzitykov
void no_prisada(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_tetiva
void no_kuze(object no_Item,object no_pec, int no_mazani);
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
void no_xp_pl (object no_oPC, object no_pec);

// prida jakemukoliv polotovaru nasadu, ktera je zrovna hozeny do kovadliny
void no_xp_pridej_kuzi(object no_oPC, object no_pec);

//vyrobi polotovar se vsemi nutnymi tagy apod.
void no_xp_vyrobpolotovar(object no_oPC, object no_pec);

void no_men_vzhled_dalsi(object no_oPC);

void no_men_vzhled_predchozi(object no_oPC);

void no_men_vzhled_puvodni(object no_oPC);

void no_men_vzhled_zapamatovat(object no_oPC);


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
SetLocalInt(OBJECT_SELF,"no_druh_kuze",0);
SetLocalString(OBJECT_SELF,"no_druh_kuze","");
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
SetLocalString(OBJECT_SELF,"no_druh_kuze",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_druh_kuze",(StringToInt(no_pouzitavec)));


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


if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_jmeno =no_jmeno + "a krouzkova kosile";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hr") no_jmeno =no_jmeno + "y hrudni pancir";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "de") no_jmeno = no_jmeno +"a destickova zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pu") no_jmeno = no_jmeno +"a pulovicni platova zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pl") no_jmeno =no_jmeno +"a plno platova zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "he") no_jmeno = no_jmeno +"a helma";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bo") no_jmeno = no_jmeno +"e okovane boty";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ru") no_jmeno = no_jmeno +"e okovane rukavice";


switch (GetLocalInt(OBJECT_SELF,"no_druh_kuze")){
case 0: {  no_jmeno = no_jmeno + " bez reminku ";
        break;}
case 1: {no_jmeno =no_jmeno +" s obycejnou kuzi"   ;
         break; }
case 2: {no_jmeno =no_jmeno +" s lepsi kuzi"  ;
         break; }
case 3: {no_jmeno =no_jmeno +" s kvalitni kuzi"  ;
         break; }
case 4: {no_jmeno =no_jmeno +" s mistrovskou kuzi" ;
         break; }
case 5: {no_jmeno =no_jmeno +" s velmistrovskou kuzi"  ;
         break; }
case 6: {no_jmeno =no_jmeno +" s legendarni kuzi"  ;
         break; }
}//konec switche kovu


SetName(no_Item,no_jmeno);


//////nastavi description predmetu //////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_jmeno ="Tuto krouzkovou kosili";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hr") no_jmeno ="Tento hrudn pancir";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "de") no_jmeno = "Tuto destickovou zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pu") no_jmeno = "Tuto pulovicni platovou zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pl") no_jmeno ="Tuto plno platovou zbroj";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "he") no_jmeno = "Tuto helmu";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bo") no_jmeno = "Tyto okovane boty";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ru") no_jmeno = "Tyto okovane rukavice";

//SetDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + ".");

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
// no_zjistiobsah(no_Item);
// vetsinou cenu nastavujem az po menu .

int no_cena_kuze = 1;
int no_cena_kuze2 = 1;
int no_cena_kuze3 = 1;
int no_cena_kuze4 = 1;
float no_koeficient = 1.0;


//1kov
switch (GetLocalInt(OBJECT_SELF,"no_kov_1")){
case 1: {no_cena_kuze  = no_cena_tin;    //cena nahrana z no_sl_inc
         break; }
case 2: {no_cena_kuze  = no_cena_copp;
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
case 1: {no_cena_kuze2  = no_cena_tin;    //cena nahrana z no_sl_inc
         break; }
case 2: {no_cena_kuze2  = no_cena_copp;
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



if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_koeficient = 1.0075;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hr") no_koeficient = 1.008;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "de") no_koeficient = 1.01;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pu") no_koeficient = 1.011;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pl") no_koeficient = 1.0125;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "he") no_koeficient = 1.005;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bo") no_koeficient = 1.0025;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ru") no_koeficient = 1.000;



if ( GetLocalInt(OBJECT_SELF,"no_druh_kuze") !=0  ) {

switch (GetLocalInt(OBJECT_SELF,"no_druh_kuze")){
                case 1: {no_cena_kuze3 = no_cena_kozk_obyc;   //nahrano z no_ko_inc
                break; }
                case 2: {no_cena_kuze3 = no_cena_kozk_leps;
                break; }
                case 3: {no_cena_kuze3 = no_cena_kozk_kval;
                break; }
                case 4: {no_cena_kuze3 = no_cena_kozk_mist;
                break; }
                case 5: {no_cena_kuze3 = no_cena_kozk_velm;
                break; }
                case 6: {no_cena_kuze3 = no_cena_kozk_lege;
                break; }
                }// konec switche
} //konec kdyz mame nasadu





int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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
if (NO_pl_DEBUG == TRUE) SendMessageToPC(no_oPC, "Jako prisadu sme pozivali vedl.kov, takze od ni odvodime cenu.");
}

switch (no_material_prisady){
case 1: {no_cena_kuze4 = no_cena_prisada1; //nahrano z no_pl_inc
         break; }
case 2: {no_cena_kuze4 = no_cena_prisada2;
         break; }
case 3: {no_cena_kuze4 = no_cena_prisada3;
         break; }
case 4: {no_cena_kuze4 = no_cena_prisada4;
         break; }
case 5: {no_cena_kuze4 = no_cena_prisada5;
         break; }
case 6: {no_cena_kuze4 = no_cena_prisada6;
         break; }
case 7: {no_cena_kuze4 = no_cena_prisada7;
         break; }
case 8: {no_cena_kuze4 = no_cena_prisada8;
         break; }
case 9: {no_cena_kuze4 = no_cena_prisada9;
         break; }
case 10: {no_cena_kuze4 = no_cena_prisada10;
         break; }
case 11: {no_cena_kuze4 = no_cena_prisada11;
         break; }
case 12: {no_cena_kuze4 = no_cena_prisada12;
         break; }
}  //switch podle prisady

/////////30%zisk jako vzdy/////////////////
if ( GetLocalInt(OBJECT_SELF,"no_druh_kuze") ==0  ) {
SetLocalInt(no_Item,"tc_cena",FloatToInt (no_koeficient* no_pl_nasobitel2*(1.01*no_cena_kuze + 1.01*no_cena_kuze2) ));
}
if ( GetLocalInt(OBJECT_SELF,"no_druh_kuze") !=0  ) {
SetLocalInt(no_Item,"tc_cena",FloatToInt(no_koeficient* no_pl_nasobitel*(1.01*no_cena_kuze+1.01*no_cena_kuze2+ 1.01*no_cena_kuze3+no_cena_kuze4) ));
}



}   //konec no_udelejcenu

void no_vynikajicikus(object no_Item)
{
int no_random = d100() - TC_getLevel(no_oPC,TC_platner);
if (no_random < (TC_dej_vlastnost(TC_platner,no_oPC)/4+1) ) {
////sance vroby vyjimecneho kusu stoupa s lvlem craftera
if  (GetIsDM(no_oPC)== TRUE) no_random = no_random -50;//DM maji vetsi sanci vyjimecneho kusu
FloatingTextStringOnCreature("Podarilo se ti vyrobit vyjimecny kus !", no_oPC,TRUE);

no_random = Random(16)+1;


switch (no_random)  {

case 1: {
                  itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,1);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Chladak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 2: {
            itemproperty  no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,1+d2() );
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Draci plech'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                   break;}
case 3: {
            itemproperty no_ip =ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_GIANT,no_bonus_vylepseni+d2());
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                   SetName(no_Item,GetName(no_Item) + "  'Obro drz'");
                   SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 130);
                   break;}
case 4: {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SEARCH,d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Hledacek'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 400);
                   break;}
case 5: {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SPOT,d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Lepsi oko'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 6: {
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,d2() ),no_Item);
            SetName(no_Item,GetName(no_Item) + "  'Vydrz obra'");
            SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 300);
                   break;}
case  7: {
            itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,d2());
            AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
            SetName(no_Item,GetName(no_Item) + "  'Uzemnovac'");
            SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case 8:  {
       itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,d2());
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                   SetName(no_Item,GetName(no_Item) + "  'Kysely stit'");
                   SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case  9:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_TUMBLE,d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Uhybac'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 10: {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_DISCIPLINE,d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Pevnostuj'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 1000);
                   break;}

case 11:  {
                itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,d2());
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                   SetName(no_Item,GetName(no_Item) + "  'Dobromysl'");
                   SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 12:  {
                itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1);
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Rychlej postreh'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 13:  {
                itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Tvrdak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 14:  {
                itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Reakcnak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}

case  15:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_LISTEN,1 + d4());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Poslouchac'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 200);
                   break;}
case  16:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_HEAL,1 + d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Lecitel'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                   break;}

         }//konec switche


       }//konec if vyjimecna vec se podari

}//konec veci navic



// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_kov_co_pridavam, int no_kov_pridame_procenta )
{

switch   (no_kov_co_pridavam){
        case 1:  {  switch (no_kov_pridame_procenta) {
        //cín
                        case 2: {
                             break;  }
                        case 4: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                  }
                             break;  }
                        case 6: { no_bonus_vylepseni = no_bonus_vylepseni -4;
                                  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                        //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                  }
                             break;  }
                        case 8: { no_bonus_vylepseni = no_bonus_vylepseni -4;
                                  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                  }
                             break;  }
                        case 10: { no_bonus_vylepseni = no_bonus_vylepseni -5;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 12: { no_bonus_vylepseni = no_bonus_vylepseni -4;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 14: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 16: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 18: { no_bonus_vylepseni = no_bonus_vylepseni -2;
                                 // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 20: { no_bonus_vylepseni = no_bonus_vylepseni -2;
                                 //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        } //konec vnitrniho switche
               break;     }//konec cinu
        case 2:  {  switch (no_kov_pridame_procenta) {
        //meï
                        case 2: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 4: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                      // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                             break;  }
                        case 6: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   }
                                   no_bonus_vylepseni = no_bonus_vylepseni -2;
                             break;  }
                        case 8: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                   }
                                   else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                   }
                                   no_bonus_vylepseni = no_bonus_vylepseni -2;
                             break;  }
                        case 10: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                   }
                                   else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                   }
                             break;  }
                        case 12: { no_bonus_vylepseni = no_bonus_vylepseni -3;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       //no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                   }
                                   else {
                                     //   no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                   }
                             break;  }
                        case 14: { no_bonus_vylepseni = no_bonus_vylepseni -2;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                   }
                                   else {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                   }
                             break;  }
                        case 16: { no_bonus_vylepseni = no_bonus_vylepseni -2;
                                   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                   }
                                   else {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                   }
                             break;  }
                        case 18: { no_bonus_vylepseni = no_bonus_vylepseni -1;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 20: { no_bonus_vylepseni = no_bonus_vylepseni -1;
                                 //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        } //konec vnitrniho switche
               break;     }//konec medi
        case 3:  {  switch (no_kov_pridame_procenta) {
        //vermajl
                        case 2: {   no_disciple = no_disciple +1;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                             break;  }
                        case 4: {   no_disciple = no_disciple +2;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                             break;  }
                        case 6: {   no_disciple = no_disciple +3;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 8: {   no_disciple = no_disciple +4;
                                    if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                   //      no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                             break;  }
                        case 10: {  no_disciple = no_disciple +5;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +15;
                             break;  }
                        case 12: {  no_disciple = no_disciple +6;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                             break;  }
                        case 14: {  no_disciple = no_disciple +7;
                                 //   no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 16: {  no_disciple = no_disciple +8;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 18: {  no_disciple = no_disciple +9;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                             break;  }
                        case 20: {  no_disciple = no_disciple +10;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                             break;  }
                        } //konec vnitrniho switche
               break;     }//konec bronzu
        case 4:  {  switch (no_kov_pridame_procenta) {
        //zelezo
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     //   no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    }
                             break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                             break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //   no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                             break; }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                   //no_vulnear_elektrika  = no_vulnear_elektrika +25;
                             break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    //     no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                                    else {
                                      //   no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                    }
                             break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    no_decrease_obratnost = no_decrease_obratnost+1;
                                    if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       //  no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                                    else {
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                             break;  }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +1;
                                     no_decrease_obratnost = no_decrease_obratnost+1;
                                    if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     //    no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                                    else {
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +20;
                                    }
                             break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                     no_decrease_obratnost = no_decrease_obratnost+2;
                                   //no_vulnear_elektrika  = no_vulnear_elektrika +15;
                             break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_SLASHING,2),no_Item);
                                     no_decrease_obratnost = no_decrease_obratnost+2;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                     no_decrease_obratnost = no_decrease_obratnost+3;
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                             break;  }
                        } //konec vnitrniho switche
                break;    }//konec zeleza
        case 5:  {  switch (no_kov_pridame_procenta) {
        //zlato
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    }
                                    else  {}
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    }
                                    else  {}
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    }
                                 //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    }
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    no_bonus_vylepseni = no_bonus_vylepseni -3;
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni -3;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    break;  }
                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni -2;
                                   //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_20),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni -1;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_20),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni -1;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_25),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni -1;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_25),no_Item);
                                    }
                                    else  {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec zlata
        case 6:  {  switch (no_kov_pridame_procenta) {
        //platina
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12),no_Item);
                                         //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    }
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_10),no_Item);
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12),no_Item);
                                    }
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16),no_Item);
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12),no_Item);
                                    }
                                    break;  }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18),no_Item);
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14),no_Item);
                                    }
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20),no_Item);
                                      //  no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16),no_Item);
                                        // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    }
                                    break;  }
                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22),no_Item);
                                       //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18),no_Item);
                                        // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                                    break;  }
                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22),no_Item);
                                       //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18),no_Item);
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24),no_Item);
                                        // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20),no_Item);
                                       // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    }
                                    break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24),no_Item);
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20),no_Item);
                                    }
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_26),no_Item);
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22),no_Item);
                                    }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec platiny
        case 7:  {  switch (no_kov_pridame_procenta) {
        //mithril
                        case 2: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    break;  }
                        case 4: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    break;  }
                        case 6: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break; }
                        case 8: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 10: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 12: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 14: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 16: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 18: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);

                                   //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 20: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                   no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec mithril
        case 8:  {  switch (no_kov_pridame_procenta) {
        //adamantit
                        case 2: {   //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                    break;  }
                        case 4: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                    break;  }
                        case 6: {   no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                   // AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_10_LBS),no_Item);
                                    break; }
                        case 8: {   no_bonus_vylepseni = no_bonus_vylepseni +2;
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);

                                    break;  }
                        case 10: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                   //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                    break;  }
                        case 12: {  no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                   // AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_15_LBS),no_Item);
                                     no_decrease_obratnost = no_decrease_obratnost+1;
                                    break; }
                        case 14: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                    no_decrease_obratnost = no_decrease_obratnost+2;
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                   break;  }
                        case 16: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                     no_decrease_obratnost = no_decrease_obratnost+2;
                                    // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 18: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                     no_decrease_obratnost = no_decrease_obratnost+2;
                                    break; }
                        case 20: {  no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                    no_decrease_obratnost = no_decrease_obratnost+3;
                                   break;  }
                        } //konec vnitrniho switche
               break;     }//konec adamantinu
        case 9:  {  switch (no_kov_pridame_procenta) {
        //titan
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    else  {}
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    else  {}
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                    }
                                    else  {
                                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    break;  }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                       //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    }
                                    else  {
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                        // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    }
                                    else  {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    break;  }

                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                        // no_vulnear_elektrika  = no_vulnear_elektrika +15;
                                    }
                                    else  {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    break;  }

                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                     // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                        }
                                    else  {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                    }
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                    // no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                        }
                                    else  {

                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                         }
                                    break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                     //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                        }
                                    else  {
                                          AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                          }
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                          AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_10_HP),no_Item);
                                        //  no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                         }
                                    else  {
                                           AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_5_HP),no_Item);
                                            }
                                    break;  }
                        } //konec vnitrniho switche
               break; }//konec titanu
        case 10:  {  switch (no_kov_pridame_procenta) {
        //stribro
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT), no_Item);
                                    }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT), no_Item);
                                    }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                    }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_15_PERCENT), no_Item);
                                    }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                     }
                                  // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                     no_bonus_vylepseni = no_bonus_vylepseni -1;
                                    break; }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT), no_Item);
                                     }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                     }
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                     no_bonus_vylepseni = no_bonus_vylepseni -1;
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_25_PERCENT), no_Item);
                                      }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                    }
                                   //no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                     no_bonus_vylepseni = no_bonus_vylepseni -2;
                                    break;  }
                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_30_PERCENT), no_Item);
                                     }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,3),no_Item);
                                    }
                                  //  no_vulnear_elektrika  = no_vulnear_elektrika +10;
                                     no_bonus_vylepseni = no_bonus_vylepseni -2;
                                    break;  }
                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_35_PERCENT), no_Item);
                                     }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,3),no_Item);
                                     }
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +5;
                                     no_bonus_vylepseni = no_bonus_vylepseni -1;
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_40_PERCENT), no_Item);
                                     }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,3),no_Item);
                                    }
                                   // no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                    no_bonus_vylepseni = no_bonus_vylepseni -1;
                                   break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_45_PERCENT), no_Item);
                                    }
                                    else  {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,4),no_Item);
                                    }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyArcaneSpellFailure(IP_CONST_ARCANE_SPELL_FAILURE_MINUS_50_PERCENT), no_Item);
                                    }
                                    else  {
                                   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,4),no_Item);
                                     }
                                    //no_vulnear_elektrika  = no_vulnear_elektrika +25;
                                    break;  }
                            } //konec vnitrniho switche
                break;    }//konec stribra
        case 11:  {  switch (no_kov_pridame_procenta) {
        //stinova ocel
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                        // no_disciple = no_disciple +1;
                                    }
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                        // no_disciple = no_disciple +2;
                                    }
                                    else{
                                        // no_disciple = no_disciple +1;
                                    }
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //   no_disciple = no_disciple +2;
                                    }
                                    else{
                                       //  no_disciple = no_disciple +1;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         no_disciple = no_disciple +2;
                                         no_soak_bonus=no_soak_bonus +2;
                                    }
                                    else{
                                         no_disciple = no_disciple +2;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         no_disciple = no_disciple +2;
                                         no_soak_bonus=no_soak_bonus +3;
                                    }
                                    else{
                                         no_disciple = no_disciple +2;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +3;
                                        no_soak_bonus=no_soak_bonus +3;
                                    }
                                    else{
                                         no_disciple = no_disciple +3;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                         no_soak_bonus=no_soak_bonus +4;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +3;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                         no_soak_bonus=no_soak_bonus +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +4;
                                         no_soak_bonus=no_soak_bonus +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +5;
                                         no_soak_bonus=no_soak_bonus +6;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +5;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    break;  }
                        } //konec vnitrniho switche
                break;    }//konec stinove oceli
        case 12:  {  switch (no_kov_pridame_procenta) {
        //meteoricka ocel
                        case 2: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                      //   no_disciple = no_disciple +2;
                                    }
                                    else{
                                      //   no_disciple = no_disciple +1;
                                    }
                                   // no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 4: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         no_disciple = no_disciple +3;
                                         no_soak_bonus=no_soak_bonus +3;
                                    }
                                    else{
                                         no_disciple = no_disciple +2;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +1;
                                    break;  }
                        case 6: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         no_disciple = no_disciple +3;
                                         no_soak_bonus=no_soak_bonus +2;
                                    }
                                    else{
                                         no_disciple = no_disciple +2;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 8: {   if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                         no_soak_bonus=no_soak_bonus +3;
                                    }
                                    else{
                                         no_disciple = no_disciple +3;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +2;
                                    break;  }
                        case 10: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                         no_soak_bonus=no_soak_bonus +3;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +3;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        case 12: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +5;
                                        no_soak_bonus=no_soak_bonus +4;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +3;
                                    break;  }
                        case 14: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +5;
                                         no_soak_bonus=no_soak_bonus +5;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    break;  }
                        case 16: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +6;
                                         no_soak_bonus=no_soak_bonus +6;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                         no_disciple = no_disciple +4;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +4;
                                    break;  }
                        case 18: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_15),no_Item);
                                         no_disciple = no_disciple +6;
                                         no_soak_bonus=no_soak_bonus +6;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +5;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +5;
                                    break;  }
                        case 20: {  if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_15),no_Item);
                                         no_disciple = no_disciple +7;
                                        no_soak_bonus=no_soak_bonus +7;
                                    }
                                    else{
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                         no_disciple = no_disciple +6;
                                    }
                                    no_bonus_vylepseni = no_bonus_vylepseni +5;
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
object no_Item_modified;
//int no_nahoda= d6();
int no_nahoda= d10();
////vygenerujeme to po prve
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
{
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_BELT,7+d2(),TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_PELVIS,7+d2(),TRUE));

//no_nahoda= 1+d10();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LHAND,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RHAND,no_nahoda,TRUE));
//no_nahoda= d10();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_NECK,d6(),TRUE));
//no_nahoda= d10();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOREARM,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOREARM,no_nahoda,TRUE));
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LBICEP,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RBICEP,no_nahoda,TRUE));
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHOULDER,no_nahoda,TRUE));
//no_nahoda= 1+d20();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOOT,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOOT,no_nahoda,TRUE));
//no_nahoda= 13+d6();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHIN,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHIN,no_nahoda,TRUE));
//no_nahoda= 1+d10();
no_nahoda= d100();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LTHIGH,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RTHIGH,no_nahoda,TRUE));

no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,no_nahoda,TRUE));

}
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "he"){
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_SIMPLE_MODEL,ITEM_APPR_ARMOR_MODEL_BELT,d20(),TRUE));
}
///vygenrovano poprve

//////// generujeme tolikrat, dokud ta soucast nebude mit tkaovej vzhled, kterej je platnej
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")& (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
{
while (GetIsObjectValid(no_Item_modified)==FALSE) {
{
no_nahoda= d6();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_PELVIS,7+d2(),TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_BELT,no_nahoda,TRUE));
no_nahoda= 1+d10();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LHAND,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RHAND,no_nahoda,TRUE));
no_nahoda= d10();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_NECK,no_nahoda,TRUE));
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOREARM,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOREARM,no_nahoda,TRUE));
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LBICEP,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RBICEP,no_nahoda,TRUE));
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHOULDER,no_nahoda,TRUE));
//no_nahoda= 1+d20();
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOOT,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOOT,no_nahoda,TRUE));
//no_nahoda= 13+d6();
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHIN,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHIN,no_nahoda,TRUE));
//no_nahoda= 1+d10();
no_nahoda= d20();
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LTHIGH,no_nahoda,TRUE));
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RTHIGH,no_nahoda,TRUE));

no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,no_nahoda,TRUE));
no_nahoda= d100() + d20() ;
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item_modified,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,no_nahoda,TRUE));

} }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "he"){
DestroyObject(no_Item_modified = CopyItemAndModify(no_Item,ITEM_APPR_TYPE_SIMPLE_MODEL,ITEM_APPR_ARMOR_MODEL_BELT,d20() + d20(),TRUE));
}

} //konec while

//kvuli tomu, at se to zkopiruje a nezmizi :D
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "bo"){
no_Item_modified =no_Item;
}
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "ru"){
no_Item_modified =no_Item;
}




no_Item = CopyItem(no_Item_modified,no_oPC,TRUE);
no_udelejjmeno(no_Item);
no_vynikajicikus(no_Item);
}


void no_udelejzbroj(object no_pec)
{
if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Vyrabim zbroj" );

///no_zb_XX_01_02_03_4
///01 - no_kov_1  02-no_kov_procenta  03-no_kov_2  4-no_druh_nasada

int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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
if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame kov1=kov2, nastavuju max. pocet %" );
}

if (GetLocalInt(no_pec,"no_kov_procenta")  == no_menu_max_procent )
{
SetLocalInt(no_pec,"no_kov_2",GetLocalInt(no_pec,"no_kov_1"));
if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame max.procent,at to nemate, nastavuju kov2, na hodnotu kov1" );
}

no_bonus_vylepseni = 0;

///vyrobime zbran no_Item na OVJECT:SELF, protoze ji zmodifikujem a az pak dame hraci..
no_Item=CreateItemOnObject("no_pl_" + GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),OBJECT_SELF,1,"no_pl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_procenta")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_druh_kuze") );

// do tohohle budem ukladat, jak se meni enchentamnet bonus a pridame ho tam az na konci.

// pridavame podle kovu procenta.
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_kov_1"),GetLocalInt(no_pec,"no_kov_procenta") );

//kdyz neni druhy jako prvni material, tak udelame maxprocenta-hl.mat.procenta vlastnosti.
if  (GetLocalInt(no_pec,"no_kov_procenta")  != no_menu_max_procent )  {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_kov_2"),no_menu_max_procent - GetLocalInt(no_pec,"no_kov_procenta") );
}

//podla typu koze sa nastavi maximalne AC
/*switch ( GetLocalInt(OBJECT_SELF,"no_druh_kuze")) {
case 1: {   if ( no_bonus_vylepseni >0 ){
            no_bonus_vylepseni = 0;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi" ,no_oPC,FALSE);   }
            break;}
case 2: {   if ( no_bonus_vylepseni >1 ){
            no_bonus_vylepseni = 1;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi",no_oPC,FALSE );   }
            if ( no_bonus_vylepseni <1 ){
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,1),no_Item);
            FloatingTextStringOnCreature(" Hm, takhle kvalitni kuze nebyla az tak zbytecna",no_oPC,FALSE );   }

            break;}
case 3: {   if ( no_bonus_vylepseni >2 ){
            no_bonus_vylepseni = 2;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi",no_oPC,FALSE );   }
            if ( no_bonus_vylepseni <1 ){
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,2),no_Item);
            FloatingTextStringOnCreature(" Hm, takhle kvalitni kuze nebyla az tak zbytecna",no_oPC,FALSE );   }

            break;}
case 4: {   if ( no_bonus_vylepseni >3 ){
            no_bonus_vylepseni = 3;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi" ,no_oPC,FALSE);   }
            if ( no_bonus_vylepseni <1 ){
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_BLUDGEONING,1),no_Item);
            FloatingTextStringOnCreature(" Hm, takhle kvalitni kuze nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 5: {   if ( no_bonus_vylepseni >4 ){
            no_bonus_vylepseni = 4;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi" ,no_oPC,FALSE);   }
            if ( no_bonus_vylepseni <2 ){
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_BLUDGEONING,2),no_Item);
            FloatingTextStringOnCreature(" Hm, takhle kvalitni kuze nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
case 6: {   if ( no_bonus_vylepseni >5 ){
            //no_bonus_vylepseni = 5;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledek budu potrebovat lepsi kuzi",no_oPC,FALSE );   }
            if ( no_bonus_vylepseni <3 ){
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_BLUDGEONING,3),no_Item);
            FloatingTextStringOnCreature(" Hm, takhle kvalitni kuze nebyla az tak zbytecna",no_oPC,FALSE );   }
            break;}
} */ // pri soucasnem nastaven NT zbytecne //konec switche nasady

//podla typu no_kov_1 sa nastavi maximalne AC
switch ( GetLocalInt(no_pec,"no_kov_1")) {
case 1: {   if ( no_bonus_vylepseni >0 ){
            no_bonus_vylepseni = 0;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 2: {   if ( no_bonus_vylepseni >0 ){
            no_bonus_vylepseni = 0;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 3: {   if ( no_bonus_vylepseni >1 ){
            no_bonus_vylepseni = 1;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 4: {   if ( no_bonus_vylepseni >2 ){
            no_bonus_vylepseni = 2;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 5: {   }
case 6: {   }
case 7: {   if ( no_bonus_vylepseni >3 ){
            no_bonus_vylepseni = 3;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 8: {   if ( no_bonus_vylepseni >4 ){
            no_bonus_vylepseni = 4;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 9: {   if ( no_bonus_vylepseni >3 ){
            no_bonus_vylepseni = 3;
            FloatingTextStringOnCreature(" Safra, pro lepsi vysledok budes potrebovat lepsi vacsinovy material" ,no_oPC,FALSE);   }
            break;}
case 10:{   }
case 11: {  if ( no_bonus_vylepseni >5 ){
            no_bonus_vylepseni = 5; }
            break;}
case 12: {  if ( no_bonus_vylepseni >5 ){
            no_bonus_vylepseni = 5; }
            break;}
} //konec switche no_kov_1


if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame soak bonus= " + IntToString(no_soak_bonus) );
if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame vylepseni= " + IntToString(no_bonus_vylepseni) );
if (no_bonus_vylepseni>0) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(no_bonus_vylepseni),no_Item);

//vsechny zbroje s  +1 AC a vys maji 5/+1 redukci
/*if (( no_soak_bonus == 0)&( no_bonus_vylepseni<0)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
{
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP),no_Item);
} */ //Karolina 25.4.2016 - projevuje se to na zbrojch mimo tabulku, +1/5hp nikoho nevytrhne a zbytecne to zveda ILR
//
//if (( no_soak_bonus < 2)&( no_bonus_vylepseni==2)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
//{
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//}
/*if (( no_soak_bonus < 1)&( no_bonus_vylepseni>0)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
{ no_soak_bonus = 1;  }*/
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//}
if ( no_soak_bonus ==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_5_HP),no_Item);
if ( no_soak_bonus ==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
if ( no_soak_bonus ==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_10_HP),no_Item);
if ( no_soak_bonus ==4) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_5_HP),no_Item);
if ( no_soak_bonus ==5) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_10_HP),no_Item);
if ( no_soak_bonus ==6) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_10_HP),no_Item);
if ( no_soak_bonus ==7) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_6,IP_CONST_DAMAGESOAK_10_HP),no_Item);
if ( no_soak_bonus ==8) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_8,IP_CONST_DAMAGESOAK_5_HP),no_Item);
if ( no_soak_bonus ==9) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_9,IP_CONST_DAMAGESOAK_5_HP),no_Item);
if ( no_soak_bonus >9) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_10,IP_CONST_DAMAGESOAK_5_HP),no_Item);
}
if (no_bonus_vylepseni<0) {
//obracime, protoge penalty je kladne cislo.
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR,0 - no_bonus_vylepseni),no_Item);
}

///titan ma soak bonusy !!!  //edit 2. cervence  - radsi to zrusim. nemuzu to otestovat
//if (( no_soak_bonus > 0)&( no_bonus_vylepseni<no_soak_bonus)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
//{
//if (no_soak_bonus==1) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//if (no_soak_bonus==2) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//if (no_soak_bonus==3) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//if (no_soak_bonus==4) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//if (no_soak_bonus==5) AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_5_HP),no_Item);
//}


//vsechny zbroje maj + do vycviku, ale nektere vice :D
if ((GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he"))
{
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,no_disciple),no_Item);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,2),no_Item);
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,3),no_Item);
         }
else  {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,(no_disciple-1)),no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_MOVE_SILENTLY,2),no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_HIDE,2),no_Item);
        }
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "he") {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_SEARCH,2),no_Item);
         }
//if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")== "ru") {
  //      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseSkill(SKILL_DISABLE_TRAP,2),no_Item);
    //   }
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(SKILL_DISCIPLINE,no_disciple+no_bonus_vylepseni),no_Item);

//dublovani z 2.4.2010
//if (( no_soak_bonus == 1)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")) {
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_5_HP),no_Item);    }
//if (( no_soak_bonus == 2)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")){
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_2,IP_CONST_DAMAGESOAK_5_HP),no_Item);    }
//if (( no_soak_bonus == 3)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")){
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_3,IP_CONST_DAMAGESOAK_5_HP),no_Item);    }
//if (( no_soak_bonus == 4)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")){
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_4,IP_CONST_DAMAGESOAK_5_HP),no_Item);    }
//if (( no_soak_bonus == 5)&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "ru")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "bo")&(GetLocalString(OBJECT_SELF,"no_druh_vyrobku")!= "he")){
//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_5,IP_CONST_DAMAGESOAK_5_HP),no_Item);    }



/*if (( no_vulnear_elektrika < 9)& ( no_vulnear_elektrika >= 0)) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_5_PERCENT),no_Item);
}
else if   (( no_vulnear_elektrika < 26)& ( no_vulnear_elektrika >= 10)){
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_10_PERCENT),no_Item);
}
else if   (( no_vulnear_elektrika < 51)& ( no_vulnear_elektrika >= 25))  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),no_Item);
}
else if   (( no_vulnear_elektrika < 76)& ( no_vulnear_elektrika >= 50)) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),no_Item);
}
else if   (( no_vulnear_elektrika < 91)& ( no_vulnear_elektrika >= 75))  {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_75_PERCENT),no_Item);
}
else if   (( no_vulnear_elektrika < 100)& ( no_vulnear_elektrika >= 90)){
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEVULNERABILITY_90_PERCENT),no_Item);
}*/



if (no_decrease_obratnost == 1) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,1), no_Item);
}
if (no_decrease_obratnost == 2) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,2), no_Item);
}
if (no_decrease_obratnost == 3) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,3), no_Item);
}
if (no_decrease_obratnost == 4) {
AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,4), no_Item);
}



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
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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
if (NO_pl_DEBUG == TRUE) { SendMessageToPC(no_oPC,"%hl mat = max%, nastavuju vedlmat=hlmat." );
                        }
}

if ((GetLocalInt(OBJECT_SELF,"no_hl_proc"))  < no_menu_max_procent/2 )
{
int no_menu_hlavni_material = GetLocalInt(no_pec,"no_hl_mat");
//jinak nepozna, ze ktereho stacku ma odecist pruty
SetLocalInt(no_pec,"no_hl_mat",GetLocalInt(no_pec,"no_ve_mat"));
SetLocalInt(no_pec,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc") ));
SetLocalInt(no_pec,"no_ve_mat",no_menu_hlavni_material);
if (NO_pl_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Kvuli prutum prehazuju vedl s hlavnim" );   }
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




void no_prisada(object no_Item, object no_pec, int no_mazani)
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetResRef(no_Item),11) == "no_pl_pris_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_pl_pris_01")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_prisada",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_pl_pris_02")
    { SetLocalInt(no_pec,"no_prisada",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_pl_pris_03")
    { SetLocalInt(no_pec,"no_prisada",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_04")
    { SetLocalInt(no_pec,"no_prisada",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_05")
    { SetLocalInt(no_pec,"no_prisada",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_06")
    { SetLocalInt(no_pec,"no_prisada",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_07")
    { SetLocalInt(no_pec,"no_prisada",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_08")
    { SetLocalInt(no_pec,"no_prisada",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_09")
    { SetLocalInt(no_pec,"no_prisada",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_10")
    { SetLocalInt(no_pec,"no_prisada",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_11")
    { SetLocalInt(no_pec,"no_prisada",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_pl_pris_12")
    { SetLocalInt(no_pec,"no_prisada",12);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame prisady
}


void no_kuze(object no_Item,object no_pec, int no_mazani)
// napise pekne na pec cislo nasady.
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {


 if(GetStringLeft(GetResRef(no_Item),8) == "tc_kuze_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetResRef(no_Item) == "tc_kuze_obyc")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_kuze",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetResRef(no_Item) == "tc_kuze_leps")
    { SetLocalInt(no_pec,"no_kuze",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetResRef(no_Item) == "tc_kuze_kval")
    { SetLocalInt(no_pec,"no_kuze",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_kuze_mist")
    { SetLocalInt(no_pec,"no_kuze",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_kuze_velm")
    { SetLocalInt(no_pec,"no_kuze",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetResRef(no_Item) == "tc_kuze_lege")
    { SetLocalInt(no_pec,"no_kuze",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
  }  //konec if resref kuze
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame nasadu
}


void no_vyrobek (object no_Item, object no_pec, int no_mazani)
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if((GetStringLeft(GetResRef(no_Item),6) == "no_pl_")& (GetStringLeft(GetResRef(no_Item),10) != "no_pl_pris"))
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
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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
if (NO_pl_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Reknutim co to je za material prehazujem" );   }
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
if (NO_pl_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta=" + no_menu_nazev_procenta );}

no_menu_nazev_procenta2 =IntToString( 10*no_menu_max_procent - StringToInt(no_menu_nazev_procenta));

if (NO_pl_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta2=" + no_menu_nazev_procenta2 );}

if ((no_menu_nazev_kovu!=no_menu_nazev_kovu2)&(StringToInt(no_menu_nazev_procenta)!=10*no_menu_max_procent))  {

FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu + " a " + no_menu_nazev_procenta2 + "%" + no_menu_nazev_kovu2,no_oPC,FALSE );
}
if  ((no_menu_nazev_kovu==no_menu_nazev_kovu2) || (StringToInt(no_menu_nazev_procenta)==10*no_menu_max_procent)) {
no_menu_nazev_procenta = IntToString(10*no_menu_max_procent);
FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu ,no_oPC,FALSE );
if (NO_pl_DEBUG == TRUE) {SendMessageToPC(no_oPC,"(no_menu_nazev_procenta2== 0");}
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

AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9, 1.5, no_pl_delay));

    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_pl_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_pl_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));

// PlaySound("al_mg_crystalic1");
}


void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item)
//////////////prida procenta nehotovym vrobkum/////////////////////////////////
{string no_tag_vyrobku = GetTag(no_Item);

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_platner);}

 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
         string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

DestroyObject(no_Item);
no_Item = CreateItemOnObject("no_polot_pl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
no_udelejjmeno(no_Item);
SetName(no_Item,GetName(no_Item) + "  *"+ no_nazev_procenta + "%*");
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_pl_clos_kov",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si vyrobu" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }

}


///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_pl (object no_oPC, object no_pec)
{
int no_druh=0;
int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33

if ( NO_pl_DEBUG == TRUE )  no_level=no_level+10;
if  (GetIsDM(no_oPC)== TRUE) no_level=no_level+20;

no_Item = GetFirstItemInInventory(no_pec);

while (GetIsObjectValid(no_Item)) {
if  (GetResRef(no_Item) == "no_polot_pl")
        {
        no_zjistiobsah(GetTag(no_Item));
        break;
        }//pokud resref = no_polot_zb      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
 }    /// konec while

/// davam to radsi uz sem, bo se pak i podle toho nastavuje cena..
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") no_DC = 20;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "hr") no_DC = 22;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "de") no_DC = 25;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pu") no_DC = 27;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pl") no_DC = 30;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "he") no_DC = 13;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "bo") no_DC = 10;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "ru") no_DC = 7;

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


if (GetLocalInt(OBJECT_SELF,"no_druh_kuze") == 0 ) {
//to znamena, ze zatim nemame hotovo
no_DC = no_DC + (GetLocalInt(OBJECT_SELF,"no_kov_procenta")*GetLocalInt(OBJECT_SELF,"no_kov_1"))/4 + (( no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_kov_procenta"))*GetLocalInt(OBJECT_SELF,"no_kov_2"))/4 - 10*no_level;
// = max. 30+ (20*12)/4 + (0*12)/4 = 85  //tzn 9lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_kov_1"));
//no_druh = 1212   = meteocel+meteocel
}

if (GetLocalInt(OBJECT_SELF,"no_druh_kuze") != 0 ) {
//to znamena, ze budemem mit hotovo
no_DC = 6+ no_DC + ((GetLocalInt(OBJECT_SELF,"no_kov_procenta")*GetLocalInt(OBJECT_SELF,"no_kov_1")))/2 + (((no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_kov_procenta"))*GetLocalInt(OBJECT_SELF,"no_kov_2")))/2 + (13*GetLocalInt(OBJECT_SELF,"no_druh_kuze"))/2 - 10*no_level;
// = 5+ max. 30+ (20*12)/2 + (0*12)/2 + (10*8)/2 = 195  //tzn 20lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_kov_1") + GetLocalString(OBJECT_SELF,"no_kov_2")+ GetLocalString(OBJECT_SELF,"no_druh_kuze"));
//no_druh = 11021   = stinova ocel + med + vrba
}




if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"no_druh= " + IntToString(no_druh));


if (no_druh>0 ) {


// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
        if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();

 if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));


if (no_hod <= no_chance ) {

        float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");

        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
                         TC_setXPbyDifficulty(no_oPC,TC_platner,no_chance,TC_dej_vlastnost(TC_platner,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_platner,no_chance,TC_dej_vlastnost(TC_platner,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

 /*           if (no_obtiznost_vyrobku >=190) {
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
            if (NO_pl_DEBUG == TRUE)  no_procenta = no_procenta + 30.0;


        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej
        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek

 DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
// if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                        if (no_druh < 13) { //nedodelana zbran
                        no_Item=CreateItemOnObject("no_pl_" + GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),no_oPC,1,"no_pl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_procenta")+ "_"+ GetLocalString(OBJECT_SELF,"no_kov_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_druh_kuze") );
                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_ARMOR,5),no_Item);
                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDecreaseAbility(IP_CONST_ABILITY_DEX,10),no_Item);
                        no_udelejjmeno(no_Item);
                        no_cenavyrobku(no_Item);   }
    ///////////// dodelame zbran uplne /////////////////////////////////////////////
                        if ((no_druh > 13)& (no_druh < 12129 ) )
                        {    no_udelejzbroj(no_pec);    }
/// }////////////////// konec dodelavky zbrane ///////////////////////////////



                        }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej
        no_vytvorprocenta(no_oPC,no_procenta,no_Item);
          }// kdyz neni 100%
        SendMessageToPC(no_oPC,"===================================");

       } /// konec, kdyz sme byli uspesni

else if (no_hod > no_chance )  {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////
        //// int no_procenta = GetLocalInt(no_Item,"no_suse_proc") - 20 - d20(3) ;
        ////////////////////////////////////////////////////////////////////////////

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

if (NO_pl_DEBUG == TRUE) SendMessageToPC(no_oPC, "Ubirame z " + FloatToString(GetLocalFloat(no_Item,"no_suse_proc")) +"na:" + FloatToString(no_procenta));

         if (no_procenta <= 0.0 ){
         DestroyObject(no_Item);

 DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

         FloatingTextStringOnCreature("Vyrobek se rozpadl",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) {FloatingTextStringOnCreature("Na vykovku se objevili okuje",no_oPC,FALSE ); }

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu
        if (no_procenta > 0.0 ) {
         no_vytvorprocenta(no_oPC,no_procenta,no_Item);
                            }



         }//konec else no_hod >no_chance

         }// konec kdyz jsme meli nejakej no_druh

}    ////konec no_xp_zb




void no_xp_pridej_kuzi(object no_oPC, object no_pec)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
no_zjistiobsah(GetLocalString(no_pec,"no_vyrobek"));
//podle tagu veci zjisti kolik je kovu a takovy ty pitomosti + jejich cislo a ulozi je na OBJECT_SELF

//int no_prisadovy_material = GetLocalInt(no_pec,"no_hl_mat");
// kdyz je mensi, nez 60, tak to znamena, ze potrebujeme spravnejsi prisadu
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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
if (NO_pl_DEBUG == TRUE) SendMessageToPC(no_oPC, "potrebujem prisadu vedlejsiho materialu");
}

if (GetLocalInt(no_pec,"no_kuze") ==0)  FloatingTextStringOnCreature("Bude potreba kuze !",no_oPC,FALSE);
if (GetLocalInt(no_pec,"no_prisada") ==0) FloatingTextStringOnCreature("Bude potreba platnerska prisada !",no_oPC,FALSE);
if ((GetLocalInt(no_pec,"no_prisada")!=no_prisadovy_material)& (GetLocalInt(no_pec,"no_prisada") !=0)) FloatingTextStringOnCreature("Potrebujes platnerskou prisadu kovu, ktereho je tam vice !",no_oPC,FALSE);

//tak, kdyz mame vsechno spravne, tak udelame :
if ((GetLocalInt(no_pec,"no_kuze") != 0 ) & ( GetLocalInt(no_pec,"no_prisada")==no_prisadovy_material))
{
            if (NO_pl_DEBUG == TRUE) SendMessageToPC(no_oPC, "polotovar: no_pl_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kov_1")+ "_" + GetLocalString(no_pec,"no_kov_procenta")+"_" + GetLocalString(no_pec,"no_kov_2")+ "_"+IntToString(GetLocalInt(no_pec,"no_kuze")));
            SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kov_1")+ "_" + GetLocalString(no_pec,"no_kov_procenta")+"_" + GetLocalString(no_pec,"no_kov_2")+ "_"+IntToString(GetLocalInt(no_pec,"no_kuze"))),"no_suse_proc",10.0);
            no_zamkni(no_oPC);
            no_prisada(no_Item,OBJECT_SELF,TRUE);
            no_vyrobek(no_Item,OBJECT_SELF,TRUE);
            no_kuze(no_Item,OBJECT_SELF,TRUE);
            DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));

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

if (NO_pl_DEBUG == TRUE) SendMessageToPC(no_oPC, "polotovar: no_pl_XX_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0");

////////////////////////////////////////////////////////////////////////////////////////////
//////////////takovej male pozmeneni zadanych veci, bo kdo to zacne, tak to dopadne.///////////
//////////////////////////////////////////////////////////////////////////////////////////////
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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

if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame kov1=kov2, nastavuju max= " + no_tag3+ "0%" );
}

if (GetLocalInt(OBJECT_SELF,"no_hl_proc")  == no_menu_max_procent )
{
no_tag2 = no_tag;
//jinak nepozna, ze ktereho stacku ma odecist pruty
SetLocalInt(no_pec,"no_ve_mat",GetLocalInt(no_pec,"no_hl_mat"));
if ( NO_pl_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Mame max.procent,at to nemate, nastavuju kov2, na hodnotu kov1" );
}
///////////////////////////////////////////////////////////////////////////////////
/////////////////////////
//no_menu:
//1 - Vyroba krouzkova     tag: no_vyr_krouz
//2 - Vyroba hrudni krunyr tag: no_vyr_hrudn
//3 - Vyroba destickova    tag: no_vyr_desti
//4 - Vyroba pulplatova    tag: no_vyr_pulpl
//5 - Vyroba plnaplatova   tag: no_vyr_plnpl
//6 - Vyroba helma         tag: no_vyr_helma
//7 - Vyroba ok.boty       tag: no_vyr_okbot
//8 - Vyroba ok.rukavice   tag: no_vyr_okruk
//9 - vyber  materialu     tag: no_men_mater
//0  - Zpet do menu        tag: no_zpet

switch (GetLocalInt(OBJECT_SELF,"no_menu")) {
        case 1:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_kr_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;
                    }
        case 2:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_hr_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 3:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_de_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 4:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_pu_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 5:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_pl_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 6:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_he_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 7:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_bo_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}
        case 8:   {
                    SetLocalFloat(CreateItemOnObject("no_polot_pl",no_pec,1,"no_pl_ru_" + no_tag + "_" + no_tag3 + "_" + no_tag2 + "_0"),"no_suse_proc",10.0);
                    no_zamkni(no_oPC);
                    DelayCommand(no_pl_delay,no_xp_pl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
                    break;}

        } //konec switche

 }//if spravne kovy


else // ((( (GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))   ||  ( ((GetLocalInt(OBJECT_SELF, "no_pouzitykov2")==GetLocalInt(OBJECT_SELF, "no_hl_mat"))&( GetLocalInt(OBJECT_SELF, "no_pouzitykov1")==GetLocalInt(OBJECT_SELF, "no_ve_mat"))))                   )
{FloatingTextStringOnCreature("Je treba do kovadliny umistit dva spravne ingoty kovu !",no_oPC,FALSE );
}

} // konec vyrob polotovar


void no_men_vzhled_dalsi(object no_oPC)
{

SetLocalInt (OBJECT_SELF, "no_stit_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",1);
if (GetBaseItemType(oItem) ==BASE_ITEM_LARGESHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",2);
if (GetBaseItemType(oItem) ==BASE_ITEM_TOWERSHIELD)  SetLocalInt (OBJECT_SELF, "no_stit_typ",3);

if (GetLocalInt(OBJECT_SELF,"no_stit_typ") >0 )  {

int x = GetLocalInt(OBJECT_SELF,"no_vzhled_stitu");
//FloatingTextStringOnCreature(" Stary vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
x ++;

//object no_Item_change  = CopyItem( oItem,OBJECT_SELF,  TRUE );

DestroyObject(oItem);

//Preskakovat  - 22.01.2017
//malý štít  0-10,20,26-30,40,50,60,65-85, 89-124, 132-255
//velké štíty: 0-10,20,30,36-40,50,89,110,120,130,150
//pavézy: 0-10,20,24-30,40,50,120,130,140,150,154-180,231,235-255

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==20))  ) x = 21;      //SH - OK
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=30)&(x>=26))  ) x = 31;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==40))  ) x = 41;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==50))  ) x = 51;;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=85)&(x>=65))  ) x = 86;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=124)&(x>=89))  ) x = 125;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==20))  ) x = 21;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==30))  ) x = 31;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x<=40)&(x>=36))  ) x = 41;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==50))  ) x = 51;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==89))  ) x = 90;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==110))  ) x = 111;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==120))  ) x = 121;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==130))  ) x = 131;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==150))  ) x = 151;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==20))  ) x = 21;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x<=30)&(x>=24))  ) x = 31;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==40))  ) x = 41;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==50))  ) x = 51;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==120))  ) x = 121;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==130))  ) x = 131;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==140))  ) x = 141;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==150))  ) x = 151;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x<=180)&(x>=154))  ) x = 181;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==231))  ) x = 232;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x>=132) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x>=241) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x>=235) ) x = 1;

/////1 = ignored
object no_item_modify;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,no_oPC ,FALSE);


while ( GetIsObjectValid(no_item_modify) == FALSE ) {
//FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
DestroyObject(no_item_modify);
x = x+1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x>=132) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x>=241) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x>=235) ) x = 1;

no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
//FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+5;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {

FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x>=132) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x>=241) ) x = 1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x>=235) ) x = 1;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}




if ( GetIsObjectValid(no_item_modify) == FALSE ) {
FloatingTextStringOnCreature("Chyba vzhledu predmetu !!! nahlasit chybu ve vzhledu: " + IntToString(x) , no_oPC ,FALSE);
//object nahradni_stit = GetLocalObject(OBJECT_SELF, "no_" + GetName( no_oPC));
//SetLocalObject(OBJECT_SELF, "no_" + GetName(no_oPC) ,OBJECT_SELF);
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,1, TRUE);
}


//oItem = CopyItem(no_Item_change,GetPCSpeaker(),  TRUE );
//DestroyObject(no_Item_change);
AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(no_item_modify,INVENTORY_SLOT_LEFTHAND)));

SetLocalInt(OBJECT_SELF,"no_vzhled_stitu",x);

}//kdyz mame stit v ruce


if (GetLocalInt(OBJECT_SELF,"no_stit_typ") == 0 )  {FloatingTextStringOnCreature("nemas v ruce zadny stit ! ",  no_oPC ,FALSE);}


}

void no_men_vzhled_predchozi(object no_oPC)
{


SetLocalInt (OBJECT_SELF, "no_stit_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",1);
if (GetBaseItemType(oItem) ==BASE_ITEM_LARGESHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",2);
if (GetBaseItemType(oItem) ==BASE_ITEM_TOWERSHIELD)  SetLocalInt (OBJECT_SELF, "no_stit_typ",3);

if (GetLocalInt(OBJECT_SELF,"no_stit_typ") >0 )  {

int x = GetLocalInt(OBJECT_SELF,"no_vzhled_stitu");
//FloatingTextStringOnCreature(" Stary vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
x = x-1;

//object no_Item_change  = CopyItem( oItem,OBJECT_SELF,  TRUE );

DestroyObject(oItem);

//Preskakovat  - 22.01.2017
//malý štít  0-10,20,26-30,40,50,60,65-85, 89-124, 132-255
//velké štíty: 0-10,20,30,36-40,50,89,110,120,130,150
//pavézy: 0-10,20,24-30,40,50,120,130,140,150,154-180,231,235-255

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==20))  ) x = 19;      //SH - OK
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=30)&(x>=26))  ) x = 25;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==40))  ) x = 39;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x==50))  ) x = 49;;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=85)&(x>=65))  ) x = 64;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & ((x<=124)&(x>=89))  ) x = 88;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==20))  ) x = 19;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==30))  ) x = 29;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x<=40)&(x>=36))  ) x = 35;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==50))  ) x = 49;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==89))  ) x = 88;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==110))  ) x = 109;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==120))  ) x = 119;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==130))  ) x = 129;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & ((x==150))  ) x = 149;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==20))  ) x = 19;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x<=30)&(x>=24))  ) x = 23;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==40))  ) x = 39;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==50))  ) x = 49;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==120))  ) x = 119;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==130))  ) x = 129;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==140))  ) x = 139;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==150))  ) x = 149;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x<=180)&(x>=154))  ) x = 153;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & ((x==231))  ) x = 230;

if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x<1) ) x = 131;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x<1) ) x = 240;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x<1) ) x = 234;
/////1 = ignored
object no_item_modify;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,no_oPC ,FALSE);


while ( GetIsObjectValid(no_item_modify) == FALSE ) {
//FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
DestroyObject(no_item_modify);
x = x+1;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x<1) ) x = 131;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x<1) ) x = 240;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x<1) ) x = 234;

no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
//FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-5;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {

FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 1) & (x<1) ) x = 131;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 2) & (x<1) ) x = 240;
if ( (GetLocalInt(OBJECT_SELF, "no_stit_typ") == 3) & (x<1) ) x = 234;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}




if ( GetIsObjectValid(no_item_modify) == FALSE ) {
FloatingTextStringOnCreature("Chyba vzhledu predmetu !!! nahlasit chybu ve vzhledu: " + IntToString(x) , no_oPC ,FALSE);
//object nahradni_stit = GetLocalObject(OBJECT_SELF, "no_" + GetName( no_oPC));
//SetLocalObject(OBJECT_SELF, "no_" + GetName(no_oPC) ,OBJECT_SELF);
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,1, TRUE);
}


//oItem = CopyItem(no_Item_change,GetPCSpeaker(),  TRUE );
//DestroyObject(no_Item_change);
AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(no_item_modify,INVENTORY_SLOT_LEFTHAND)));

SetLocalInt(OBJECT_SELF,"no_vzhled_stitu",x);

}//kdyz mame stit v ruce


if (GetLocalInt(OBJECT_SELF,"no_stit_typ") == 0 )  {FloatingTextStringOnCreature("nemas v ruce zadny stit ! ",  no_oPC ,FALSE);}


}

void no_men_vzhled_zapamatovat(object no_oPC)
{



SetLocalInt (OBJECT_SELF, "no_stit_typ",0);
SetLocalInt (OBJECT_SELF, "no_puvodni_vzhled_stitu",0);
object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",1);
if (GetBaseItemType(oItem) ==BASE_ITEM_LARGESHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",2);
if (GetBaseItemType(oItem) ==BASE_ITEM_TOWERSHIELD)  SetLocalInt (OBJECT_SELF, "no_stit_typ",3);

//timhle si ulozime stit primo k prekupnikovi
if (GetLocalInt(OBJECT_SELF,"no_stit_typ") >0 )   {

if ( GetIsObjectValid(oItem) == TRUE )     {
int no_apperance = GetItemAppearance(oItem,0,0);
SetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_stitu",no_apperance);

FloatingTextStringOnCreature(" Stit ulozen se vzhledem : " +IntToString(no_apperance) ,no_oPC,FALSE);

}  //konec kdyz true
} //konec stit typ
}  //konec procedury


void no_men_vzhled_puvodni(object no_oPC)
{

SetLocalInt (OBJECT_SELF, "no_stit_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",1);
if (GetBaseItemType(oItem) ==BASE_ITEM_LARGESHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",2);
if (GetBaseItemType(oItem) ==BASE_ITEM_TOWERSHIELD)  SetLocalInt (OBJECT_SELF, "no_stit_typ",3);

if (GetLocalInt(OBJECT_SELF,"no_stit_typ") >0 )  {
int x = GetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_stitu");
if (x==0) x= 1;
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature("Obnoven puvodni vzhled stitu !" , no_oPC ,FALSE);
AssignCommand( no_oPC,DelayCommand(0.1,ActionEquipItem(oItem,INVENTORY_SLOT_LEFTHAND)));
}
}



////////////helmy /////////////////////



void no_men_vzhled_helm_dalsi(object no_oPC)
{

SetLocalInt (OBJECT_SELF, "no_helm_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_HELMET) SetLocalInt (OBJECT_SELF, "no_helm_typ",1);


if (GetLocalInt(OBJECT_SELF,"no_helm_typ") >0 )  {

int x = GetLocalInt(OBJECT_SELF,"no_vzhled_helm");
//FloatingTextStringOnCreature(" Stary vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
x ++;

//object no_Item_change  = CopyItem( oItem,OBJECT_SELF,  TRUE );

DestroyObject(oItem);


if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x>80) ) x = 1;
if ( x == 34 ) x = 48;

/////1 = ignored
object no_item_modify;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,no_oPC ,FALSE);


while ( GetIsObjectValid(no_item_modify) == FALSE ) {
//FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
DestroyObject(no_item_modify);
x = x+1;
if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x>100) ) x = 1;

no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
//FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+5;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {

FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x+10;
if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x>80) ) x = 1;
if ( x == 34 ) x = 48;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}




if ( GetIsObjectValid(no_item_modify) == FALSE ) {
FloatingTextStringOnCreature("Chyba vzhledu predmetu !!! nahlasit chybu ve vzhledu: " + IntToString(x) , no_oPC ,FALSE);
//object nahradni_stit = GetLocalObject(OBJECT_SELF, "no_" + GetName( no_oPC));
//SetLocalObject(OBJECT_SELF, "no_" + GetName(no_oPC) ,OBJECT_SELF);
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,1, TRUE);
}


//oItem = CopyItem(no_Item_change,GetPCSpeaker(),  TRUE );
//DestroyObject(no_Item_change);
AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(no_item_modify,INVENTORY_SLOT_HEAD)));

SetLocalInt(OBJECT_SELF,"no_vzhled_helm",x);


}//kdyz mame stit v ruce


if (GetLocalInt(OBJECT_SELF,"no_helm_typ") == 0 )  {FloatingTextStringOnCreature("nemas na hlave zadnou helmu ! ",  no_oPC ,FALSE);}


}

void no_men_vzhled_helm_predchozi(object no_oPC)
{


// update 4_6_2014
//Helmice (bacha na vzhled kapuce, je to tusim 33)
//helm_001-032;047-082;84;85;96;101-105;107;119

SetLocalInt (OBJECT_SELF, "no_helm_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_HELMET) SetLocalInt (OBJECT_SELF, "no_helm_typ",1);

if (GetLocalInt(OBJECT_SELF,"no_helm_typ") >0 )  {

int x = GetLocalInt(OBJECT_SELF,"no_vzhled_helm");
//FloatingTextStringOnCreature(" Stary vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
x = x-1;

//object no_Item_change  = CopyItem( oItem,OBJECT_SELF,  TRUE );

DestroyObject(oItem);

if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x<1) ) x = 80;
if ( x == 47 ) x = 33;
/////1 = ignored
object no_item_modify;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,no_oPC ,FALSE);


while ( GetIsObjectValid(no_item_modify) == FALSE ) {
//FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
DestroyObject(no_item_modify);
x = x+1;
if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x<1) ) x = 80;
if ( x == 47 ) x = 33;

no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
//FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) ,GetPCSpeaker() ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-5;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}
if (GetIsObjectValid(oItem) == FALSE ) {
FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
}

if (GetIsObjectValid(oItem) == FALSE ) {

FloatingTextStringOnCreature(" Neplatny vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);
DestroyObject(oItem);
x = x-10;
if ( (GetLocalInt(OBJECT_SELF, "no_helm_typ") == 1) & (x<1) ) x = 80;
if ( x == 49 ) x = 33;
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature(" Novy vzhled cislo: " + IntToString(x) , no_oPC ,FALSE);

}




if ( GetIsObjectValid(no_item_modify) == FALSE ) {
FloatingTextStringOnCreature("Chyba vzhledu predmetu !!! nahlasit chybu ve vzhledu: " + IntToString(x) , no_oPC ,FALSE);
//object nahradni_stit = GetLocalObject(OBJECT_SELF, "no_" + GetName( no_oPC));
//SetLocalObject(OBJECT_SELF, "no_" + GetName(no_oPC) ,OBJECT_SELF);
no_item_modify = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,1, TRUE);
}


//oItem = CopyItem(no_Item_change,GetPCSpeaker(),  TRUE );
//DestroyObject(no_Item_change);
AssignCommand(no_oPC,DelayCommand(0.1,ActionEquipItem(no_item_modify,INVENTORY_SLOT_HEAD)));

SetLocalInt(OBJECT_SELF,"no_vzhled_helm",x);

}//kdyz mame stit v ruce


if (GetLocalInt(OBJECT_SELF,"no_helm_typ") == 0 )  {FloatingTextStringOnCreature("nemas na hlave zadnou helmu ! ",  no_oPC ,FALSE);}


}

void no_men_vzhled_helm_zapamatovat(object no_oPC)
{



SetLocalInt (OBJECT_SELF, "no_helm_typ",0);
SetLocalInt (OBJECT_SELF, "no_puvodni_vzhled_helm",0);
object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_HELMET) SetLocalInt (OBJECT_SELF, "no_helm_typ",1);


//timhle si ulozime stit primo k prekupnikovi
if (GetLocalInt(OBJECT_SELF,"no_helm_typ") >0 )   {

if ( GetIsObjectValid(oItem) == TRUE )     {
int no_apperance = GetItemAppearance(oItem,0,0);
SetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_helm",no_apperance);

FloatingTextStringOnCreature(" Helma ulozen se vzhledem : " +IntToString(no_apperance) ,no_oPC,FALSE);

}  //konec kdyz true
} //konec stit typ
}  //konec procedury


void no_men_vzhled_helm_puvodni(object no_oPC)
{

SetLocalInt (OBJECT_SELF, "no_helm_typ",0);

object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_helm_typ",1);


if (GetLocalInt(OBJECT_SELF,"no_helm_typ") >0 )  {
int x = GetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_helm");
if (x==0) x= 1;
DestroyObject(oItem);
oItem = CopyItemAndModify(oItem,ITEM_APPR_TYPE_SIMPLE_MODEL, 1,x, TRUE);
FloatingTextStringOnCreature("Obnoven puvodni vzhled helmy!" , no_oPC ,FALSE);
AssignCommand( no_oPC,DelayCommand(0.1,ActionEquipItem(oItem,INVENTORY_SLOT_LEFTHAND)));
}
}














