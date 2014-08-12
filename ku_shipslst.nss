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
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                                        // odjezd ve 24
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 2 - Kahzet --> Kel

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                                        // odjezd ve 23
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 3 - Charaxss - Zril´Mar

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                      // odjezd v 24
    stShip.m_sName      = "Charaxss - Zril´Mar";        // Nazev trasy
    stShip.m_nCost      = 100;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_cha1";          // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_zril_char_c";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_char_zril_l";         // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_zril_char_z";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_vyvolavac3";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik3";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 4 - Hagol - Zril´Mar

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd ve 23
    stShip.m_sName      = "Hagol - Zril´Mar";           // Nazev trasy
    stShip.m_nCost      = 100;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_hag";           // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_zril_hag_h";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_hag_zril_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_zril_hag_z";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_otrokprod_hag";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik4";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 1.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 5 - Charaxss - Hagol

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                      // odjezd ve 24
    stShip.m_sName      = "Charaxss - Hagol";           // Nazev trasy
    stShip.m_nCost      = 50;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_cha1";          // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_char_hag_c";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_char_hag_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_hag_char_h";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_vyvolavac3";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik5";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 6 - Hagol - Charaxss

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd v 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd ve 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd v 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                     // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                     // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                     // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                     // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                     // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                     // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                     // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                     // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                     // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                     // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                     // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                     // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                     // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                     // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                     // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                     // odjezd ve 24
    stShip.m_sName      = "Hagol - Charaxss";           // Nazev trasy
    stShip.m_nCost      = 50;                           // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_hag";           // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_hag_char_h";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_hag_char_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_char_hag_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_otrokprod_hag";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik6";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 7 - Charaxss - Che´el del Wlalths

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                     // odjezd ve 24
    stShip.m_sName      = "Charaxss - Che´el del Wlalths"; // Nazev trasy
    stShip.m_nCost      = 60;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_cha2";          // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_che_char_c";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_char_che_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_che_char_w";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_otrokprod_cha2";          // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik7";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 8 - Che´el del Wlalths - Charaxss

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                    // odjezd v 24
    stShip.m_sName      = "Che´el del Wlalths - Charaxss"; // Nazev trasy
    stShip.m_nCost      = 60;                           // Cena listku
    stShip.m_nSpent     = 4;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ph_otrokprod_che";           // Tag prodavace listku
    stShip.m_sPort      = "ph_lod_che_char_w";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ph_lod_che_char_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ph_lod_che_char_c";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ph_otrokprod_che";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ph_kormidelnik8";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 9 - Karatha --> Alwariel

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd ve 23
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 10 - Alwariel --> Karatha

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd ve 23
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 11 - Karatha - Kel-A-Hazr

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                      // odjezd ve 4
    stShip.m_sName      = "Karatha - Kel-A-Hazr";        // Nazev trasy
    stShip.m_nCost      = 140;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_kar2";          // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kar_kel_c";         // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kar_kel_l";         // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kar_kel_z";         // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kar2";              // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_kake";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 12 - Kel-A-Hazr - Karatha

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd ve 24
    stShip.m_sName      = "Kel-A-Hazr - Karatha";           // Nazev trasy
    stShip.m_nCost      = 140;                          // Cena listku
    stShip.m_nSpent     = 3;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lisprod_kel2";           // Tag prodavace listku
    stShip.m_sPort      = "ry_lod_kel_kar_c";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_lod_kel_kar_l";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_lod_kel_kar_z";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lisprod_kel2";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_kormidelnik_keka";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 13 - Kel-A-Hazr - Alwariel

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                        // odjezd ve 23
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

 //  Lodni linka 14 - Alwariel - Kel-A-Hazr

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd ve 23
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
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 15 - Che´el del Wlalths - Prahvozd

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                     // odjezd v 23
    stShip.m_sName      = "Che´el del Wlalths - Prahvozd"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 8;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lurdo_pr_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_cheel_to_prhv_1";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_cheel_to_prhv_2";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_cheel_to_prhv_3";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lurdo_pr_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_lurdo_pr_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 16 - Prahvozd - Che´el del Wlalths

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                     // odjezd v 23
    stShip.m_sName      = "Che´el del Wlalths - Prahvozd"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 8;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lurdo_pr_2a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_prhv_to_cheel_1";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_prhv_to_cheel_2";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_prhv_to_cheel_3";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lurdo_pr_2a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_lurdo_pr_2b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 17 - Hag Grar - Kel-A-Hazr

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                     // odjezd v 23
    stShip.m_sName      = "Hag Grar - Kel-A-Hazr"; // Nazev trasy
    stShip.m_nCost      = 220;                           // Cena listku
    stShip.m_nSpent     = 10;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_murdo_kh_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_kel_1";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_kel_2a";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_kel_3";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_murdo_kh_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_murdo_kh_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 18 - Kel-A-Hazr - Hag Grar

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );                       // odjezd v 23
    stShip.m_sName      = "Kel-A-Hazr - Hag Grar"; // Nazev trasy
    stShip.m_nCost      = 220;                           // Cena listku
    stShip.m_nSpent     = 10;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_murdo_hg_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_kel_3";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_kel_2b";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_kel_1";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_murdo_hg_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_murdo_hg_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 19 - Hag Grar - Vychodni pobrezi

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Hag Grar - Vychodni pobrezi"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 10;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lorna_vp_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_vych_1";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_vych_2a";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_vych_3";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lorna_vp_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_lorna_vp_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 20 - Vychodni pobrezi - Hag Grar

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Vychodni pobrezi - Hag Grar"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 10;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_lorna_hg_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_vych_3";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_vych_2b";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_vych_1";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_lorna_hg_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_lorna_hg_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 21 - Hag Grar - Zapadni pobrezi

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Hag Grar - Zapadni pobrezi"; // Nazev trasy
    stShip.m_nCost      = 120;                           // Cena listku
    stShip.m_nSpent     = 6;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_hamar_hg_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_zap_1";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_zap_2a";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_zap_3";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_hamar_hg_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_hamar_hg_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 22 - Zapadni pobrezi - Hag Grar

    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Zapadni pobrezi - Hag Grar"; // Nazev trasy
    stShip.m_nCost      = 120;                           // Cena listku
    stShip.m_nSpent     = 6;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_hamar_zp_1a";           // Tag prodavace listku
    stShip.m_sPort      = "ry_hag_to_zap_3";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_hag_to_zap_2b";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_hag_to_zap_1";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_hamar_zp_1a";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_hamar_zp_1b";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 23 - Dar Garag - Prahvozd
    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Dar Garag - Prahvozd"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 8;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_dar_gar_kap";           // Tag prodavace listku
    stShip.m_sPort      = "ry_dar_garag";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_dgar_to_pra";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_prahv_hlkot";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_dar_gar_kap";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_dar_gar_kap_1";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

//  Lodni linka 24 - Prahvozd - Dar Garag
    stShip = KU_CreateShip();
    KU_AddDepartHour( stShip, 1 );                      // odjezd ve 1
    KU_AddDepartHour( stShip, 2 );                      // odjezd v 2
    KU_AddDepartHour( stShip, 3 );                      // odjezd v 3
    KU_AddDepartHour( stShip, 4 );                     // odjezd v 4
    KU_AddDepartHour( stShip, 5 );                     // odjezd ve 5
    KU_AddDepartHour( stShip, 6 );                     // odjezd v 6
    KU_AddDepartHour( stShip, 7 );                     // odjezd ve 7
    KU_AddDepartHour( stShip, 8 );                     // odjezd ve 8
    KU_AddDepartHour( stShip, 9 );                      // odjezd ve 9
    KU_AddDepartHour( stShip, 10 );                      // odjezd ve 10
    KU_AddDepartHour( stShip, 11 );                      // odjezd ve 11
    KU_AddDepartHour( stShip, 12 );                      // odjezd ve 12
    KU_AddDepartHour( stShip, 13 );                      // odjezd ve 13
    KU_AddDepartHour( stShip, 14 );                      // odjezd ve 14
    KU_AddDepartHour( stShip, 15 );                      // odjezd ve 15
    KU_AddDepartHour( stShip, 16 );                      // odjezd ve 16
    KU_AddDepartHour( stShip, 17 );                      // odjezd ve 17
    KU_AddDepartHour( stShip, 18 );                      // odjezd ve 18
    KU_AddDepartHour( stShip, 19 );                      // odjezd ve 19
    KU_AddDepartHour( stShip, 20 );                      // odjezd ve 20
    KU_AddDepartHour( stShip, 21 );                      // odjezd ve 21
    KU_AddDepartHour( stShip, 22 );                      // odjezd ve 22
    KU_AddDepartHour( stShip, 23 );                      // odjezd ve 23
    KU_AddDepartHour( stShip, 24 );
    stShip.m_sName      = "Prahvozd - Dar Garag"; // Nazev trasy
    stShip.m_nCost      = 180;                           // Cena listku
    stShip.m_nSpent     = 8;                            // cas, straveny na mori
    stShip.m_nMaxDelay  = 1;                            // Maximalni zpozdeni
    stShip.m_sMerchant  = "ry_hlu_kot_kap";           // Tag prodavace listku
    stShip.m_sPort      = "ry_prahv_hlkot";          // Tag bodu, odkud lod vyrazi
    stShip.m_sSea       = "ry_pra_to_dgar";          // Tag bodu na mori
    stShip.m_sFinish    = "ry_dar_garag";          // Tag cile cesty
    stShip.m_sCabin     = "";                           // Tag kajuty
    stShip.m_sShouter_p = "ry_hlu_kot_kap";           // Tag vyvolavace v pristavu
    stShip.m_sShouter_s = "ry_dar_gar_kap_2";            // Tag vyvolavace na mori
//    stShip.m_fStartTime = 6.0;                          // Prvni odjezd lodi
//    stShip.m_iInterval  = 10;                            // Iterval lodi v minutach
    KU_SaveShip( stShip );

// Konec lodni linky

///////////////////////////////////////////////////
// Konec definice lodnich linek
///////////////////////////////////////////////////
}

