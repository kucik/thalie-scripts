/*
    skript pro inicializaci Thalie craftu (tc)
    31.3.2008 Melvik
*/
#include "tc_constants"


void initPrices();
/*
    Pri startu serveru tato priradi resrefum itemu alchimystycke vlastnosti
    toto prirazeni bude v promenych na modulu ve tvaru
    ALCH_INREDIENCE_PREFIX + ResReF = string vlastnosti (napr. ai1010002003)
*/
void initIgredientsProperties();


void main()
{
    initPrices();
    initIgredientsProperties();
}


void initPrices()
{
    string MATERIAL_PRICE = "material price";
    float no_nasobitel = 0.25;
    object oModule = GetModule();
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut1",FloatToInt(5*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut2",FloatToInt(10*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut3",FloatToInt(20*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut4",FloatToInt(80*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut11",FloatToInt(120*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut8",FloatToInt(160*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut7",FloatToInt(250*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut5",FloatToInt(500*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut10",FloatToInt(600*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut9",FloatToInt(700*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut12",FloatToInt(1500*no_nasobitel));
    SetLocalInt(oModule,MATERIAL_PRICE + "tc_prut13",FloatToInt(2500*no_nasobitel));
}


void initIgredientsProperties()
{
    object oModule = GetModule();


// GENEROVANY KOD - NEPREPISOVAT (mozna uprava v exelu)
/* vlastnosti alchymistickych ingredienci start*/
/*
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnraloeleaf", "ai1025027045008004021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrthistleleaf", "ai1024072074016004021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina009", "ai1025032044055071008004");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina013", "ai1024086077073072065002113");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrblkcohoshroot", "ai2024026033042057016004");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba007", "ai1023035038039050051019018");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba005", "ai1022043066067069004002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba014", "ai1023053078079080082083085");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba008", "ai2023028034046049056019002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "me_ethetzl", "ai2030036058020019021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroomwht", "ai3030048058060070020019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroomblk", "ai3024037052072016019021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroomspot", "ai2023028034038039040075019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroomyel", "ai3029007095004015013009097");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroompurp", "ai3022062076005019021002111");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrmushroomred", "ai2023028034049019021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrlumpofclay", "ai2024057073016019021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_sliz_ichor", "ai3022062066076005019108");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "nw_it_msmlmisc25", "ai3022062066076005019108");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_ghoul_jatra", "ai1030054084020005019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_alcjedvak2", "ai1029007105106088087095004094");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_alcjedvak3", "ai1029099105029094004006015");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_alcjedvak1", "ai1029099089090091004013009");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina001", "ai1025027045008002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina008", "ai2023028035038046075019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "me_kloubk", "ai1030036054060064020005");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrcomfryroot", "ai1029100106096004015018");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrechinacearoot", "ai1022067005004002108112");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrginsengroot", "ai1025032044047055008071");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrgingerroot", "ai1029100106097004015013002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba009", "ai1025027044045047055071008002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina012", "ai1023053078079080082083085");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_mrchzr_krev", "ai3024026037052016042");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrhopsflower", "ai2025008004019002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrcalendulafwr", "ai2024074016004018019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrcatnipleaf", "ai1022066005004018019111");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrhazelleaf", "ai1024026033016004018021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrskullcapleaf", "ai1022043059005004018021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrcloverleaf", "ai1025027008021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrnettleleaf", "ai1029101089090091004009");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrpepmintleaf", "ai1025027008018002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrsageleaf", "ai1025032047008004");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_drap_maso", "ai1030048054020004018021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina002", "ai1024026031037061016");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba002", "ai2023028035046019004018");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina006", "ai1022043068069005004018021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina004", "ai1023040049050056019018");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba004", "ai1022041059062067069076110");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrspidersilk", "ai2024031042065016002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba010", "ai1024026031061074016");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina005", "ai1029101088004006013099");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "peri_plivnika", "ai1030048020021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba013", "ai1024086077073072065113");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_troproryt", "ai1030063064081020005021");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "sporymykoida", "ai2022043068005018002111112");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_popsl_vyh", "ai2024042061016004002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_vino_spory", "ai2024042061016004002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "ry_srdce_meph", "ai1022059068005004019109112");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba006", "ai1024033057074016002042");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrgarlicclove", "ai1022041005004018110108109");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina003", "ai1022041067069004110");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba015", "ai2023049051053056075019002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina011", "ai3023028050051056019002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina010", "ai2023034035039046051053019");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_bylina007", "ai3029102029004006015013");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba001", "ai1025027032044045008018");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba003", "ai2023028040050019004053");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "nw_it_msmlmisc06", "ai1030063070020005004021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "kh_zublicha", "ai1030081084020005019021002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "zihadlo_vosy", "ai1029102087004006015009");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrchamomilefwr", "ai1025027032018019002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrhawthornfwr", "ai1029103094004006013009018002");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba011", "ai1029103104106089090091096004");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "tc_houba012", "ai1029104088087094097004006");
SetLocalString(oModule, ALCH_INREDIENCE_PREFIX + "cnrangelicaleaf", "ai1025027032018019002");
*/


/* vlastnosti alchymistickych ingredienci END*/

/* alchymisticke vlastnosti START*/
/*
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "001", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "001", "bu");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "002", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "002", "nti");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "003", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "003", "mek");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "004", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "004", "dis");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "005", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "005", "kle");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "006", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "006", "sra");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "007", 21);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "007", "has");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "008", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "008", "amy");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "009", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "009", "ate");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "010", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "010", "ahy");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "011", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "011", "ate");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "012", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "012", "astr");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "013", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "013", "aorl");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "014", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "014", "asov");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "015", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "015", "alis");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "016", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "016", "akoc");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "017", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "017", "asil");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "018", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "018", "atrolo");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "019", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "019", "zle");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "020", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "020", "zva");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "021", 0);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "021", "zkri");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "022", 3);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "022", "sol");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "023", 4);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "023", "rez");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "024", 5);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "024", "chmug");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "025", 6);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "025", "li");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "026", 10);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "026", "tvr");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "027", 12);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "027", "lel");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "028", 15);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "028", "poz");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "029", 15);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "029", "breke");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "030", 17);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "030", "lema");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "031", 20);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "031", "nev");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "032", 22);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "032", "les");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "033", 23);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "033", "kane");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "034", 25);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "034", "orl");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "035", 26);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "035", "sov");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "036", 26);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "036", "zosm");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "037", 26);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "037", "vdu");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "038", 27);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "038", "lis");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "039", 28);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "039", "koc");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "040", 29);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "040", "sil");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "041", 29);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "041", "buch");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "042", 30);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "042", "ku");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "043", 31);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "043", "ope");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "044", 32);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "044", "trolo");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "045", 33);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "045", "lev");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "046", 34);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "046", "omy");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "047", 35);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "047", "tret");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "048", 39);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "048", "fa");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "049", 36);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "049", "ote");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "050", 37);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "050", "bop");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "051", 40);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "051", "ohy");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "052", 38);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "052", "prone");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "053", 42);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "053", "sko");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "054", 43);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "054", "ost");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "055", 44);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "055", "lek");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "056", 46);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "056", "bosi");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "057", 45);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "057", "kmn");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "058", 47);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "058", "vopo");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "059", 48);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "059", "osti");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "060", 50);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "060", "dis");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "061", 53);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "061", "vyne");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "062", 52);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "062", "zeo");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "063", 51);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "063", "man");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "064", 55);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "064", "cim");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "065", 57);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "065", "nahle");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "066", 56);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "066", "zec");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "067", 58);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "067", "zee");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "068", 59);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "068", "kysti");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "069", 60);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "069", "zek");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "070", 62);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "070", "dewa");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "071", 63);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "071", "leu");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "072", 65);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "072", "prt");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "073", 67);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "073", "skam");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "074", 69);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "074", "kama");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "075", 70);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "075", "ste");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "076", 72);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "076", "thu");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "077", 73);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "077", "pravi");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "078", 75);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "078", "orl");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "079", 76);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "079", "sov");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "080", 77);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "080", "lis");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "081", 78);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "081", "shash");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "082", 79);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "082", "koc");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "083", 81);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "083", "sil");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "084", 85);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "084", "grema");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "085", 88);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "085", "boz");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "086", 90);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "086", "trago");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "087", 26);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "087", "umreke");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "088", 16);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "088", "motreke");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "089", 11);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "089", "fujeke");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "090", 14);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "090", "chyteke");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "091", 12);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "091", "pajeke");

SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "094", 8);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "094", "craw");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "095", 5);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "095", "taggit");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "096", 17);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "096", "pifi");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "097", 13);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "097", "sassonne");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "098", 21);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "098", "haunsp");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "099", 14);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "099", "jhuil");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "100", 16);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "100", "kamma");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "101", 30);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "101", "mordva");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "102", 12);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "102", "katak");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "103", 29);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "103", "rhul");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "104", 27);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "104", "sezar");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "105", 21);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "105", "ziran");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "106", 6);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "106", "place");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "107", 34 );
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "107", "sze");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "108", 35);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "108", "sle");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "109", 36);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "109", "svz");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "110", 37);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "110", "soh");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "111", 24);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "111", "sdo");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "112", 25);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "112", "szl");
SetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + "113", 80);
SetLocalString(oModule, ALCH_PROPERTY_NAME_PREFIX + "113", "pøed");
*/

/* alchymisticke vlastnosti END*/

}
