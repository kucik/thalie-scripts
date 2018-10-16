/*
 * release 08.01.2008 Kucik
 * rev 30.12.2008 Prepsani na pouzivani zpozdenych volani misto heartbeatu
 *                Pridani intervalu odjezdu.
 *                Oprava linek do Hagu
 */
// Private function for the ships script. Do not use.
struct tShips KU_CreateShip( );

// Private function for the ships script. Do not use.
void KU_AddDepartHour( struct tShips a_stShip, int a_nHour );

// Private function for the subraces script. Do not use.
void KU_SaveShip( struct tShips a_stShip );

void KU_DefineShips()
{
    struct tShips stShip;

///////////////////////////////////////////////////////////////////////////
// Definice lodnich linek
///// photter: neprepisujte zadnou linku, tvorte dalsi
///// linky 1 - 8 zabrany pro podtemno, linky 9 a 10 rezerva pro podtemno
///// prvni volna linka k pouziti je 11 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//////////////////////////////////////////////////////////////////////////

  //  Lodni linka 1 - Kel --> Kahzet

    stShip = KU_CreateShip();
    stShip.m_sName      = "Poustni mesto - Kahzet";        // Nazev trasy
    stShip.m_nCost      = 100;                          // Cena listku
    stShip.m_nSpent     = 6;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "sh_kelprod_kahz";          // Tag prodavace listku
    stShip.m_sPort      = "sh_lod_kel_kah_z";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "sh_lod_kel_kah_l";         // Tag bodu na mori
    stShip.m_sFinish    = "sh_lod_kel_kah_c";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "sh_kelvyvolavac_kahzet";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "sh_kelkormidelnik_kahzet";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 2 - Kahzet --> Kel

    stShip = KU_CreateShip();
    stShip.m_sName      = "Kahzet - Poustni mesto";        // Nazev trasy
    stShip.m_nCost      = 100;                          // Cena listku
    stShip.m_nSpent     = 6;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "sh_kahzprod_kel";          // Tag prodavace listku
    stShip.m_sPort      = "sh_lod_kah_kel_z";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "sh_lod_kah_kel_l";         // Tag bodu na mori
    stShip.m_sFinish    = "sh_lod_kah_kel_c";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "sh_kahzvyvolavac1";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "sh_kahzkormidelnik1";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 1.1;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 9 - Karatha --> Alwariel

    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha - Alwariel";        // Nazev trasy
    stShip.m_nCost      = 150;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_kar1";          // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kar_alw_z";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kar_alw_l";         // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kar_alw_c";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kar1";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_kalw";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 10 - Alwariel --> Karatha

    stShip = KU_CreateShip();
    stShip.m_sName      = "Alwariel - Karatha";           // Nazev trasy
    stShip.m_nCost      = 180;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_alw";          // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_alw_kar_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_alw_kar_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_alw_kar_h";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_alw";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_alwk";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 11 - Karatha - Kel-A-Hazr

    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha - Kel-A-Hazr";        // Nazev trasy
    stShip.m_nCost      = 140;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "di_kk_k_dm_abhal";          // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kar_kel_c";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kar_kel_l";         // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kar_kel_z";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kar2";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_kake";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 12 - Kel-A-Hazr - Karatha

    stShip = KU_CreateShip();
    stShip.m_sName      = "Kel-A-Hazr - Karatha";           // Nazev trasy
    stShip.m_nCost      = 140;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "di_kah_pristav_abhal";           // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kel_kar_c";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kel_kar_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kel_kar_z";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kel2";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_keka";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 13 - Kel-A-Hazr - Alwariel

    stShip = KU_CreateShip();
    stShip.m_sName      = "Kel-A-Hazr - Alwariel";           // Nazev trasy
    stShip.m_nCost      = 150;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_kel1";          // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kel_alw_c";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kel_alw_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kel_alw_z";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kel1";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_keal";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 14 - Alwariel - Kel-A-Hazr

    stShip = KU_CreateShip();
    stShip.m_sName      = "Alwariel - Kel-A-Hazr";           // Nazev trasy
    stShip.m_nCost      = 150;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_alw1";           // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_alw_kel_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_alw_kel_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_alw_kel_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_alw1";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_alke";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 25 -  Kel-A-Hazr -> Paseracke kotviste
    stShip = KU_CreateShip();
    stShip.m_sName      = "Kel-A-Hazr -> Paseracke kotviste"; // Nazev trasy
    stShip.m_nCost      = 300;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kelprod_lov";           // Tag prodavace listku
    stShip.m_sPort      = "ke_lod_kel_lov_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_lod_kel_lov_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_lod_lov_kel_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_kapkellov";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_kellov_tam";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 20;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 26 -  Paseracke kotviste -> Kel-A-Hazr
    stShip = KU_CreateShip();
    stShip.m_sName      = "Paseracke kotviste -> Kel-A-Hazr"; // Nazev trasy
    stShip.m_nCost      = 300;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_lovprod_kel";           // Tag prodavace listku
    stShip.m_sPort      = "ke_lod_lov_kel_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_lod_lov_kel_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_lod_kel_lov_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_kaplovkel";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_lovkel_tam";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 20;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky


//  Lodni linka 27 Karatha -> Dornovo Utociste
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Dornovo utociste"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kar_dorn_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kar_dorn_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kar_dorn_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kar_dorn_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_karvzducholod";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_karvzduch_vzducholod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime= 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 20;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 28 -  Paseracke kotviste -> Kel-A-Hazr
    stShip = KU_CreateShip();
    stShip.m_sName      = "Dornovo utociste -> Karatha"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_dorn_kar_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_dorn_kar_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_dorn_kar_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_dorn_kar_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_dornvzducholod";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_dornvzduch_lod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 20;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 29 Karatha -> Doubkov
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Doubkov"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kar_prod_lod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kar_doub_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kar_doub_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kar_doub_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_karatadoubkov";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_karatadoub_lod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );


//  Lodni linka 30 Doubkov -> Karatha
    stShip = KU_CreateShip();
    stShip.m_sName      = "Doubkov -> Karatha"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_doub_prodl";           // Tag prodavace listku
    stShip.m_sPort      = "ke_doub_kar_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_doub_kar_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_doub_kar_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_doubkovlod";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_doubkar_lod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 31 Kel-A-Hazr -> Korinkov
    stShip = KU_CreateShip();
    stShip.m_sName      = "Kel-A-Hazr -> Korinkov"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kah_prodl";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kah_kor_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kah_kor_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kah_kor_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_kahkorpl";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_kahpl_lod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 32 Korinkov -> Kel-A-Hazr
    stShip = KU_CreateShip();
    stShip.m_sName      = "Korinkov -> Kel-A-Hazr"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kor_prodl";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kor_kah_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kor_kah_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kor_kah_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_korinkovlod";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_korinkov_plavlod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );


//  Lodni linka 33 Karatha -> Pevnost Ostroh
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Pevnost Ostroh"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kar_ostprod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kar_ost_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kar_ost_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kar_ost_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_karosttam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_karost_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );


//  Lodni linka 34 Pevnost Ostroh -> Karatha
    stShip = KU_CreateShip();
    stShip.m_sName      = "Pevnost Ostroh -> Karatha"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_ost_prodkar";           // Tag prodavace listku
    stShip.m_sPort      = "ke_ost_kar_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_ost_kar_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_ost_kar_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_ostkartam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_ostkat_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );


//  Lodni linka 35 Karatha -> Pevnost Petronika
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Pevnost Petronika"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_petr_prodkar";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kar_petr_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kar_petr_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kar_petr_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_karpetrtam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_karpetr_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );


//  Lodni linka 36 Pevnost Petronika -> Karatha
    stShip = KU_CreateShip();
    stShip.m_sName      = "Pevnost Petronika -> Karatha"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kar_prodost";           // Tag prodavace listku
    stShip.m_sPort      = "ke_petr_kar_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_petr_kar_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_petr_kar_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_petrkartam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_petrkar_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );


//  Lodni linka 37 Karatha -> Isil
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Isil"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kar_prodisil";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kar_is_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kar_is_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kar_is_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_karisiltam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_karisil_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );


//  Lodni linka 38 Isil -> Karatha
    stShip = KU_CreateShip();
    stShip.m_sName      = "Isil -> Karatha"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_isil_prodkar";           // Tag prodavace listku
    stShip.m_sPort      = "ke_is_kar_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_is_kar_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_is_kar_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_isilkartam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ke_isilkar_povoz";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    stShip.m_iType      = 2;                              // Dostavnik
    KU_SaveShip( stShip );



//  Lodni linka 39 Kahzet -> Daf Jamova hlubina
    stShip = KU_CreateShip();
    stShip.m_sName      = "Kahzet -> Daf Jamova hlubina"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kahdaf_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kah_daf_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kah_daf_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kah_daf_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "ke_kahdaftam";                           // Tag kajuty
    stShip.m_sShouter_p = "";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );



//  Lodni linka 40 Daf Jamova hlubina -> Kahzet
    stShip = KU_CreateShip();
    stShip.m_sName      = "Daf Jamova hlubina -> Kahzet"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_dafkah_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_daf_kah_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_daf_kah_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_daf_kah_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_dafkahtam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );



//  Lodni linka 41 Kahzet -> Houbove tunely
    stShip = KU_CreateShip();
    stShip.m_sName      = "Kahzet -> Houbove tunely"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kahht_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kah_ht_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kah_ht_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kah_ht_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_kahhttam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );



//  Lodni linka 42 Houbove tunely -> Kahzet
    stShip = KU_CreateShip();
    stShip.m_sName      = "Houbove tunely -> Kahzet"; // Nazev trasy
    stShip.m_nCost      = 100;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_htkah_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_ht_kah_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_ht_kah_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_ht_kah_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_htkahtam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );


//  Lodni linka 43 Kel-A-Hazr -> Murgond
    stShip = KU_CreateShip();
    stShip.m_sName      = "Kel-A-Hazr -> Murgond"; // Nazev trasy
    stShip.m_nCost      = 120;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kahmur_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_kah_mur_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kah_mur_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kah_mur_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_kahmurtam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 44 Murgond -> Kel-A-Hazr
    stShip = KU_CreateShip();
    stShip.m_sName      = "Murgond -> Kel-A-Hazr"; // Nazev trasy
    stShip.m_nCost      = 120;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_murkah_prod";           // Tag prodavace listku
    stShip.m_sPort      = "ke_mur_kah_lod_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_mur_kah_lod_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_mur_kah_lod_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ke_murkahtam";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka 45 Alwariel -> Korinkov
    stShip = KU_CreateShip();
    stShip.m_sName      = "Alwariel -> Korinkov"; // Nazev trasy
    stShip.m_nCost      = 80;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kap_alw_korinkov";        // Tag prodavace listku
    stShip.m_sPort      = "ke_lod_alw_kor_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_alw_kor_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_alw_kor_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );


//  Lodni linka 46 Korinkov -> Alwariel
    stShip = KU_CreateShip();
    stShip.m_sName      = "Korinkov -> Alwariel"; // Nazev trasy
    stShip.m_nCost      = 80;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ke_kap_korinkov_alw";           // Tag prodavace listku
    stShip.m_sPort      = "ke_lod_kor_alw_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ke_kor_alw_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ke_kor_alw_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );


//  Lodni linka Z Karathy do Tartenu
    stShip = KU_CreateShip();
    stShip.m_sName      = "Karatha -> Tarten"; // Nazev trasy
    stShip.m_nCost      = 80;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_kar_tarprod";           // Tag prodavace listku
    stShip.m_sPort      = "ry_kar_tar_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_kar_tart_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_kar_tar_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_kar_tarprod";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

//  Lodni linka Z Tartenu do Karathy
    stShip = KU_CreateShip();
    stShip.m_sName      = "Tarten - Karatha"; // Nazev trasy
    stShip.m_nCost      = 80;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_tar_karprod";           // Tag prodavace listku
    stShip.m_sPort      = "ry_tar_kar_dost_z";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_tart_kar_dost_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_tar_kar_dost_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_tar_karprod";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
    stShip.m_iInterval  = 5;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

///////////////////////////////////////////////////
// Konec definice lodnich linek
///////////////////////////////////////////////////
}
