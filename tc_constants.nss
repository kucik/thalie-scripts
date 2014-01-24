/*
 KONSTANTY TC(Thalie craft)
*/

// pocet remesel
const int TC_CRAFTS_COUNT = 2;

// identifikatory odvetvi craftu
const int TC_ALCHEMY = 1;
const int TC_ARMORCRAFT = 2;

// pro promene na postave s ulozenymi xp za craft
const string TC_XP_PREFIX = "tcXPSystem";

//Neviditelnej Placeable
const string TC_INVIS_PLACEABLE = "tc_invis_placeable";




/*
   KONSTANTY ALCHYMIE - START
*/
//prefix promenych ktere pridavaji vlastnosti ingrediencim
const string ALCH_INREDIENCE_PREFIX = "tcAlchemyIngPro";
//prefix promenych ktere reprezentuji vlastnosti ingredienci
// sila vlastnosti
const string ALCH_PROPERTY_STR_PREFIX  = "tcAlchemyProStr";
// jmeno vlastnosti (zkratka na jmeno lektvaru
const string ALCH_PROPERTY_NAME_PREFIX = "tcAlchemyProName";


const int ALCHEMY_DEBUG = 0;

// upravy ingredieci
const int WORKFLOW_DRCENI = 1;
const int WORKFLOW_DESTILACE = 2;
const int WORKFLOW_KONDENZACE = 3;

// privlastky ingredienci po zpravcovani
const string DRCENI_POSTFIX = "rozdrceno";
const string DESTILACE_POSTFIX = "vydestilovano";
const string KONDENZACE_POSTFIX = "zkondenzovano";



// kucikovy

const int TC_ALCH_PROPERTIES_SUM = 200;      // Pocet existujicich vlastnosti
const int TC_ALCH_INGREDIENCES = 5;          // Maximalni pocet ingredienci v kotli
const int TC_ALCH_CRASHTABLE_SIZE = 30;      // Kolik mame navzajem se nesnajich smesi
const string TC_ALCH_CRASHPROP_A = "TC_CRASHTABLE_PROP_A_";  // Tabulka neslucitelnych latek
const string TC_ALCH_CRASHPROP_B = "TC_CRASHTABLE_PROP_B_";
const string TC_ALCH_BOTTLE1_TAG = "flaska";   // Tag flasky
const string TC_ALCH_BOTTLE2_TAG = "flakon";   // Tag flasky
const string TC_ALCH_POTION1_RESREF = "tc_alch_potion1";   // Tag flasky
const string TC_ALCH_POTION2_RESREF = "tc_alch_potion2";   // Tag flasky
// opraveno ve skriptech na ALCH_PROPERTY_STR_PREFIX // const string TC_ALCH_PROP_KAT_TABLE = "ALCH_PROPERTY_STR_PREFIX";  // Prefix tabulky pro pozaovanou hodnotu katalyzatoru
const int TC_ALCH_LVL_MISTR = 14;
const int TC_ALCH_LVL_VELMISTR = 19;

/*
   KONSTANTY ALCHYMIE - END
*/


