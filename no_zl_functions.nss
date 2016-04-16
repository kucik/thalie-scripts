#include "ku_libtime"
#include "tc_xpsystem_inc"
#include "no_nastcraft_ini"
#include "ku_items_inc"
#include "ku_persist_inc"


/////////////////////////////////////
///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - amulet-prsten/ 01 pouzity kov /02 1.sutr/ 03 2.sutr /04 procenta /

int no_pocet;
string no_nazev;
int no_DC;


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

void no_udelejprsten(object no_pec);
//udela vyrobek + mu udeli vlastnosti podle pouzitych prisad


void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_pouzitykamen(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_pouzitykov
void no_forma(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_drevo
void no_prisada(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_tetiva
void no_pouzitykov(object no_Item,object no_pec, int no_mazani);
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
void no_xp_zl (object no_oPC, object no_pec);

// prida jakemukoliv polotovaru nasadu, ktera je zrovna hozeny do kovadliny
void no_xp_pridej_kameny(object no_oPC, object no_pec);

//vyrobi polotovar se vsemi nutnymi tagy apod.
void no_xp_vyrobpolotovar(object no_oPC, object no_pec);

//////////////////////////////////////////////////////////////////////////////////////////
void no_pohybklikacu(object no_oPC, object no_pec);



/////////zacatek zavadeni funkci//////////////////////////////////////////////

void no_zjistiobsah(string no_tagveci)
///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /
{

string no_pouzitavec="";

SetLocalInt(OBJECT_SELF,"no_druh_vyrobku",0);
SetLocalString(OBJECT_SELF,"no_druh_vyrobku","");
SetLocalInt(OBJECT_SELF,"no_kovsperku",0);
SetLocalString(OBJECT_SELF,"no_kovsperku","");
SetLocalInt(OBJECT_SELF,"no_sutr_1",0);
SetLocalString(OBJECT_SELF,"no_sutr_1","");
SetLocalInt(OBJECT_SELF,"no_sutr_2",0);
SetLocalString(OBJECT_SELF,"no_sutr_2","");
SetLocalInt(OBJECT_SELF,"no_sutr_procenta",0);
SetLocalString(OBJECT_SELF,"no_sutr_procenta","");

string no_druh_vyrobku = GetStringLeft(no_tagveci,8);
// budem do nej ukaladat co to ma za tip
no_druh_vyrobku = GetStringRight(no_druh_vyrobku,2);

SetLocalString(OBJECT_SELF,"no_druh_vyrobku",no_druh_vyrobku);

/////zjistime pouzity no_kovsperku/////////////
no_pouzitavec = GetStringLeft(no_tagveci,11);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_kovsperku",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_kovsperku",(StringToInt(no_pouzitavec)));

/////zjistime no_sutr_1/////////////
no_pouzitavec = GetStringLeft(no_tagveci,14);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_sutr_1",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_sutr_1",(StringToInt(no_pouzitavec)));

/////zjistime no_sutr_2/////////////
no_pouzitavec = GetStringLeft(no_tagveci,17);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_sutr_2",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_sutr_2",(StringToInt(no_pouzitavec)));

/////zjistime no_sutr_procenta/////////////
no_pouzitavec = GetStringLeft(no_tagveci,20);
no_pouzitavec = GetStringRight(no_pouzitavec,2);
SetLocalString(OBJECT_SELF,"no_sutr_procenta",no_pouzitavec);
SetLocalInt(OBJECT_SELF,"no_sutr_procenta",(StringToInt(no_pouzitavec)));


//SetLocalInt(OBJECT_SELF,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_sutr_1")); // tam je ulozene cislo pridavaneho kamene
//SetLocalInt(OBJECT_SELF,"no_ve_mat",GetLocalInt(OBJECT_SELF,"no_sutr_2"));
//SetLocalInt(OBJECT_SELF,"no_hl_proc",GetLocalInt(OBJECT_SELF,"no_sutr_procenta"));


}////////konec no_zjisti_obsah



/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////udela jmeno celkoveho vyrobku at uz to je cokoliv///////////////////////////////
void  no_udelejjmeno(object no_Item)
{
no_zjistiobsah(GetTag(no_Item)); // prptoze pro meno to vetsinou potrebujem prenastavit.
string no_jmeno = "";

//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /
switch (GetLocalInt(OBJECT_SELF,"no_kovsperku"))  {
case 1: { no_jmeno = "Cinovy";
            break;    }
case 2: { no_jmeno = "Medeny";
            break;    }
case 3: { no_jmeno = "Vermajlovy";
            break;    }
case 4: { no_jmeno = "Zelezny";
            break;    }
case 5: { no_jmeno = "Zlaty";
            break;    }
case 6: { no_jmeno = "Platinovy";
            break;    }
case 7: { no_jmeno = "Mithrilovy";
            break;    }
case 8: { no_jmeno = "Adamtinovy";
            break;    }
case 9: { no_jmeno = "Titanovy";
            break;    }
case 10: { no_jmeno = "Stribrny";
            break;    }
case 11: { no_jmeno = "Stinoocelovy";
            break;    }
case 12: { no_jmeno = "Meteoriticky";
            break;    }
}//konec switche


if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pr") no_jmeno =no_jmeno + " prsten ";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "am") no_jmeno =no_jmeno + " amulet ";


switch (GetLocalInt(OBJECT_SELF,"no_sutr_1"))  {
case 1: { no_jmeno = no_jmeno + "s nefritem";
            break;    }
case 2: { no_jmeno = no_jmeno + "s malachitem";
            break;    }
case 3: { no_jmeno = no_jmeno + "s ohnivym achatem";
            break;    }
case 4: { no_jmeno = no_jmeno + "s aventurinem";
            break;    }
case 5: { no_jmeno = no_jmeno + "s fenelopem";
            break;    }
case 6: { no_jmeno = no_jmeno + "s ametystem";
            break;    }
case 7: { no_jmeno = no_jmeno + "s zivcem";
            break;    }
case 8: { no_jmeno = no_jmeno + "s granatem";
            break;    }
case 9: { no_jmeno = no_jmeno + "s alexandritem";
            break;    }
case 10: { no_jmeno =no_jmeno +  "s topazem";
            break;    }
case 11: { no_jmeno = no_jmeno + "se safirem";
            break;    }
case 12: { no_jmeno = no_jmeno + "s ohnivym opalem";
            break;    }
case 13: { no_jmeno = no_jmeno + "s diamantem";
            break;    }
case 14: { no_jmeno = no_jmeno + "s rubinem";
            break;    }
case 15: { no_jmeno = no_jmeno + "se smaragdem";
            break;    }

}//konec switche
//kdyz dva stejne kameny, dava se automaticky max. procent
if ( GetLocalInt(OBJECT_SELF,"no_sutr_1") != GetLocalInt(OBJECT_SELF,"no_sutr_2"))   {

switch (GetLocalInt(OBJECT_SELF,"no_sutr_2"))  {
case 1: { no_jmeno = no_jmeno + " a nefritem";
            break;    }
case 2: { no_jmeno = no_jmeno + " a malachitem";
            break;    }
case 3: { no_jmeno = no_jmeno + " a ohnivym achatem";
            break;    }
case 4: { no_jmeno = no_jmeno + " a aventurinem";
            break;    }
case 5: { no_jmeno = no_jmeno + " a fenelopem";
            break;    }
case 6: { no_jmeno = no_jmeno + " a ametystem";
            break;    }
case 7: { no_jmeno = no_jmeno + " a zivcem";
            break;    }
case 8: { no_jmeno = no_jmeno + " a granatem";
            break;    }
case 9: { no_jmeno = no_jmeno + " a alexandritem";
            break;    }
case 10: { no_jmeno =no_jmeno +  " a topazem";
            break;    }
case 11: { no_jmeno = no_jmeno + " a safirem";
            break;    }
case 12: { no_jmeno = no_jmeno + " a ohnivym opalem";
            break;    }
case 13: { no_jmeno = no_jmeno + " a diamantem";
            break;    }
case 14: { no_jmeno = no_jmeno + " a rubinem";
            break;    }
case 15: { no_jmeno = no_jmeno + " a smaragdem";
            break;    }


}//konec switche
}//konec ifu, kdyz ova stejne


SetName(no_Item,no_jmeno);


//////nastavi description predmetu //////////
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pr") no_jmeno ="tento prsten";
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "am") no_jmeno ="tento amulet";

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

ku_SetItemDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
//SetDescription(no_Item,"Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
//SetLocalString(no_Item,"no_popisek","Na tomto predmetu je vyryta poznamka: " + no_jmeno + " vyrobil " + GetName(no_oPC) + "." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
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

///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /
//kov
switch (GetLocalInt(OBJECT_SELF,"no_kovsperku")){
case 1: {no_cena_kuze = no_cena_tin;    //nahrano z no_nastcraft_ini
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

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pr") no_cena_kuze =no_cena_kuze + no_cena_mala;
if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "am") no_cena_kuze =no_cena_kuze + no_cena_stre;
//2 kov
switch (GetLocalInt(OBJECT_SELF,"no_sutr_1")){
case 1: {no_cena_kuze2 = no_cena_kame_1;    //nahrano z no_sl_inc
         break; }
case 2: {no_cena_kuze2 = no_cena_kame_7;
         break; }
case 3: {no_cena_kuze2 = no_cena_kame_2;
         break; }
case 4: {no_cena_kuze2 = no_cena_kame_14;
         break; }
case 5: {no_cena_kuze2 = no_cena_kame_4;
         break; }
case 6: {no_cena_kuze2 = no_cena_kame_3;
         break; }
case 7: {no_cena_kuze2 = no_cena_kame_15;
         break; }
case 8: {no_cena_kuze2 = no_cena_kame_11;
         break; }
case 9: {no_cena_kuze2 = no_cena_kame_13;
         break; }
case 10: {no_cena_kuze2 = no_cena_kame_10;
         break; }
case 11: {no_cena_kuze2 = no_cena_kame_8;
         break; }
case 12: {no_cena_kuze2 = no_cena_kame_9;
         break; }
case 13: {no_cena_kuze2 = no_cena_kame_5;
         break; }
case 14: {no_cena_kuze2 = no_cena_kame_6;
         break; }
case 15: {no_cena_kuze2 = no_cena_kame_12;
         break; }
}  //konec switche

switch (GetLocalInt(OBJECT_SELF,"no_sutr_2")){
case 1: {no_cena_kuze2 =no_cena_kuze2+ no_cena_kame_1;    //nahrano z no_sl_inc
         break; }
case 2: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_7;
         break; }
case 3: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_2;
         break; }
case 4: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_14;
         break; }
case 5: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_4;
         break; }
case 6: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_3;
         break; }
case 7: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_15;
         break; }
case 8: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_11;
         break; }
case 9: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_13;
         break; }
case 10: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_10;
         break; }
case 11: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_8;
         break; }
case 12: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_9;
         break; }
case 13: {no_cena_kuze2 =no_cena_kuze2+ no_cena_kame_5;
         break; }
case 14: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_6;
         break; }
case 15: {no_cena_kuze2 = no_cena_kuze2+no_cena_kame_12;
         break; }
}  //konec switche

switch (GetLocalInt(OBJECT_SELF,"no_kovsperku")){
case 1: {no_cena_kuze3 =no_cena_kov_zl1;
         break; }
case 2: {no_cena_kuze3 =no_cena_kov_zl2;
         break; }
case 3: {no_cena_kuze3 =no_cena_kov_zl3;
         break; }
case 4: {no_cena_kuze3 =no_cena_kov_zl4;
         break; }
case 5: {no_cena_kuze3 =no_cena_kov_zl5;
         break; }
case 6: {no_cena_kuze3 =no_cena_kov_zl6;
         break; }
case 7: {no_cena_kuze3 =no_cena_kov_zl7;
         break; }
case 8: {no_cena_kuze3 = no_cena_kov_zl8;
         break; }
case 9: {no_cena_kuze3 =no_cena_kov_zl9;
         break; }
case 10: {no_cena_kuze3 =no_cena_kov_zl10;
         break; }
case 11: {no_cena_kuze3 =no_cena_kov_zl11;
         break; }
case 12: {no_cena_kuze3 =no_cena_kov_zl12;
         break; }
}  //konec switche


/////////zisk externi /////////////////
if ( GetLocalInt(OBJECT_SELF,"no_sutr_1") ==0  ) {       //pouze kov + forma
SetLocalInt(no_Item,"tc_cena",FloatToInt(no_zl_nasobitel2*(1.0*no_cena_kuze) ));
}
if ( GetLocalInt(OBJECT_SELF,"no_sutr_1") !=0  ) {
SetLocalInt(no_Item,"tc_cena",FloatToInt(no_zl_nasobitel*(no_cena_kuze+no_cena_kuze2+ no_cena_kuze3) ));
}

if (no_zl_debug == TRUE) {SendMessageToPC (no_oPC,"nastavena cena :" + IntToString(GetLocalInt(no_Item,"tc_cena")) ); }

}   //konec no_udelejcenu



void no_vynikajicikus(object no_Item)
{
int no_random = d100() - TC_getLevel(no_oPC,TC_zlatnik);
if (no_random < (TC_dej_vlastnost(TC_zlatnik,no_oPC)/4+1) ) {
////sance vroby vyjimecneho kusu stoupa s lvlem craftera
if  (GetIsDM(no_oPC)== TRUE) no_random = no_random -50;//DM maji vetsi sanci vyjimecneho kusu
FloatingTextStringOnCreature("Podarilo se ti vyrobit vyjimecny kus !", no_oPC,TRUE);

no_random = Random(24)+1;

switch (no_random)  {
case 1: {
                   itemproperty no_ip = ItemPropertySkillBonus(SKILL_HEAL,1);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Lecitel'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                    break;}
case 2: {
                 itemproperty no_ip = ItemPropertySkillBonus(SKILL_PARRY,1);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                 SetName(no_Item,GetName(no_Item) + "  'Uhybny manevr'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 3: {
                    itemproperty no_ip = ItemPropertySkillBonus(SKILL_SEARCH,1);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Hledac'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 4: {
            itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1);
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Rychlovka'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 5: {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SPOT,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Lepsi oko'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 6: {
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1),no_Item);
            SetName(no_Item,GetName(no_Item) + "  'Nezlomna vule'");
            SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case  7: {
               itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,d2());
                AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                SetName(no_Item,GetName(no_Item) + "  'Uzemnovac'");
                SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 8:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_HIDE,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Schovka'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case  9:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_APPRAISE,2);
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Vyjednavac'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 10:  {
                itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Ucpavka usi'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 11:  {
                itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Bozsky stit'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 12:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Chorobo pryc'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 13:  {
                 itemproperty no_ip =ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Tvrda hlava'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 14:  {
                  itemproperty no_ip = ItemPropertyACBonusVsSAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,1);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Neutralizer'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 15:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nebojsa'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 16:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zimomrivec'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 17:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Smrto pryc'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 18:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Odolna kuze'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 19:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Chorobo pryc'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 20:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POSITIVE,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zivy stit'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 21:  {
                  itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Mrtvak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 22:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Nebojsa'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 23:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zachranar'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 24:  {
                 itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,2+d2());
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Mozkochran");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

         }//konec switche


       }//konec if vyjimecna vec se podari

}//konec veci navic

// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_sutr_co_pridavam, int no_sutr_pridame_procenta )
{
int no_bonus_vylepseni;
switch   (no_sutr_co_pridavam){
                                  //(GetLocalInt(OBJECT_SELF,"no_kovsperku"))
        case 1:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_WHITE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_WHITE),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,2),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_20),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGERESIST_25),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec nefritu
        case 2:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_BLUE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_BLUE),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_BLUE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,2),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_20),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGERESIST_25),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec malachit
        case 3:  {  switch (no_sutr_pridame_procenta) {
                       case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,2),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_20),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGERESIST_25),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec ohnivy achat
        case 4:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_GREEN),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_GREEN),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_GREEN),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ACID,2),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_5),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_10),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_15),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_20),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGERESIST_25),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                break;    }//konec aventurin
        case 5:  {  switch (no_sutr_pridame_procenta) {
                       case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_PURPLE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
               break;     }//konec fenelop
        case 6:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_BLUE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
               break;     }//konec ametyst
        case 7:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DISEASE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,6),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec zivec
        case 8:  {  switch (no_sutr_pridame_procenta) {
                         case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_GREEN),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,1),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,2),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,2),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,3),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,3),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,4),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,1),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,1),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,2),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,2),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,3),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
               break;     }//konec granat
        case 9:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
               break; }//konec alexandrit
        case 10:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_PURPLE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_SONIC,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec topaz
        case 11:  {  switch (no_sutr_pridame_procenta) {
                         case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_GREEN),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_MINDAFFECTING,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec safir
        case 12:  {  switch (no_sutr_pridame_procenta) {
                      case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POSITIVE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POSITIVE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec ohnivy opal

        case 13:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_NEGATIVE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec diamant

        case 14:  {  switch (no_sutr_pridame_procenta) {
                        case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,1),no_Item);
                                          }
                                    break;  }
                        case 4: { if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DIVINE,2),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,1),no_Item);
                                          }
                                    break;  }
                        case 6: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,1),no_Item);
                                    break;  }
                        case 8: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2),no_Item);
                                    break;  }
                        case 10: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,2),no_Item);
                                    break;  }
                        case 12: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,3),no_Item);
                                    break;  }
                        case 14: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,3),no_Item);
                                    break;  }
                        case 16: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4),no_Item);
                                    break;  }
                        case 18: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,4),no_Item);
                                    break;  }
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,5),no_Item);
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,6),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec rubín

        case 15:  {  switch (no_sutr_pridame_procenta) {
                         case 2: {   if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")<2 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_PURPLE),no_Item);
                                          }
                                          if ( GetLocalInt(OBJECT_SELF,"no_kovsperku")>1 ) {
                                    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,1),no_Item);
                                          }
                                    break;  }
                        case 4:{ if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(1),no_Item);
                                         }
                                     break;  }
                        case 6: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(1),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(1),no_Item);
                                         }
                                   break;  }
                        case 8: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(2),no_Item);
                                         }
                                    break;  }
                        case 10: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(2),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(2),no_Item);
                                         }
                                   break;  }
                        case 12: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(3),no_Item);
                                         }
                                   break;  }
                        case 14: {  if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(3),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(3),no_Item);
                                         }
                                    break;  }
                        case 16: {  if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                             AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                           }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(4),no_Item);
                                         }
                                    break;  }
                        case 18: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(4),no_Item);
                                         }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(4),no_Item);
                                         }
                                    break;  }
                        case 20: { if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyACBonus(5),no_Item);
                                         }
                                    if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(5),no_Item);
                                         }
                                    break;  }
                        case 22: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyRegeneration(5),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                break;    }//konec smaragd


}// switch no_kov_pridame_procenta


} //konec pridavani vlastnosti


void no_udelej_vzhled(object no_Item)
{
no_udelejjmeno(no_Item);
no_vynikajicikus(no_Item);
}


void no_udelejprsten(object no_pec)
{
if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC,"Vyrabim prsten" );

///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /

int no_level = TC_getLevel(no_oPC,TC_zlatnik);
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
if (GetLocalInt(no_pec,"no_sutr_1")  == GetLocalInt(no_pec,"no_sutr_2") )
{
SetLocalInt(no_pec,"no_kov_procenta",no_menu_max_procent);
if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC,"Mame kov1=kov2, nastavuju max. pocet %" );
}

//if (GetLocalInt(no_pec,"no_kov_procenta")  == no_menu_max_procent )
//{
//SetLocalInt(no_pec,"no_sutr_2",GetLocalInt(no_pec,"no_sutr_1"));
//if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC,"Mame max.procent,at to nemate, nastavuju kov2, na hodnotu kov1" );
//}

if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
 no_Item=CreateItemOnObject("no_zl_prst_" + GetLocalString(OBJECT_SELF,"no_kovsperku"),no_oPC,1,"no_zl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kovsperku")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_procenta") );
 }
if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
no_Item=CreateItemOnObject("no_zl_amul_" + GetLocalString(OBJECT_SELF,"no_kovsperku"),no_oPC,1,"no_zl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kovsperku")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_procenta") );
 }

                                                    //  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /
///vyrobime zbran no_Item na OVJECT:SELF, protoze ji zmodifikujem a az pak dame hraci..
//no_Item=CreateItemOnObject("no_zl_" + GetLocalString(OBJECT_SELF,"no_druh_vyrobku"),OBJECT_SELF,1,"no_zl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kovsperku")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_procenta") );


///// taaaaak tady se musi rozhodnout podle kovu, kolik max. % se tam vejde... :
switch (GetLocalInt(OBJECT_SELF,"no_kovsperku")) {
case 1: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              break;}}
case 2: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              break;}}
case 3: { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              break;}}
case 4:  { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              break;}}
case 5: { if (no_menu_max_procent> 6){
              no_menu_max_procent = 6;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 60%" ,no_oPC,FALSE );
              break;}}
case 6: { if (no_menu_max_procent> 8){
              no_menu_max_procent = 8;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 80%" ,no_oPC,FALSE );
             break;}}
case 7: { if (no_menu_max_procent> 10){
              no_menu_max_procent = 10;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 100%" ,no_oPC,FALSE );
              break;}}
case 8: { if (no_menu_max_procent> 12){
              no_menu_max_procent = 12;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 120%" ,no_oPC,FALSE );
              break;}}
case 9: { if (no_menu_max_procent> 14){
              no_menu_max_procent = 14;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 140%" ,no_oPC,FALSE );
              break;}}
case 10: { if (no_menu_max_procent> 16){
              no_menu_max_procent = 16;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 160%" ,no_oPC,FALSE );
              break;}}
case 11: { if (no_menu_max_procent> 18){
              no_menu_max_procent = 18;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 180%" ,no_oPC,FALSE );
              break;}}

}//konec switche




if ( GetLocalInt(no_pec,"no_sutr_procenta") > no_menu_max_procent ) {
//kdyz mame vice procent nastaveno, nez je upravene maximum, tak :
SetLocalInt(no_pec,"no_sutr_procenta",no_menu_max_procent);
}

//kdyz dva stejne kameny, dava se automaticky max. procent
if ( GetLocalInt(no_pec,"no_sutr_1") == GetLocalInt(no_pec,"no_sutr_2")) {
SetLocalInt(no_pec,"no_sutr_procenta",no_menu_max_procent);
SetLocalInt(no_pec,"no_sutr_2",0);
}



if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){   {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_sutr_1"),GetLocalInt(no_pec,"no_sutr_procenta") );  }
//kdyz neni druhy jako prvni material, tak udelame maxprocenta-hl.mat.procenta vlastnosti.
if  (GetLocalInt(no_pec,"no_sutr_procenta")  < no_menu_max_procent )  {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_sutr_2"),no_menu_max_procent - GetLocalInt(no_pec,"no_sutr_procenta") );
}
}//kdyz prsten

if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){  {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_sutr_1"),2+GetLocalInt(no_pec,"no_sutr_procenta") );   }
//kdyz neni druhy jako prvni material, tak udelame maxprocenta-hl.mat.procenta vlastnosti.
if  (GetLocalInt(no_pec,"no_sutr_procenta")  < no_menu_max_procent )  {
no_udelej_vlastnosti(GetLocalInt(no_pec,"no_sutr_2"),2+no_menu_max_procent - GetLocalInt(no_pec,"no_sutr_procenta") );
}
}//kdyz amulet

no_cenavyrobku(no_Item);
//zkusi nejak zmenit vzhled.
no_udelej_vzhled(no_Item);

}



/////////zacatek zavadeni funkci//////////////////////////////////////////////
void no_snizstack(object oItem, int no_mazani)
{
int no_stacksize = GetItemStackSize(oItem);      //zjisti kolik je toho ve stacku

if ((no_zl_debug == TRUE)& (no_mazani == TRUE)) { SendMessageToPC(no_oPC,"DELETE:jmeno predmetu: "+ GetName(oItem)+ " stack size:"+IntToString(no_stacksize) );
}


  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                           if (no_mazani == TRUE) DestroyObject(oItem);
                    }
  else   {  if (no_mazani == TRUE) { //DestroyObject(no_Item);
              //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
              SetItemStackSize(oItem,no_stacksize-1);
              } }
}


//////////////////////////////////////////////////////////////////////
//////////zacatek zjistovani co je vevnitr////////////////////////////
/////////////////////////////////////////////////////////////////////
void no_pouzitykamen(object no_Item, object no_pec, int no_mazani)
{
/////////////////musime nejdrive prenastavit, kdyby nahodou byl jen 1 material ///////
/////////////////////////////////////////////////////////////////////////////////////
int no_level = TC_getLevel(no_oPC,TC_zlatnik);
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
if (no_zl_debug == TRUE) { SendMessageToPC(no_oPC,"%hl mat = max%, nastavuju vedlmat=hlmat." );
                        }
}

//if ((GetLocalInt(OBJECT_SELF,"no_hl_proc"))  < no_menu_max_procent/2 )
//{
//int no_menu_hlavni_material = GetLocalInt(no_pec,"no_hl_mat");
//jinak nepozna, ze ktereho stacku ma odecist pruty
//SetLocalInt(no_pec,"no_hl_mat",GetLocalInt(no_pec,"no_ve_mat"));
//SetLocalInt(no_pec,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc") ));
//SetLocalInt(no_pec,"no_ve_mat",no_menu_hlavni_material);
//if (no_zl_debug == TRUE) { SendMessageToPC(no_oPC,"Kvuli prutum prehazuju vedl s hlavnim" );   }
//}

////////////////////////zacatek prohledavani/////////////////////////////////
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

 if (GetStringLeft(GetResRef(no_Item),10) != "cnrgemfine") {   //kdyz neni vylesteny kamen, nema vyznam hledat
 no_Item = GetNextItemInInventory(no_pec);
 continue;      }

 // if(GetStringLeft(GetResRef(no_Item),7) == "tc_prut"){
 //vsechny pruty takhle zacinaji urychli to procedura

       if(GetResRef(no_Item) == "cnrgemfine001")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",1);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==1)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",1);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",1);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==1) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                    }
                            //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "cnrgemfine007")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",2);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==2)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",2);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",2);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==2) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                            //znicime prisadu
    } //konec med

       if(GetResRef(no_Item) == "cnrgemfine002")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",3);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==3)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",3);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",3);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==3) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                    }
                            //znicime prisadu
    } //konec bronz

       if(GetResRef(no_Item) == "cnrgemfine014")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",4);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==4)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",4);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",4);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==4) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec zelezo

       if(GetResRef(no_Item) == "cnrgemfine004")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",5);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==5)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",5);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",5);
                no_snizstack(no_Item,no_mazani);

                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==5) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                            //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "cnrgemfine003")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",6);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==6)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",6);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",6);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==6) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine015")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",7);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==7)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",7);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",7);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==7) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014

                }
                              //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine011")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                   SetLocalInt(no_pec,"no_pouzitysutr1",8);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==8)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",8);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",8);
                no_snizstack(no_Item,no_mazani);

                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==8) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine013")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",9);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==9)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",9);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",9);
                no_snizstack(no_Item,no_mazani);

                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==9) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine010")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",10);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==10)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")))
                    {SetLocalInt(no_pec,"no_pouzitysutr2",10);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",10);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==10) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine008")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",11);

                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==11)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",11);
                    no_snizstack(no_Item,no_mazani);   }
                no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",11);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==11) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }
                             //znicime prisadu
    } //konec
       if(GetResRef(no_Item) == "cnrgemfine009")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",12);
                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==12)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",12);
                    no_snizstack(no_Item,no_mazani);   }
               no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",12);
                no_snizstack(no_Item,no_mazani);
                                      ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==12) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }

                        //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "cnrgemfine005")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",13);
                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==13)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",13);
                    no_snizstack(no_Item,no_mazani);   }
               no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",13);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==13) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }

                        //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "cnrgemfine006")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",14);
                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==14)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",14);
                    no_snizstack(no_Item,no_mazani);   }
               no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",14);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==14) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }

                        //znicime prisadu
    } //konec

       if(GetResRef(no_Item) == "cnrgemfine012")           //do promene no_osekane ulozime nazev prisady
    { if  (GetLocalInt(no_pec,"no_pouzitysutr1")==0) {
                SetLocalInt(no_pec,"no_pouzitysutr1",15);
                if  ( (GetItemStackSize(no_Item)>1) & (GetLocalInt(no_pec,"no_ve_mat")==15)& (GetLocalInt(no_pec,"no_hl_mat")==GetLocalInt(no_pec,"no_ve_mat")) )
                    {SetLocalInt(no_pec,"no_pouzitysutr2",15);
                    no_snizstack(no_Item,no_mazani);   }
               no_snizstack(no_Item,no_mazani);}
      else if (GetLocalInt(no_pec,"no_pouzitysutr1")!=0) {
                SetLocalInt(no_pec,"no_pouzitysutr2",15);
                no_snizstack(no_Item,no_mazani);
                                     ///zmena nomis 3.9.2014
                if  (GetLocalInt(no_pec,"no_ve_mat")==15) {no_snizstack(no_Item,no_mazani); }
                    //konec zmeny 3.9.2014
                }

                        //znicime prisadu
    } //konec


 // }  //konec if resref kamenu
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

 if(GetStringLeft(GetResRef(no_Item),9) == "no_prach_"){
 //vsechny pruty takhle zacinaji urychli to procedura
           if(GetTag(no_Item) == "no_prach_tin")           //do promene no_osekane ulozime nazev prisady
    { SetLocalInt(no_pec,"no_prisada",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_prach_copp")
    { SetLocalInt(no_pec,"no_prisada",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_prach_bron")
    { SetLocalInt(no_pec,"no_prisada",3);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_iron")
    { SetLocalInt(no_pec,"no_prisada",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_gold")
    { SetLocalInt(no_pec,"no_prisada",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_plat")
    { SetLocalInt(no_pec,"no_prisada",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_mith")
    { SetLocalInt(no_pec,"no_prisada",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_adam")
    { SetLocalInt(no_pec,"no_prisada",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_tita")
    { SetLocalInt(no_pec,"no_prisada",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_silv")
    { SetLocalInt(no_pec,"no_prisada",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_stin")
    { SetLocalInt(no_pec,"no_prisada",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_prach_mete")
    { SetLocalInt(no_pec,"no_prisada",12);
    no_snizstack(no_Item,no_mazani);
    break;      }

      }  //konec if resref pruty
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame prisady
}


void no_pouzitykov(object no_Item,object no_pec, int no_mazani)
// napise pekne na pec cislo nasady.
{      // do no_tetiva ulozi cislo pouziteho prachu.
no_Item = GetFirstItemInInventory(no_pec);
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

  }  //konec if resref nasady
  no_Item = GetNextItemInInventory(no_pec);

  }//tak uz mame nasadu
}






void no_vyrobek (object no_Item, object no_pec, int no_mazani)
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetResRef(no_Item),6) == "no_zl_")
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
int no_level = TC_getLevel(no_oPC,TC_zlatnik);  // TC kovar = 33
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


//if (GetLocalInt(OBJECT_SELF,"no_hl_proc")  < no_menu_max_procent/2 )
//{
//jinak nepozna, ze ktereho stacku ma odecist pruty
//int no_menu_hlavni_material = GetLocalInt(OBJECT_SELF,"no_hl_mat");
//SetLocalInt(OBJECT_SELF,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_ve_mat"));
//SetLocalInt(OBJECT_SELF,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc"))  );
//SetLocalInt(OBJECT_SELF,"no_ve_mat",no_menu_hlavni_material);
//if (NO_oc_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Reknutim co to je za material prehazujem" );   }
//}

switch (GetLocalInt(OBJECT_SELF,"no_hl_mat")) {
case 0: {no_menu_nazev_kovu = "nefrit";
         SetLocalInt(OBJECT_SELF,"no_hl_mat",1); break;}
case 1: {no_menu_nazev_kovu = "nefrit";    break;}
case 2: {no_menu_nazev_kovu = "malachit";   break;}
case 3: {no_menu_nazev_kovu = "ohnivy achat";   break;}
case 4: {no_menu_nazev_kovu = "aventurin";   break;}
case 5: {no_menu_nazev_kovu = "fenelop";   break;}
case 6: {no_menu_nazev_kovu = "ametyst";   break;}
case 7: {no_menu_nazev_kovu = "zivec";   break;}
case 8: {no_menu_nazev_kovu = "granat";   break;}
case 9: {no_menu_nazev_kovu = "alexandrit";   break;}
case 10: {no_menu_nazev_kovu = "topaz";   break;}
case 11: {no_menu_nazev_kovu = "safir";   break;}
case 12: {no_menu_nazev_kovu = "ohnivy opal";   break;}
case 13: {no_menu_nazev_kovu = "diamant";   break;}
case 14: {no_menu_nazev_kovu = "rubin";   break;}
case 15: {no_menu_nazev_kovu = "smaragd";   break;}
}

switch (GetLocalInt(OBJECT_SELF,"no_ve_mat")) {
case 0: {no_menu_nazev_kovu2 = "nefrit";
        SetLocalInt(OBJECT_SELF,"no_ve_mat",1); break;}
case 1: {no_menu_nazev_kovu2 = "nefrit";    break;}
case 2: {no_menu_nazev_kovu2 = "malachit";   break;}
case 3: {no_menu_nazev_kovu2 = "ohnivy achat";   break;}
case 4: {no_menu_nazev_kovu2 = "aventurin";   break;}
case 5: {no_menu_nazev_kovu2 = "fenelop";   break;}
case 6: {no_menu_nazev_kovu2 = "ametyst";   break;}
case 7: {no_menu_nazev_kovu2 = "zivec";   break;}
case 8: {no_menu_nazev_kovu2 = "granat";   break;}
case 9: {no_menu_nazev_kovu2 = "alexandrit";   break;}
case 10: {no_menu_nazev_kovu2 = "topaz";   break;}
case 11: {no_menu_nazev_kovu2 = "safir";   break;}
case 12: {no_menu_nazev_kovu2 = "ohnivy opal";   break;}
case 13: {no_menu_nazev_kovu2 = "diamant";   break;}
case 14: {no_menu_nazev_kovu2 = "rubin";   break;}
case 15: {no_menu_nazev_kovu2 = "smaragd";   break;}
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


if (no_zl_debug == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta=" + no_menu_nazev_procenta );}

no_menu_nazev_procenta2 =IntToString( 10*no_menu_max_procent - StringToInt(no_menu_nazev_procenta));

if (no_zl_debug == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta2=" + no_menu_nazev_procenta2 );}

if ((no_menu_nazev_kovu!=no_menu_nazev_kovu2)&(StringToInt(no_menu_nazev_procenta)!=10*no_menu_max_procent))  {

FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu + " a " + no_menu_nazev_procenta2 + "%" + no_menu_nazev_kovu2,no_oPC,FALSE );
SetLocalString(OBJECT_SELF,"no_menu_nazev_1",no_menu_nazev_kovu);
SetLocalString(OBJECT_SELF,"no_menu_nazev_2",no_menu_nazev_kovu2);
}
if  ((no_menu_nazev_kovu==no_menu_nazev_kovu2) || (StringToInt(no_menu_nazev_procenta)==10*no_menu_max_procent)) {
no_menu_nazev_procenta = IntToString(10*no_menu_max_procent);
FloatingTextStringOnCreature("Zvoleny material je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu ,no_oPC,FALSE );
if (no_zl_debug == TRUE) {SendMessageToPC(no_oPC,"(no_menu_nazev_procenta2== 0");}
SetLocalString(OBJECT_SELF,"no_menu_nazev_1",no_menu_nazev_kovu);
SetLocalString(OBJECT_SELF,"no_menu_nazev_2","");
}


}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
PlaySound("as_cv_chiseling1");
DelayCommand(2.0,PlaySound("as_cv_chiseling1"));
DelayCommand(5.0,PlaySound("as_cv_chiseling1"));
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

//AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9, 1.5, no_zl_delay));
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_zl_delay));

    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_zl_delay,ActionUnlockObject(OBJECT_SELF));

DelayCommand(no_zl_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));

// PlaySound("al_mg_crystalic1");
}


void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item)
//////////////prida procenta nehotovym vrobkum/////////////////////////////////
{string no_tag_vyrobku = GetTag(no_Item);
        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_zlatnik);}
 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
         string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

DestroyObject(no_Item);



no_Item = CreateItemOnObject("no_polot_zl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
no_udelejjmeno(no_Item);
SetName(no_Item,GetName(no_Item) + "  *"+ no_nazev_procenta + "%*");
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_zl_clos_apa",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si vyrobu" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }

}


///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_zl (object no_oPC, object no_pec)
{
int no_druh=0;
int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
int no_level = TC_getLevel(no_oPC,TC_zlatnik);  // TC kovar = 33
if ( no_zl_debug == TRUE )  no_level=no_level+10;
if  (GetIsDM(no_oPC)== TRUE) no_level=no_level+20;

no_Item = GetFirstItemInInventory(no_pec);

while (GetIsObjectValid(no_Item)) {
if  (GetResRef(no_Item) == "no_polot_zl")
        {
        no_zjistiobsah(GetTag(no_Item));
        break;
        }//pokud resref = no_polot_zb      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
 }    /// konec while

/// davam to radsi uz sem, bo se pak i podle toho nastavuje cena..
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "pr") no_DC = 2;
else if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "am") no_DC = 5;

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

switch (GetLocalInt(OBJECT_SELF,"no_kovsperku")) {
case 1: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              break;}}
case 2: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              break;}}
case 3: { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              break;}}
case 4:  { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              break;}}
case 5: { if (no_menu_max_procent> 6){
              no_menu_max_procent = 6;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 60%" ,no_oPC,FALSE );
              break;}}
case 6: { if (no_menu_max_procent> 8){
              no_menu_max_procent = 8;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 80%" ,no_oPC,FALSE );
              break;}}
case 7: { if (no_menu_max_procent> 10){
              no_menu_max_procent = 10;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 100%" ,no_oPC,FALSE );
              break;}}
case 8: { if (no_menu_max_procent> 12){
              no_menu_max_procent = 12;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 120%" ,no_oPC,FALSE );
              break;}}
case 9: { if (no_menu_max_procent> 14){
              no_menu_max_procent = 14;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 140%" ,no_oPC,FALSE );
              break;}}
case 10: { if (no_menu_max_procent> 16){
              no_menu_max_procent = 16;
              break;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 160%" ,no_oPC,FALSE );
              }}
case 11: { if (no_menu_max_procent> 18){
              no_menu_max_procent = 18;
              //FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 180%" ,no_oPC,FALSE );
              break;}}
}


//
//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /
if (GetLocalInt(OBJECT_SELF,"no_sutr_1") == 0 ) {
//to znamena, ze zatim nemame hotovo
no_DC = 10+ no_DC + (GetLocalInt(OBJECT_SELF,"no_kovsperku"))*4  - 10*no_level;
// = max. 30+ (20*12)/4 + (0*12)/4 = 85  //tzn 9lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_kovsperku"));
//no_druh =1- 12   = meteocel+meteocel
}

if (GetLocalInt(OBJECT_SELF,"no_sutr_1") != 0 ) {
//to znamena, ze budemem mit hotovo

int no_procenta_v_sutru;
if ( GetLocalInt(OBJECT_SELF,"no_sutr_procenta")> no_menu_max_procent )    {
no_procenta_v_sutru = no_menu_max_procent;                                 }

if ( GetLocalInt(OBJECT_SELF,"no_sutr_procenta")<= no_menu_max_procent )    {
no_procenta_v_sutru = GetLocalInt(OBJECT_SELF,"no_sutr_procenta");                                 }

no_DC = no_DC + (GetLocalInt(OBJECT_SELF,"no_kovsperku"))*4 + ((GetLocalInt(OBJECT_SELF,"no_sutr_1"))*no_procenta_v_sutru)/2 + ((GetLocalInt(OBJECT_SELF,"no_sutr_2"))*(no_menu_max_procent - no_procenta_v_sutru))/2 - 10*no_level;
// = 5+ max. 30+ (20*12)/2 + (0*12)/2 + (10*8)/2 = 195  //tzn 20lvl umi vse na trivial
no_druh = StringToInt( GetLocalString(OBJECT_SELF,"no_sutr_1") + GetLocalString(OBJECT_SELF,"no_sutr_2"));

//no_druh = 11021   = stinova ocel + med + vrba
}




if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC,"no_druh= " + IntToString(no_druh));


if (no_druh>0 ) {
////6brezen/////
if  (GetLocalFloat(no_Item,"no_suse_proc")==0.0) SetLocalFloat(no_Item,"no_suse_proc",10.0);


// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
        if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();

 if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));


if (no_hod <= no_chance ) {

        float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");

        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
                         TC_setXPbyDifficulty(no_oPC,TC_zlatnik,no_chance,TC_dej_vlastnost(TC_zlatnik,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_zlatnik,no_chance,TC_dej_vlastnost(TC_zlatnik,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
        //no_procenta = no_procenta + 5+ d20() + no_level ;  // = 12-45
            int no_obtiznost_vyrobku = no_DC+( 10*no_level );

            if (no_obtiznost_vyrobku >=190) {
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
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}


            if (no_zl_debug == TRUE){no_procenta = no_procenta +30.0; }

        if (no_procenta >= 100.0) { //kdyz je vyrobek 100% tak samozrejmeje hotovej
        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek

                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

// if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                        if (no_druh < 13) { //nedodelana zbran                                 //  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /

                             if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="pr"){
                        no_Item=CreateItemOnObject("no_zl_prst_" + GetLocalString(OBJECT_SELF,"no_kovsperku"),no_oPC,1,"no_zl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kovsperku")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_procenta") );
                                 }
                             if  (GetLocalString(OBJECT_SELF,"no_druh_vyrobku")=="am"){
                        no_Item=CreateItemOnObject("no_zl_amul_" + GetLocalString(OBJECT_SELF,"no_kovsperku"),no_oPC,1,"no_zl_"+ GetLocalString(OBJECT_SELF,"no_druh_vyrobku")+ "_"+ GetLocalString(OBJECT_SELF,"no_kovsperku")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_1")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_2")+ "_"+ GetLocalString(OBJECT_SELF,"no_sutr_procenta") );
                                 }

                        no_udelejjmeno(no_Item);
                        no_cenavyrobku(no_Item);   }
    ///////////// dodelame zbran uplne /////////////////////////////////////////////
                        if ((no_druh > 13)& (no_druh < 12129 ) )
                        {    no_udelejprsten(no_pec);    }
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
        else  if ((no_chance > 0)&(no_procenta>0.0)) {FloatingTextStringOnCreature("Udeall si nesetrny vryp",no_oPC,FALSE ); }

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu
        if (no_procenta > 0.0 ) {
         no_vytvorprocenta(no_oPC,no_procenta,no_Item);
                            }



         }//konec else no_hod >no_chance

         }// konec kdyz jsme meli nejakej no_druh

}    ////konec no_xp_zb




void no_xp_pridej_kameny(object no_oPC, object no_pec)
// vyresi moznost uspechu a preda pripadny povedenou desku do no_pec
{
no_zjistiobsah(GetLocalString(no_pec,"no_vyrobek"));

int no_level = TC_getLevel(no_oPC,TC_zlatnik);  // TC kovar = 33
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

///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - no_druh_vyrobku/ 01 no_kovsperku /02 no_sutr_1 /  03 no_sutr_2 /04 no_sutr_procenta /


//////////NOVE ZNENI:  bere se to z vyrobku :////////////////////
int no_prisadovy_material = GetLocalInt(no_pec,"no_kovsperku");


///// taaaaak tady se musi rozhodnout podle kovu, kolik max. % se tam vejde... :
switch (GetLocalInt(OBJECT_SELF,"no_kovsperku")) {
case 1: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              }}
case 2: { if (no_menu_max_procent> 2){
              no_menu_max_procent = 2;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 20%" ,no_oPC,FALSE );
              }}
case 3: { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              }}
case 4:  { if (no_menu_max_procent> 4){
              no_menu_max_procent = 4;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 40%" ,no_oPC,FALSE );
              }}
case 5: { if (no_menu_max_procent> 6){
              no_menu_max_procent = 6;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 60%" ,no_oPC,FALSE );
              }}
case 6: { if (no_menu_max_procent> 8){
              no_menu_max_procent = 8;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 80%" ,no_oPC,FALSE );
              }}
case 7: { if (no_menu_max_procent> 10){
              no_menu_max_procent = 10;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 100%" ,no_oPC,FALSE );
              }}
case 8: { if (no_menu_max_procent> 12){
              no_menu_max_procent = 12;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 120%" ,no_oPC,FALSE );
              }}
case 9: { if (no_menu_max_procent> 14){
              no_menu_max_procent = 14;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 140%" ,no_oPC,FALSE );
              }}
case 10: { if (no_menu_max_procent> 16){
              no_menu_max_procent = 16;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 160%" ,no_oPC,FALSE );
              }}
case 11: { if (no_menu_max_procent> 18){
              no_menu_max_procent = 18;
              FloatingTextStringOnCreature("Do tohoto kovu neni mozne pridat tolik prisad.  Bude pouzito pouze prvnich 180%" ,no_oPC,FALSE );
              }}

}//konec switche

string no_menu_nazev_kovu;
string no_menu_nazev_kovu2;
switch (GetLocalInt(OBJECT_SELF,"no_hl_mat")) {
case 0: {no_menu_nazev_kovu = "nefrit"; break;}
case 1: {no_menu_nazev_kovu = "nefrit";    break;}
case 2: {no_menu_nazev_kovu = "malachit";   break;}
case 3: {no_menu_nazev_kovu = "ohnivy achat";   break;}
case 4: {no_menu_nazev_kovu = "aventurin";   break;}
case 5: {no_menu_nazev_kovu = "fenelop";   break;}
case 6: {no_menu_nazev_kovu = "ametyst";   break;}
case 7: {no_menu_nazev_kovu = "zivec";   break;}
case 8: {no_menu_nazev_kovu = "granat";   break;}
case 9: {no_menu_nazev_kovu = "alexandrit";   break;}
case 10: {no_menu_nazev_kovu = "topaz";   break;}
case 11: {no_menu_nazev_kovu = "safir";   break;}
case 12: {no_menu_nazev_kovu = "ohnivy opal";   break;}
case 13: {no_menu_nazev_kovu = "diamant";   break;}
case 14: {no_menu_nazev_kovu = "rubin";   break;}
case 15: {no_menu_nazev_kovu = "smaragd";   break;}
}

switch (GetLocalInt(OBJECT_SELF,"no_ve_mat")) {
case 0: {no_menu_nazev_kovu2 = "nefrit"; break;}
case 1: {no_menu_nazev_kovu2 = "nefrit";    break;}
case 2: {no_menu_nazev_kovu2 = "malachit";   break;}
case 3: {no_menu_nazev_kovu2 = "ohnivy achat";   break;}
case 4: {no_menu_nazev_kovu2 = "aventurin";   break;}
case 5: {no_menu_nazev_kovu2 = "fenelop";   break;}
case 6: {no_menu_nazev_kovu2 = "ametyst";   break;}
case 7: {no_menu_nazev_kovu2 = "zivec";   break;}
case 8: {no_menu_nazev_kovu2 = "granat";   break;}
case 9: {no_menu_nazev_kovu2 = "alexandrit";   break;}
case 10: {no_menu_nazev_kovu2 = "topaz";   break;}
case 11: {no_menu_nazev_kovu2 = "safir";   break;}
case 12: {no_menu_nazev_kovu2 = "ohnivy opal";   break;}
case 13: {no_menu_nazev_kovu2 = "diamant";   break;}
case 14: {no_menu_nazev_kovu2 = "rubin";   break;}
case 15: {no_menu_nazev_kovu2 = "smaragd";   break;}
}


int no_hl_proc = 10*GetLocalInt(no_pec,"no_hl_proc");


if (no_hl_proc> no_menu_max_procent*10) no_hl_proc = no_menu_max_procent*10;
      //tedy kdyz jsou nastavene vysoke procenta, ale mame je zkrouhnute zbrani trebas.
          int no_co_mame_za_kamen2;
          int no_co_mame_za_kamen;
          if ( no_zl_debug == TRUE )  SendMessageToPC(no_oPC,"(no_menu_max_procent*10) < no_co_mame_za_kamen)" );
                            if ((no_hl_proc == 20)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-20;
                            no_co_mame_za_kamen=20;}
                            if ((no_hl_proc == 40)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-40;
                            no_co_mame_za_kamen=40;}
                            if ((no_hl_proc == 60)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-60;
                            no_co_mame_za_kamen=60;}
                            if ((no_hl_proc == 80)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-80;
                            no_co_mame_za_kamen=80;}
                            if ((no_hl_proc == 100)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-100;
                            no_co_mame_za_kamen=100;}
                            if ((no_hl_proc == 120)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-120;
                            no_co_mame_za_kamen=120;}
                            if ((no_hl_proc == 140)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-140;
                            no_co_mame_za_kamen=140;}
                            if ((no_hl_proc == 160)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-160;
                            no_co_mame_za_kamen=160; }
                            if ((no_hl_proc == 180)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-180;
                            no_co_mame_za_kamen=180;}
                            if ((no_hl_proc == 200)) {
                            no_co_mame_za_kamen2 = no_menu_max_procent*10-180;
                            no_co_mame_za_kamen=200;}

//kdyz dva stejne kameny, dava se automaticky max. procent
if ( (GetLocalInt(no_pec,"no_hl_mat") == GetLocalInt(no_pec,"no_ve_mat")) || (GetLocalInt(no_pec,"no_ve_mat")==0) || ( GetLocalInt(no_pec,"no_hl_proc")*10 == no_menu_max_procent)) {
SetLocalInt(no_pec,"no_hl_proc",no_menu_max_procent/10);
SetLocalInt(no_pec,"no_ve_mat",GetLocalInt(no_pec,"no_hl_mat"));
}


                if (no_co_mame_za_kamen2>0) {
        FloatingTextStringOnCreature("Tenhle sperk bude vyroben jako: " +IntToString(no_co_mame_za_kamen)+"%"+no_menu_nazev_kovu+" "+IntToString(no_co_mame_za_kamen2)+"% "+ no_menu_nazev_kovu2,no_oPC, FALSE);
                }
                if ((no_co_mame_za_kamen2<1)&(no_co_mame_za_kamen2!=no_co_mame_za_kamen))  {
        FloatingTextStringOnCreature("Tenhle sperk bude vyroben jako:" +IntToString(no_co_mame_za_kamen)+"%"+no_menu_nazev_kovu ,no_oPC, FALSE);
                }

        //SetLocalInt(OBJECT_SELF,"no_kamen",no_menu_max_procent);
        //SetLocalInt(OBJECT_SELF,"no_kamen2",no_co_mame_za_kamen2);

//kvuli zapisum na vyrobky musime mit spravne stringy
string no_tagX="";
no_tagX = IntToString(GetLocalInt(no_pec,"no_hl_mat")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tagX) ==1) {no_tagX =  "0" + no_tagX; }
if (GetStringLength(no_tagX) ==2) {no_tagX = no_tagX;} // ulozi nam to string nazev kamene.
SetLocalString(no_pec,"no_hl_mat",no_tagX);

no_tagX="";
no_tagX = IntToString(GetLocalInt(no_pec,"no_ve_mat")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tagX) ==1) {no_tagX =  "0" + no_tagX; }
if (GetStringLength(no_tagX) ==2) {no_tagX = no_tagX;} // ulozi nam to string nazev kamene.
SetLocalString(no_pec,"no_ve_mat",no_tagX);

no_tagX="";
no_tagX = IntToString(GetLocalInt(no_pec,"no_hl_proc")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tagX) ==1) {no_tagX =  "0" + no_tagX; }
if (GetStringLength(no_tagX) ==2) {no_tagX = no_tagX;} // ulozi nam to string nazev kamene.
SetLocalString(no_pec,"no_hl_proc",no_tagX);


if (GetLocalInt(no_pec,"no_prisada") ==0) FloatingTextStringOnCreature("Bude potreba kouzelny prach !",no_oPC,FALSE);
if ((GetLocalInt(no_pec,"no_prisada")!=no_prisadovy_material)& (GetLocalInt(no_pec,"no_prisada") !=0)) FloatingTextStringOnCreature("Potrebujes kouzelny prach kovu, ze ktereho je klenot delan !",no_oPC,FALSE);

//tak, kdyz mame vsechno spravne, tak udelame :
if ((GetLocalInt(no_pec,"no_prisada")==GetLocalInt(no_pec,"no_kovsperku"))&( ( (GetLocalInt(no_pec,"no_ve_mat") == GetLocalInt(no_pec,"no_pouzitysutr2"))  &  (GetLocalInt(no_pec,"no_hl_mat") == GetLocalInt(no_pec,"no_pouzitysutr1"))  ) ||(  (GetLocalInt(no_pec,"no_ve_mat") == GetLocalInt(no_pec,"no_pouzitysutr1"))   &  (GetLocalInt(no_pec,"no_hl_mat") == GetLocalInt(no_pec,"no_pouzitysutr2"))   ) ))
{                          //   &(((GetLocalInt(no_pec,"no_hl_mat") == GetLocalInt(no_pec,"no_pouzitysutr1")) &(GetLocalInt(no_pec,"no_ve_mat") == GetLocalInt(no_pec,"no_pouzitysutr2")))

            if (no_zl_debug == TRUE) {

            SendMessageToPC(no_oPC, " polotvar vyrabime s tvarem : polotovar: no_zl_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kovsperku")+ "_" + GetLocalString(no_pec,"no_hl_mat")+"_" + GetLocalString(no_pec,"no_ve_mat")+ "_"+GetLocalString(no_pec,"no_hl_proc"));
            SendMessageToPC(no_oPC,"nasavena procenta na zarizeni: " + (GetLocalString(OBJECT_SELF,"no_hl_proc")));
            SendMessageToPC(no_oPC,"sutr v zarizeni 1 pred smazanim: " + (GetLocalString(OBJECT_SELF,"no_pouzitysutr1")));
            SendMessageToPC(no_oPC,"sutr v zarizeni 2 pred smazanim: " + (GetLocalString(OBJECT_SELF,"no_pouzitysutr2")));

                     }



            CreateItemOnObject("no_polot_zl",no_pec,1,"no_zl_" + GetLocalString(no_pec,"no_druh_vyrobku")+ "_" + GetLocalString(no_pec,"no_kovsperku")+ "_" + GetLocalString(no_pec,"no_hl_mat")+"_" + GetLocalString(no_pec,"no_ve_mat")+ "_"+GetLocalString(no_pec,"no_hl_proc"));
            no_zamkni(no_oPC);
            no_prisada(no_Item,OBJECT_SELF,TRUE);
            no_vyrobek(no_Item,OBJECT_SELF,TRUE);
            no_pouzitykov(no_Item,OBJECT_SELF,TRUE);
            no_pouzitykamen(no_Item,OBJECT_SELF,TRUE);
            DelayCommand(no_zl_delay,no_xp_zl(no_oPC,no_pec));
            }


} // konec no_xp_pridej_nasadu


//////////////////////////////////////////////////////////////////////////////////////////
void no_xp_vyrobpolotovar(object no_oPC, object no_pec)
// vytvori polotovar
{    //tohel se spousti, jen kdyz existuje kov, takze jen overujeme formu.
// 1 -prsten, 2-amulet
string no_tag = "";
/////////////////////////////////////
///  dela prsteny a maulety ve tvaru no_zl_XX_01_02_03_04 kde:
//
//  XX - amulet-prsten/ 01 pouzity kov /02 1.sutr/ 03 2.sutr /04 procenta /


no_tag = IntToString(GetLocalInt(no_pec,"no_pouzitykov")); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tag) ==1) {no_tag =  "0" + no_tag; }
if (GetStringLength(no_tag) ==2) {no_tag = no_tag;} // ulozi nam to string nazev kamene.

if (no_zl_debug == TRUE) SendMessageToPC(no_oPC, "polotovar: no_zl_XX_" + no_tag + "_00_00_00");


switch (GetLocalInt(OBJECT_SELF,"no_menu")) {
        case 1:   {if  (GetLocalInt(no_pec,"no_forma") == 1 ) {
                    CreateItemOnObject("no_polot_zl",no_pec,1,"no_zl_pr_" + no_tag  + "_00_00_00");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zl_delay,no_xp_zl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
                    SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
                    SetLocalInt(OBJECT_SELF,"no_forma",0);
                    SetLocalInt(OBJECT_SELF,"no_prisada",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);
                    SetLocalString(OBJECT_SELF,"no_vyrobek","");
                    no_forma(no_Item,OBJECT_SELF,TRUE);       //promazem, co pouzijem
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);  //promazem, co pouzijem
                    }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste malou formu",no_oPC,FALSE );
                    break;}
        case 2:    {if  (GetLocalInt(no_pec,"no_forma") == 3 ) {
                    CreateItemOnObject("no_polot_zl",no_pec,1,"no_zl_am_" + no_tag + "_00_00_00");
                    no_zamkni(no_oPC);
                    DelayCommand(no_zl_delay,no_xp_zl(no_oPC,no_pec));
                    // dulezite nulovat, jinak se smazou blbe
                    SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
                    SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
                    SetLocalInt(OBJECT_SELF,"no_forma",0);
                    SetLocalInt(OBJECT_SELF,"no_prisada",0);
                    SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);
                    SetLocalString(OBJECT_SELF,"no_vyrobek","");
                    no_forma(no_Item,OBJECT_SELF,TRUE);       //promazem, co pouzijem
                    no_pouzitykov(no_Item,OBJECT_SELF,TRUE);   //promazem, co pouzijem
                    }
                    else  FloatingTextStringOnCreature("Chtelo by to jeste stredni formu",no_oPC,FALSE );
                    break;}

        } //konec switche


} // konec vyrob polotovar


