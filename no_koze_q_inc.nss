// iniciace. Musi obsahovat pocet surovin, ktere se vykupuji, jestli neco chybi.. srry :D


#include "ku_libtime"
#include "aps_include"

struct pelt_q
{
    int id;
    string sQuality;
    string sResRef;
    string sName;
};


struct pelt_q tcq_GetRandomPelt() {
  struct pelt_q quest;
  object oNPC = OBJECT_SELF;

  string sSql = "SELECT id, resref quality from craft_material WHERE type = 'pelt' AND quality <= '4' ORDER BY RAND() LIMIT 0,1;";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    quest.id = StringToInt(SQLGetData(1));
    quest.sResRef = SQLGetData(2);
    quest.sQuality = SQLGetData(3);

    // To get name
    if(GetStringLength(quest.sResRef) > 0 ) {
      object oNew = CreateItemOnObject(quest.sResRef, oNPC, 1);
      quest.sName = GetName(oNew);
      DestroyObject(oNew);
    }
  }
  else {
    SpeakString("Chyba! Není mozne vybrat quest!");
    quest.id = -1;
  }

  return quest;
}

/*const int pocet_surovin = 53;

const int id_Supinybuleta = 1;
const int id_Kuzebilehojelena = 2;
const int id_Kuzecernehomedveda = 3;
const int id_Kuzegrizzlyho = 4;
const int id_Kuzehnedehomedveda = 5;
const int id_Kuzejaguara = 6;
const int id_Kuzejelena = 7;
const int id_Kuzejezevce = 8;
const int id_Kuzekocky = 9;
const int id_Kuzekrysy = 10;
const int id_Kuzelednihomedveda =11;
const int id_Kuzeleoparda = 12;
const int id_Kuzelitehomedveda = 13;
const int id_Kuzelitehotygra = 14;
const int id_Kuzelva = 15;
const int id_Kuzemalara = 16;
const int id_Kuzenetopyra = 17;
const int id_Kuzepantera  = 18;
const int id_Kuzeprasete  = 19;
const int id_Kuzepumy  = 20;
const int id_Kuzeskalnihomedveda = 21;
const int id_Kuzevlka = 22;
const int id_Kuzevola = 23;
const int id_Kuzeworgha = 24;
const int id_Kuzezimnihovlka  = 25;
const int id_Hadikuze = 26;
const int id_Kuzetygrodlaka = 27;
const int id_Kuzealansijskehotygra = 28;
const int id_Kuzebarghesta = 29;
const int id_Kuzegorily = 30;
const int id_Kuzekrenshara = 31;
const int id_Kuzekrokodyla = 32;
const int id_Kuzelitehovlka = 33;
const int id_Kuzeprastarehovlka = 34;
const int id_Kuzerosomaka = 35;
const int id_Kuzesnezneholeoparda  = 36;
const int id_Kuzesneznehotygra = 37;
const int id_Kuzesovomedveda = 38;
const int id_Kuzesavlozubekocky = 39;
const int id_Kuzesedehotrhace = 40;
const int id_Kuzetygra = 41;
const int id_Kuzevelkehoworgha = 42;
const int id_Kuzeyettiho = 43;
const int id_Kuzezralokav = 44;
const int id_Krovkybrouka = 45;
const int id_Krovkyrohace = 46;
const int id_Peribeldskehoorla = 47;
const int id_Peritritona = 48;
const int id_Perihavrana = 49;
const int id_Peripapouska = 50;
const int id_Perisovy = 51;
const int id_Perizesokola = 52;
const int id_Ptaciperi = 53;


const string resref_Kuzebilehojelena = "cnrskinwhitestag";
const string resref_Kuzecernehomedveda = "cnrskinblkbear";
const string resref_Kuzegrizzlyho = "cnrskingrizbear";
const string resref_Kuzehnedehomedveda = "cnrskinbrnbear";
const string resref_Kuzejaguara = "cnrskinjaguar";
const string resref_Kuzejelena = "cnrskindeer";
const string resref_Kuzejezevce = "cnrskinbadger";
const string resref_Kuzekocky = "cnrskincragcat";
const string resref_Kuzekrysy = "cnrskinrat";
const string resref_Kuzelednihomedveda = "cnrskinpolarbear";
const string resref_Kuzeleoparda = "cnrskinleopard";
const string resref_Kuzelitehomedveda = "cnrskindb";
const string resref_Kuzelitehotygra = "cnrskintiger";
const string resref_Kuzelva = "cnrskinlion";
const string resref_Kuzemalara = "cnrskinmalar";
const string resref_Kuzenetopyra = "cnrskinbat";
const string resref_Kuzepantera  = "cnrskinpanther";
const string resref_Kuzeprasete  = "cnrskinboar";
const string resref_Kuzepumy  = "cnrskincougar";
const string resref_Kuzeskalnihomedveda = "ry_skalm_kuze";
const string resref_Kuzevlka = "cnrskinwolf";
const string resref_Kuzevola = "cnrskinox";
const string resref_Kuzeworgha = "cnrskinworg";
const string resref_Kuzezimnihovlka  = "cnrskinwinwolf";
const string resref_Hadikuze = "ry_hadi_kuze";
const string resref_Kuzetygrodlaka = "ry_tygrodl_kuze";
const string resref_Kuzealansijskehotygra = "kuzealansijskeho";
const string resref_Kuzebarghesta = "ry_bargh_kuze";
const string resref_Kuzegorily = "ry_gor_kuze";
const string resref_Kuzekrenshara = "kuzekrenshara001";
const string resref_Kuzekrokodyla = "ry_krok_kuze";
const string resref_Kuzelitehovlka = "ry_litvlk_kuze";
const string resref_Kuzeprastarehovlka = "ry_prvl_kuze";
const string resref_Kuzerosomaka = "ry_ros_kuze";
const string resref_Kuzesnezneholeoparda  = "ry_snl_kuze";
const string resref_Kuzesneznehotygra = "ry_snt_kuze";
const string resref_Kuzesovomedveda = "kuzeowlbeara";
const string resref_Kuzesavlozubekocky = "ry_szkoc_kuze";
const string resref_Kuzesedehotrhace = "ry_sedtr_kuze";
const string resref_Kuzetygra = "me_kuze_tygr";
const string resref_Kuzevelkehoworgha = "it_cmat_leath001";
const string resref_Kuzeyettiho = "ry_kuz_yetti";
const string resref_Kuzezralokav = "ry_zral_kuze";
const string resref_Krovkybrouka = "ry_br_krovky"; // + "ry_br_krovky_2";
const string resref_Krovkyrohace = "ry_kr_rohac";
const string resref_Peribeldskehoorla = "it_amt_feath001";
const string resref_Peritritona = "ry_grif_peri";
const string resref_Perihavrana = "cnrfeatherraven";
const string resref_Peripapouska = "ry_pap_peri";
const string resref_Perisovy = "cnrfeatherowl";
const string resref_Perizesokola = "cnrfeatherfalcon";
const string resref_Ptaciperi = "ry_peri";
const string resref_Supinybuleta = "supinybuleta";
*/
