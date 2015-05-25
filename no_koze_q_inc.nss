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
const int id_Brichoohnivehobroucka= 2;
const int id_Kuzecernehomedveda = 3;
const int id_Kuzegrizzlyho = 4;
const int id_Kuzehnedehomedveda = 5;
const int id_Krunyrankhenga = 6;
const int id_Krunyrhakovce = 7;
const int id_Kuzejezevce = 8;
const int id_Krunyrrudehostira = 9;
const int id_Kuzekrysy = 10;
const int id_Krunyrzelvy =11;
const int id_Kuzekrysopsa = 12;
const int id_Okobaziliska = 13;
const int id_Kuzeopice = 14;
const int id_Sporymykoida= 15;
const int id_Kuzegorgona = 16;
const int id_Kuzenetopyra = 17;
const int id_Kuzepantera  = 18;
const int id_Kuzeprasete  = 19;
const int id_Kuzekrokodyla  = 20;
const int id_Kuzevyverny = 21;
const int id_Kuzevlka = 22;
const int id_Perisfingy = 23;
const int id_Kuzeworgha = 24;
const int id_Slizslimaka  = 25;
const int id_Hadikuze = 26;
const int id_Klepetoklepetnatce = 27;
const int id_Zihadlovosy = 28;
const int id_Kuzebarghesta = 29;
const int id_Srdcemephita = 30;
const int id_Kuzekrenshara = 31;
const int id_Kuzekrokodyla = 32;
const int id_Kuzelitehovlka = 33;
const int id_Ostenmantikory = 34;
const int id_Kuzerosomaka = 35;
const int id_Stahnutakuze  = 36;
const int id_Supinykortixe = 37;
const int id_Periplivnika = 38;
const int id_Kuzevlka = 39;
const int id_Kuzesedehotrhace = 40;
const int id_Kuzetygra = 41;
const int id_Krovkybrouka = 42;
const int id_Krunyrdigestera = 43;
const int id_Kuzejezevce = 44;
const int id_Krovkybrouka = 45;
const int id_Krovkyrohace = 46;
const int id_Krunyrhakovce = 47;
const int id_Kuzepantera  = 48;
const int id_Kuzekrysopsa = 49;
const int id_Stahnutakuze  = 50;
const int id_Kuzeprasete  = 51;
const int id_Hadikuze = 52;
const int id_Brichoohnivehobroucka= 53;


const string resref_Brichoohnivehobroucka = "me_ohnbro";
const string resref_Kuzecernehomedveda = "cnrskinblkbear";
const string resref_Kuzegrizzlyho = "cnrskingrizbear";
const string resref_Kuzehnedehomedveda = "cnrskinbrnbear";
const string resref_Krunyrankhenga = "ry_ankh_krun";
const string resref_Krunyrhakovce = "ry_hak_krun";
const string resref_Kuzejezevce = "cnrskinbadger";
const string resref_Krunyrrudehostira = "ry_rudst_krun";
const string resref_Kuzekrysy = "cnrskinrat";
const string resref_Krunyrzelvy = "ke_zelva_krun";
const string resref_Kuzekrysopsa = "ry_krysop_kuze";
const string resref_Okobaziliska = "ry_baz_oko";
const string resref_Kuzeopice = "ry_pral_op_kuze";
const string resref_Sporymykoida = "ry_myk_spor";
const string resref_Kuzegorgona = "ry_gorgon_kuze";
const string resref_Kuzenetopyra = "cnrskinbat";
const string resref_Kuzepantera  = "cnrskinpanther";
const string resref_Kuzeprasete  = "cnrskinboar";
const string resref_Kuzekrokodyla  = "ke_kuze_kroko";
const string resref_Kuzevyverny = "ry_vyver_kuze";
const string resref_Kuzevlka = "cnrskinwolf";
const string resref_Perisfingy = "ke_sfing_peri";
const string resref_Kuzeworgha = "cnrskinworg";
const string resref_Slizslimaka  = "ke_slim_sliz";
const string resref_Hadikuze = "ry_hadi_kuze";
const string resref_Klepetoklepetnatce = "ry_klep_klep";
const string resref_Zihadlovosy = "zihadlo_vosa";
const string resref_Kuzebarghesta = "ry_bargh_kuze";
const string resref_Srdcemephita = "ry_srdce_meph";
const string resref_Kuzekrenshara = "kuzekrenshara001";
const string resref_Kuzekrokodyla = "ry_krok_kuze";
const string resref_Kuzelitehovlka = "ry_litvlk_kuze";
const string resref_Ostenmantikory = "ry_mant_osten";
const string resref_Kuzerosomaka = "ry_ros_kuze";
const string resref_Stahnutakuze = "kuze";
const string resref_Supinykortixe = "ry_sup_kortix";
const string resref_Periplivnika = "peri_plivnika";
const string resref_Kuzevlka = "cnrskinwolf";
const string resref_Kuzesedehotrhace = "ry_sedtr_kuze";
const string resref_Kuzetygra = "me_kuze_tygr";
const string resref_Krovkybrouka = "ry_br_krovky"; // + "ry_br_krovky_2";
const string resref_Krunyrdigestera = "ry_cerst_krun";
const string resref_Krovkyrohace = "ry_kr_rohac";
*/
