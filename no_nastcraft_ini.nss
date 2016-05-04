#include "tc_constants"

const string no_verzecraftu =  "04.05.16";  // bude u kazdeho vyrobku napsane, at vime, jak je to starej vyrobek
                                            //  obzvlaste po tech updatech tobude bourlive :D

/*const int TC_zlatnik = 30; // cislo drevariny
int TC_ZL_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_CHARISMA,TRUE);
const int TC_SUTRY = 23; // cislo brusicstvi
int TC_br_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_CHARISMA,TRUE);
const int TC_DREVO = 21; // cislo drevariny
int TC_dr_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_STRENGTH,TRUE);
const int TC_KERAM = 22; // cislo meho craftu
int TC_ke_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_DEXTERITY,TRUE);
const int TC_KUZE = 24; // cislo kozeluzstvi
int TC_ko_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_WISDOM,TRUE);
const int TC_ocarovavac = 35; // cislo ocarovani
int TC_oc_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_INTELLIGENCE,TRUE);
const int TC_platner = 2; // cislo platneriny
int TC_pl_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_CONSTITUTION,TRUE);
const int TC_MELTING = 20; //slevac
int TC_sl_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_CONSTITUTION,TRUE);
const int TC_kovar = 33; // cislo kovariny
int TC_zb_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_STRENGTH,TRUE);
const int TC_siti = 31; // cislo siti
int TC_si_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_WISDOM,TRUE);
const int TC_truhlar = 32; // cislo truhlare
int TC_tr_VLASTNOST;//  = GetAbilityScore(GetLastDisturbed(), ABILITY_DEXTERITY,TRUE);
*/

int TC_dej_vlastnost(int nCraft, object oPC);


int TC_dej_vlastnost(int nCraft, object oPC) {
  //Default - pokud nedokazu urcit remeslo
  int nAbility;
  switch(nCraft) {
    case TC_zlatnik:
    case TC_SUTRY:
      nAbility = ABILITY_CHARISMA;
      break;
    case TC_DREVO:
    case TC_kovar:
      nAbility = ABILITY_STRENGTH;
      break;
    case TC_KERAM:
    case TC_truhlar:
      nAbility = ABILITY_DEXTERITY;
      break;
    case TC_KUZE:
    case TC_siti:
      nAbility = ABILITY_WISDOM;
      break;
    case TC_ocarovavac:
      nAbility = ABILITY_INTELLIGENCE;
    case TC_platner:
    case TC_MELTING:
      nAbility =ABILITY_CONSTITUTION;
      break;
    // Pokud nenajdu remeslo
    default:
      SpeakString("Chyba! Nelze urcit remeslo!");
      return 0;
  }

  return GetAbilityScore(oPC,nAbility,TRUE);
}
// slevarina = 20
//drevarstvi = 21
// keramika = 22
// brusicstvi = 23
// kozeluzstvi = 24
const float no_zl_delay = 7.0; ///pouzivane u vsech animaci a zamknuti
const float no_br_delay = 3.0;
const float no_dr_delay = 3.0; ///pouzivane u vsech animaci a zamknuti
const float no_ke_delay = 3.0;
const float no_ko_delay = 3.0;
const float no_oc_delay = 7.0;
const float no_pl_delay = 7.0; ///pouzivane u vsech animaci a zamknuti
const float no_sl_delay = 3.0;
const float no_zb_delay = 7.0; ///pouzivane u vsech animaci a zamknuti
const float no_si_delay = 7.0;
const float no_tr_delay = 7.0;

///////////////DEBUGS/////////////////////////////////////////
const int no_zl_debug = FALSE;
const int NO_KE_DEBUG = FALSE;
const int NO_oc_DEBUG = FALSE;
const int NO_pl_DEBUG = FALSE;
const int NO_zb_DEBUG = FALSE;
const int no_tr_debug = FALSE;
const int no_si_debug = FALSE;

////////////////////////////////////////////////
/////ZISKY //////////////////////////////////
////////////////////////////////////////////////
// 1.0 = 0% zisk  ,  1.01 = 1% zisk//////////
////////////////////////////////////////////
const float no_dr_nasobitel = 1.012;
const float no_dr_nasobitel2 = 0.05; // nejsou naklady
const float no_br_nasobitel = 1.012;
const float no_br_nasobitel2 = 0.05;  // nejsou naklady
const float no_zl_nasobitel = 1.03;
const float no_zl_nasobitel2 = 1.04;
const float no_ke_nasobitel = 1.012;    // nejsou naklady   ale keramika zadara skorem
const float no_ke_nasobitel2 = 1.005;
const float no_ko_nasobitel = 1.012;
const float no_ko_nasobitel2 = 0.15;  // nejsou naklady    (ale kuze neco stoji no..)
const float no_oc_nasobitel = 1.03;
const float no_oc_nasobitel2 = 1.005;
const float no_pl_nasobitel = 1.03;
const float no_pl_nasobitel2 = 1.03;
const float no_sl_nasobitel = 1.015;
const float no_sl_nasobitel2 = 0.05; // nejsou naklady
const float no_zb_nasobitel = 1.03;
const float no_zb_nasobitel2 = 1.02;
const float no_si_nasobitel = 1.03;
const float no_si_nasobitel2 = 1.02;
const float no_tr_nasobitel = 1.03;
const float no_tr_nasobitel2 = 1.02;

///////////////////////////////////////////////////////////////
////////maximalni pocet vygenerovanych vyrobku por questy  ///////////////
///////////////////////////////////////////////////////////////
const int no_nastav_maximalni_pocet_vyrobku = 10;


////////////////////////////////////////////////
////////CENY NAKLADU////////////////////////////
////////////////////////////////////////////////
const int no_cena_kov_zl1 =  88;
const int no_cena_kov_zl2 =  808;
const int no_cena_kov_zl3 =  1608;
const int no_cena_kov_zl4 =  3208;
const int no_cena_kov_zl5 =  6408;
const int no_cena_kov_zl6 =  17288;
const int no_cena_kov_zl7 =  22408;
const int no_cena_kov_zl8 =  51208;
const int no_cena_kov_zl9 =  64008;
const int no_cena_kov_zl10 = 96008;
const int no_cena_kov_zl11 = 128008;
const int no_cena_kov_zl12 = 160008;
///////KONEC ZLATNIK//////////////////////


// ceny za lestidla kamenu //////////////////
const int  no_cena_kame_1  =100;
const int  no_cena_kame_7 =  300;
const int  no_cena_kame_2 = 700;
const int  no_cena_kame_14  = 1000;
const int  no_cena_kame_4  = 1500;
const int  no_cena_kame_3  = 2000;
const int  no_cena_kame_15 = 2500;
const int  no_cena_kame_11  = 3000;
const int  no_cena_kame_13  = 4000;
const int  no_cena_kame_10  = 5000;
const int  no_cena_kame_8  = 6000;
const int  no_cena_kame_9 = 7000;
const int  no_cena_kame_5  = 8000;
const int  no_cena_kame_6  = 9000;
const int  no_cena_kame_12 = 10000;
// konec ceny za lestidla kamenu //////////////////

//cena za legovani kovu ////////////
const int no_cena_tin = 100;
const int no_cena_copp = 300;
const int no_cena_bron = 400; //vermajl
const int no_cena_iron = 500;
const int no_cena_gold = 700;
const int no_cena_plat = 1500;
const int no_cena_mith = 2500;
const int no_cena_adam = 4000;
const int no_cena_tita = 5500;
const int no_cena_silv = 7000;
const int no_cena_stin = 8500;
const int no_cena_mete = 10000;
//konec cena za legovani kovu ////////////


// cena za formy//
const int no_cena_lahe = 9;
const int no_cena_ampu = 11;
const int no_cena_kuli = 2;
const int no_cena_mala = 11;
const int no_cena_tenk = 21;
const int no_cena_stre = 41;
const int no_cena_velk = 101;
const int no_cena_zahn = 81;
// konec cena za formy//

         //ceny mořidla na násady
const int  no_cena_nasa_vrb =   16;
const int  no_cena_nasa_ore =  128;
const int  no_cena_nasa_dub =  400;
const int  no_cena_nasa_mah =  960;
const int  no_cena_nasa_tis =  2000;
const int  no_cena_nasa_jil =  3200;
const int  no_cena_nasa_zel =  5600;
const int  no_cena_nasa_pra =  8000;



       //cena louhu
const int  no_cena_kozk_obyc =  100;
const int  no_cena_kozk_leps =  500;
const int  no_cena_kozk_kval =  2000;
const int  no_cena_kozk_mist =  5000;
const int  no_cena_kozk_velm =  7000;
const int  no_cena_kozk_lege =  10000;



//cena prisady  platner
const int no_cena_prisada1 = 100;
const int no_cena_prisada2 = 500;
const int no_cena_prisada3 = 1000; //vermajl
const int no_cena_prisada4 = 2400; //zelezo
const int no_cena_prisada5= 4000; //zlato
const int no_cena_prisada6 = 9600;
const int no_cena_prisada7 = 12000;
const int no_cena_prisada8 = 24000;
const int no_cena_prisada9 = 32000;
const int no_cena_prisada10 = 60000;
const int no_cena_prisada11 = 104000;
const int no_cena_prisada12= 160000;


//cena prisady  kovar
const int no_cena_zb_prisada1 = 80;
const int no_cena_zb_prisada2 = 160;
const int no_cena_zb_prisada3 = 400;  //vermajl
const int no_cena_zb_prisada4 = 2400;  //zelezo
const int no_cena_zb_prisada5= 4000;   //zlato
const int no_cena_zb_prisada6 = 9600;
const int no_cena_zb_prisada7 = 12000;
const int no_cena_zb_prisada8 = 24000;
const int no_cena_zb_prisada9 = 32000;
const int no_cena_zb_prisada10 = 40000;
const int no_cena_zb_prisada11 = 104000;
const int no_cena_zb_prisada12= 160000;


//cena prisad  krejci
const int no_cena_kuze_lest1 = 88;  ///+cena kuze
const int no_cena_kuze_lest2 = 3208;
const int no_cena_kuze_lest3 = 11208;
const int no_cena_kuze_lest4 = 32008;
const int no_cena_kuze_lest5 = 80008;
const int no_cena_kuze_lest6 = 160008;


//ceny tetiv pro luky nebo kuse
const int no_cena_moridla1 =80;
const int no_cena_moridla2 =2000;
const int no_cena_moridla3 =3600;
const int no_cena_moridla4 =8800;
const int no_cena_moridla5 =21600;
const int no_cena_moridla6 =44000;
const int no_cena_moridla7 =96000;
const int no_cena_moridla8 =160000;
  //na stity nyty
const int no_cena_nytu1 =88;
const int no_cena_nytu2 =168;
const int no_cena_nytu3 =408;
const int no_cena_nytu4 =2408;
const int no_cena_nytu5 =4008;
const int no_cena_nytu6 =9608;
const int no_cena_nytu7 =12008;
const int no_cena_nytu8 =24008;
const int no_cena_nytu9 =32008;
const int no_cena_nytu10 =40000;
const int no_cena_nytu11 =104008;
const int no_cena_nytu12 =160008;


//cena ocarovavace
const int no_cena_kame10 = 184;
const int no_cena_kame20 = 8240;
const int no_cena_kame30 = 40024;
const int no_cena_kame40 = 80024;
const int no_cena_kame50 = 160024;

///////////OBTIZNOSTI/////////////////////////////
//////////////////////////////////////////////
///// Obtiznosti brouseni kamenu
///razeno dle resrefu 1-15  (cnrgemcut001)
const int  no_obt_kame_nefr  =18;
const int  no_obt_kame_mala  = 22;
const int  no_obt_kame_ohni  = 26;
const int  no_obt_kame_aven  = 30;
const int  no_obt_kame_fene  = 34;
const int  no_obt_kame_amet  = 38;
const int  no_obt_kame_zive =  42;
const int  no_obt_kame_gran  = 46;
const int  no_obt_kame_alex  = 50;
const int  no_obt_kame_topa  = 54;
const int  no_obt_kame_safi  = 58;
const int  no_obt_kame_opal = 62;
const int  no_obt_kame_diam  = 66;
const int  no_obt_kame_rubi  = 70;
const int  no_obt_kame_smar = 74;


// obtiznosti lesteni sutru

const int  no_obt_brou_nefr  =30;
const int  no_obt_brou_mala  = 39;
const int  no_obt_brou_ohni  = 48;
const int  no_obt_brou_aven  = 56;
const int  no_obt_brou_fene  = 65;
const int  no_obt_brou_amet  = 74;
const int  no_obt_brou_zive =  82;
const int  no_obt_brou_gran  = 91;
const int  no_obt_brou_alex  = 100;
const int  no_obt_brou_topa  = 109;
const int  no_obt_brou_safi  = 118;
const int  no_obt_brou_opal =  127;
const int  no_obt_brou_diam  = 138;
const int  no_obt_brou_rubi  = 145;
const int  no_obt_brou_smar = 150;


///// Obtiznosti sekani dreva
const int  no_obt_drevo_vrb =18;
const int  no_obt_drevo_orech = 24;
const int  no_obt_drevo_dub =  30;
const int  no_obt_drevo_mah =  36;
const int  no_obt_drevo_tis =  42;
const int  no_obt_drevo_jil =  48;
const int  no_obt_drevo_zel =  54;
const int  no_obt_drevo_pra =  60;

// obtiznosti delani desek
const int  no_obt_deska_vrb =   30;
const int  no_obt_deska_orech = 45;
const int  no_obt_deska_dub =  60;
const int  no_obt_deska_mah =  75;
const int  no_obt_deska_tis =  90;
const int  no_obt_deska_jil =  105;
const int  no_obt_deska_zel =  120;
const int  no_obt_deska_pra =  135;

// obtiznosti delani lati
const int  no_obt_lat_vrb =   35;
const int  no_obt_lat_orech = 50;
const int  no_obt_lat_dub = 65;
const int  no_obt_lat_mah =  80;
const int  no_obt_lat_tis =  95;
const int  no_obt_lat_jil =  110;
const int  no_obt_lat_zel =  125;
const int  no_obt_lat_pra =  140;

// obtiznosti delani nasad
const int  no_obt_nasa_vrb =   45;
const int  no_obt_nasa_orech = 60;
const int  no_obt_nasa_dub =  75;
const int  no_obt_nasa_mah =  90;
const int  no_obt_nasa_tis =  105;
const int  no_obt_nasa_jil =  120;
const int  no_obt_nasa_zel =  135;
const int  no_obt_nasa_pra =  150;


///// Obtiznosti cisteni kovu
const int no_obt_cist_pise = 20;
const int no_obt_cist_jil = 30;


// obtiznosti delani forem a skla
const int no_obt_lahe = 20;
const int no_obt_ampu = 35;

const int no_obt_kuli = 30;
const int no_obt_mala = 50;
const int no_obt_tenk = 70;
const int no_obt_stre = 90;
const int no_obt_velk = 130;
const int no_obt_zahn = 110;


// pocet cistych veci na hotovou nedobu ci formu.
const int no_pocetskla_lahev = 1;
const int no_pocetskla_ampule = 2;

const int no_pocetskla_kuli = 1;
const int no_pocetskla_mala = 1;
const int no_pocetskla_tenk = 1;
const int no_pocetskla_stre = 2;
const int no_pocetskla_velk = 3;
const int no_pocetskla_zahn = 2;


///// Obtiznosti suseni kuzi
const int  no_obt_suse_obyc =  20;
const int  no_obt_suse_leps =  28;
const int  no_obt_suse_kval =  36;
const int  no_obt_suse_mist =  44;
const int  no_obt_suse_velm =  52;
const int  no_obt_suse_lege =  60;

// obtiznosti suseni kuzi
const int  no_obt_louh_obyc =  35;
const int  no_obt_louh_leps =  55;
const int  no_obt_louh_kval =  75;
const int  no_obt_louh_mist =  95;
const int  no_obt_louh_velm =  115;
const int  no_obt_louh_lege =  135;

// obtiznosti suseni kozek
const int  no_obt_kozk_obyc =  45;
const int  no_obt_kozk_leps =  65;
const int  no_obt_kozk_kval =  85;
const int  no_obt_kozk_mist =  105;
const int  no_obt_kozk_velm =  125;
const int  no_obt_kozk_lege =  145;




///// Obtiznosti cisteni kovu
const int no_obt_cist_tin = 18;
const int no_obt_cist_copp = 23;
const int no_obt_cist_bron = 28;
const int no_obt_cist_iron = 32;
const int no_obt_cist_gold = 37;
const int no_obt_cist_plat = 42;
const int no_obt_cist_mith = 47;
const int no_obt_cist_adam = 52;
const int no_obt_cist_tita = 57;
const int no_obt_cist_silv = 62;
const int no_obt_cist_stin =  67;
const int no_obt_cist_mete =  72;

// obtiznosti legovani kovu
const int no_obt_nale_tin = 30;
const int no_obt_nale_copp = 41;
const int no_obt_nale_bron = 52;
const int no_obt_nale_iron = 63;
const int no_obt_nale_gold = 74;
const int no_obt_nale_plat = 85;
const int no_obt_nale_mith = 96;
const int no_obt_nale_adam = 107;
const int no_obt_nale_tita = 118;
const int no_obt_nale_silv = 129;
const int no_obt_nale_stin = 140;
const int no_obt_nale_mete = 145;


// obtiznost slevani  slitin
const int no_obt_slev_bron = 18;



// pocet legovanych kovu na vyrobu jednoho prutu
const int no_pocetnaprut = 1;
/*const int no_pocetnaprut_tin = 1;
const int no_pocetnaprut_copp = 1;
const int no_pocetnaprut_bron = 1;
const int no_pocetnaprut_iron = 1;
const int no_pocetnaprut_gold = 1;
const int no_pocetnaprut_plat = 1;
const int no_pocetnaprut_mith = 1;
const int no_pocetnaprut_adam = 1;
const int no_pocetnaprut_tita = 1;
const int no_pocetnaprut_silv = 1;
//const int no_pocetnaprut_coba = 1;
const int no_pocetnaprut_stin = 1;
const int no_pocetnaprut_mete = 1;
*/
