
//::///////////////////////////////////////////////
//:: NW_O2_CONINCLUDE.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  This include file handles the random treasure
  distribution for treasure from creatures and containers

 [ ] Documented
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent, Andrew
//:: Created On:  November - May
//:://////////////////////////////////////////////
// :: MODS
// April 23 2002: Removed animal parts. They were silly.
// May 6 2002: Added Undead to the EXCLUSION treasure list (they drop nothing now)
//  - redistributed treasure (to lessen amoun   t of armor and increase 'class specific treasure'
//  - Rangers with heavy armor prof. will be treated as Fighters else as Barbarians
//  - Gave wizards, druids and monk their own function
// MAY 29 2002: Removed the heal potion from treasure
//              Moved nymph cloak +4 to treasure bracket 6
//              Added Monk Enhancement items to random treasure
//
//
// rev. 07.01.2008 Kucik : Pridany funkce pro kontrolu, lootovani a vlastni kontrola
// rev. 08.01.2008 Kucik drobne upravy
// rev. 11.01.2008 Kucik Loot funkce presunuty do ku_loot_inc
// rev. 20.01.2008 Kucik Zmena obsahu lootu, zruseny socketove veci
// rev. 04.03.2008 Kucik pridan chlast
//


#include "ku_loot_inc"               //
//#include "NW_I0_GENERIC"
#include "j_inc_constants"

// * ---------
// * CONSTANTS
// * ---------

/**
 * LOOT ITEM TYPES 
 */
const int LOOT_TYPE_DISP           =1;
const int LOOT_TYPE_AMMO           =2;
const int LOOT_TYPE_GOLD           =4;             // actually gold and gems
const int LOOT_TYPE_ITEM           =8;            // char specific Item
const int LOOT_TYPE_BOOK           =16;
const int LOOT_TYPE_ANIMAL         =32;
const int LOOT_TYPE_JUNK           =64;
const int LOOT_TYPE_GEM            =128;
const int LOOT_TYPE_JEWEL          =256;
const int LOOT_TYPE_SCROLL_A       =512;
const int LOOT_TYPE_SCROLL_D       =1024;
const int LOOT_TYPE_KIT            =2048;
const int LOOT_TYPE_POTION         =4096;
const int LOOT_TYPE_WEAPON         =8192;
const int LOOT_TYPE_WEAPON_RANGED  =16384;
const int LOOT_TYPE_WEAPON_MELEE   =32768;
const int LOOT_TYPE_ARMOR          =65536;
const int LOOT_TYPE_CLOTHING       =131072;

// * tweaking constants

    // * SIX LEVEL RANGES
    const int RANGE_1_MIN = 0;
    const int RANGE_1_MAX = 4;

    const int RANGE_2_MIN = 5;
    const int RANGE_2_MAX = 8;

    const int RANGE_3_MIN = 9;
    const int RANGE_3_MAX = 12;

    const int RANGE_4_MIN = 13;
    const int RANGE_4_MAX = 16;

    const int RANGE_5_MIN = 17;
    const int RANGE_5_MAX = 19;

    const int RANGE_6_MIN = 20;
    const int RANGE_6_MAX = 100;

    // * NUMBER OF ITEMS APPEARING
    const int NUMBER_LOW_ONE   = 90; const int NUMBER_MED_ONE    = 60; const int NUMBER_HIGH_ONE   = 40;
    const int NUMBER_LOW_TWO   = 9;   const int NUMBER_MED_TWO    = 30; const int NUMBER_HIGH_TWO   = 40;
    const int NUMBER_LOW_THREE = 1;   const int NUMBER_MED_THREE  = 10; const int NUMBER_HIGH_THREE = 20;


    // * AMOUNT OF GOLD BY VALUE
    const float LOW_MOD_GOLD =  1.33; const float MEDIUM_MOD_GOLD = 4.0; const float HIGH_MOD_GOLD = 13.0;
    // * FREQUENCY OF ITEM TYPE APPEARING BY TREASURE TYPE
    const int LOW_PROB_BOOK    =  5; const int MEDIUM_PROB_BOOK =    2; const int HIGH_PROB_BOOK =    0;
    const int LOW_PROB_ANIMAL  =  0; const int MEDIUM_PROB_ANIMAL =  0; const int HIGH_PROB_ANIMAL =  0;
    const int LOW_PROB_JUNK    = 23; const int MEDIUM_PROB_JUNK =    5; const int HIGH_PROB_JUNK =    0;
    const int LOW_PROB_GOLD =    21; const int MEDIUM_PROB_GOLD =   44; const int HIGH_PROB_GOLD =   40;
    const int LOW_PROB_GEM  =    40; const int MEDIUM_PROB_GEM =    40; const int HIGH_PROB_GEM =    40;
    const int LOW_PROB_JEWEL =    5; const int MEDIUM_PROB_JEWEL =  10; const int HIGH_PROB_JEWEL =  15;
    const int LOW_PROB_ARCANE =  10; const int MEDIUM_PROB_ARCANE = 10; const int HIGH_PROB_ARCANE = 10;
    const int LOW_PROB_DIVINE =  10; const int MEDIUM_PROB_DIVINE = 10; const int HIGH_PROB_DIVINE = 10;
    const int LOW_PROB_AMMO =    12; const int MEDIUM_PROB_AMMO =    5; const int HIGH_PROB_AMMO  =   3;
    const int LOW_PROB_KIT =     12; const int MEDIUM_PROB_KIT =     5; const int HIGH_PROB_KIT   =   3;
    const int LOW_PROB_POTION =  10; const int MEDIUM_PROB_POTION = 10; const int HIGH_PROB_POTION = 10;
    const int LOW_PROB_TABLE2 =   0; const int MEDIUM_PROB_TABLE2 =  3; const int HIGH_PROB_TABLE2=   5;
    const int LOW_PROB_MISC =    30; const int MEDIUM_PROB_MISC =   30; const int HIGH_PROB_MISC  =  30;

    const int LOW_PROB_GOLDANDITEM = 1 ; const int MEDIUM_PROB_GOLDANDITEM = 1 ; const int HIGH_PROB_GOLDANDITEM = 1 ;
    const int LOW_PROB_ONLYGOLD    = 9 ; const int MEDIUM_PROB_ONLYGOLD    = 9 ; const int HIGH_PROB_ONLYGOLD    = 9 ;
    const int LOW_PROB_ITEM        = 1 ; const int MEDIUM_PROB_ITEM        = 1 ; const int HIGH_PROB_ITEM        = 1 ;
// * readability constants

const int    TREASURE_LOW = 1;
const int    TREASURE_MEDIUM = 2;
const int    TREASURE_HIGH = 3;


//* Declarations
    void CreateGenericExotic(object oTarget, object oAdventurer, int nTreasureType=TREASURE_MEDIUM, int nModifier = 0);
    void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nTreasureType=TREASURE_MEDIUM, int nModifier = 0);
    void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nTreasureType=TREASURE_MEDIUM, int nModifier = 0);
    void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nTreasureType=TREASURE_MEDIUM, int nModifier = 0);


//    int KU_LootFunctions_SetLootToGroup(int LootCost);
//    int KU_LootFunctions_CheckLimitInGroup();
    void SetNextSpawn();


    int treasureDestroyed = 0;

// *
// * IMPLEMENTATION
// *

int proceedDestroy(int probability, string template, object oTarget){

    if (!treasureDestroyed) return 0;
    if(Random(100) < probability) return 0;

    CreateItemOnObject(template, oTarget);

    return 1;

}

void dbCreateItemOnObject(string sItemTemplate, object oTarget = OBJECT_SELF, int nStackSize = 1)
{

    if (nStackSize == 1)
    {
        // * checks to see if this is a throwing item and if it is
        // * it creates more

        string sRoot = GetSubString(sItemTemplate, 0, 6);
        if (GetStringLowerCase(sRoot) == "nw_wth")
        {
            nStackSize = Random(30) + 1;
        }
    }
    object oItem = CreateItemOnObject(sItemTemplate, oTarget, nStackSize);
    if (LOOT_DEBUG) {
      object oPC2send = GetFirstPC();
      while(GetIsObjectValid(oPC2send)) {

        SendMessageToPC(oPC2send,"loot : generating:" + sItemTemplate);
        oPC2send = GetNextPC();
      }
    }


    if(Random(100) < 70 ) {
      if( (GetBaseItemType(oItem) != BASE_ITEM_GOLD) &&
          (!GetLocalInt(oItem, "TROFEJ")) &&
          (GetGoldPieceValue(oItem) > 100) ){
        SetIdentified(oItem,FALSE);
      }
    }

/*    if(GetLocalInt(OBJECT_SELF,"KU_TREASURE_TYPE")!=1) {
      // A ted pekne mezi vsechny z okoli rozdelime hodnotu itemu v GP - by Kucik
      if(GetBaseItemType(oItem)== BASE_ITEM_GOLD)
        KU_LootFunctions_SetLootToGroup(GetItemStackSize(oItem));
      else
        KU_LootFunctions_SetLootToGroup(GetGoldPieceValue(oItem));
    }
*/


}


// *
// * GET FUNCTIONS
// *

// * Returns the object that either last opened the container or destroyed it
object GetLastOpener()
{
    if (GetIsObjectValid(GetLastOpenedBy()) == TRUE)
    {
        return GetLastOpenedBy();
    }
    else
    if (GetIsObjectValid(GetLastKiller()) == TRUE)
    {
        treasureDestroyed = 1;
        return GetLastKiller();
    }
    return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: GetRange
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns true if nHD matches the correct
    level range for the indicated nCategory.
    (i.e., First to Fourth level characters
    are considered Range1)
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetRange(int nCategory, int nHD, int nTreasureType=TREASURE_MEDIUM)
{
    float fHD = IntToFloat(nHD);
    fHD = 2 * fHD / (5 - nTreasureType);
    nHD = FloatToInt(fHD);
    int nMin = 0; int nMax = 0;

    switch (nCategory)
    {
        case 6: nMin = RANGE_6_MIN; nMax = RANGE_6_MAX; break;
        case 5: nMin = RANGE_5_MIN; nMax = RANGE_5_MAX; break;
        case 4: nMin = RANGE_4_MIN; nMax = RANGE_4_MAX; break;
        case 3: nMin = RANGE_3_MIN; nMax = RANGE_3_MAX; break;
        case 2: nMin = RANGE_2_MIN; nMax = RANGE_2_MAX; break;
        case 1: nMin = RANGE_1_MIN; nMax = RANGE_1_MAX; break;
    }

   if (nHD >= nMin && nHD <= nMax)
   {
    return TRUE;
   }

  return FALSE;

}

//::///////////////////////////////////////////////
//:: GetNumberOfItems
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the number of items to create.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetNumberOfItems(int nTreasureType)
{
    int nItems = 0;
    int nRandom = 0;

    int nProbThreeItems = 0;
    int nProbTwoItems = 0;
    int nProbOneItems = 0;

    if (nTreasureType == TREASURE_LOW)
    {
     nProbThreeItems = NUMBER_LOW_THREE;
     nProbTwoItems = NUMBER_LOW_TWO;
     nProbOneItems = NUMBER_LOW_ONE;
    }
    else
    if (nTreasureType == TREASURE_MEDIUM)
    {
     nProbThreeItems = NUMBER_MED_THREE;
     nProbTwoItems = NUMBER_MED_TWO;
     nProbOneItems = NUMBER_MED_ONE;
    }
    else
    if (nTreasureType == TREASURE_HIGH)
    {
     nProbThreeItems = NUMBER_HIGH_THREE;
     nProbTwoItems = NUMBER_HIGH_TWO;
     nProbOneItems = NUMBER_HIGH_ONE;
    }

    nRandom = d100();
    if (nRandom <= nProbThreeItems)
    {
        nItems = 3;
    }
    else
    if (nRandom <= nProbTwoItems + nProbThreeItems)
    {
        nItems = 2;
    }
    else
    {
        nItems = 1;
    }

    // * May 13 2002: Cap number of items, in case of logic error
    if (nItems > 3)
    {
        nItems = 3;
    }

    return nItems;
}


// *
// * TREASURE GENERATION FUNCTIONS
// *
    // *
    // * Non-Scaling Treasure
    // *
    void CreateBook(object oTarget)
    {
        if( proceedDestroy( 80, "ja_carypapiru", oTarget ) ) return;
//        dbCreateItemOnObject(sRes, oTarget);
    }

    void CreateAnimalPart(object oTarget)
    {

        string sRes = "";
        int nResult = Random(3) + 1;
        switch (nResult)
        {
            case 1: sRes = "NW_IT_MSMLMISC20"; break;
            case 2: sRes = "cnranimalmeat"; break;
            case 3: sRes = "kuze"; break;
        }
        //dbSpeak("animal");
        dbCreateItemOnObject(sRes, oTarget);
    }

    void CreateJunk(object oTarget)
    {
        string sRes = "NW_IT_TORCH001";
        int NUM_ITEMS = 6;
        int nResult = Random(NUM_ITEMS) + 1;
        int nKit = 0;
        switch (nResult)
        {
            case 1: sRes = "ry_napoj017"; break; //palenka
            case 2: sRes = "ry_napoj016"; break;   //
            case 3: sRes = "ry_napoj047"; break; // wine
            case 4: sRes = "ry_napoj001"; break; // ale
            case 5: sRes = "ry_napoj001"; break; // spirits
            case 6: sRes = "NW_IT_TORCH001"; break; //torch
        }
        //dbSpeak("CreateJunk");
        dbCreateItemOnObject(sRes, oTarget);
    }
    // *
    // * Scaling Treasure
    // *
    void CreateGold(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        int nAmount = 0;

        if (GetRange(1, nHD, nTreasureType))
        {
            nAmount = d10();
        }
        else if (GetRange(2, nHD, nTreasureType))
        {
            nAmount = d20();
        }
        else if (GetRange(3, nHD, nTreasureType))
        {
            nAmount = d20(3);
        }
        else if (GetRange(4, nHD, nTreasureType))
        {
            nAmount = d20(7);
        }
        else if (GetRange(5, nHD, nTreasureType))
        {
            nAmount = d20(13);
        }
        else if (GetRange(6, nHD, nTreasureType))
        {
            nAmount = d20(20);
        }
        float nMod = 0.0;
        if (nTreasureType == TREASURE_LOW) nMod = LOW_MOD_GOLD;
        else if (nTreasureType == TREASURE_MEDIUM) nMod = MEDIUM_MOD_GOLD;
        else if (nTreasureType == TREASURE_HIGH) nMod = HIGH_MOD_GOLD;

        // * always at least 1gp is created
        nAmount = FloatToInt(nAmount * nMod);
        if (nAmount <= 0)
        {
            nAmount = 0;
        }
        //dbSpeak("gold");
        if( proceedDestroy( 30, "ja_strepy", oTarget ) ) {
          nAmount = FloatToInt(nAmount * 0.7);
        }

        dbCreateItemOnObject("NW_IT_GOLD001", oTarget, nAmount);
    }
    void CreateGem(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {

        if( proceedDestroy( 70, "ja_strepy", oTarget ) ) return;

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sGem = "ku_gem_020";
        if (GetRange(1, nHD, nTreasureType))   // 0 - 200
        {
            int nRandom = Random(13) + 1;
            switch (nRandom)
            {
case 1: sGem = "ku_gem_020"; break;
case 2: sGem = "ku_gem_001"; break;
case 3: sGem = "ku_gem_034"; break;
case 4: sGem = "ku_gem_015"; break;
case 5: sGem = "ku_gem_023"; break;
case 6: sGem = "ku_gem_022"; break;
case 7: sGem = "ku_gem_037"; break;
case 8: sGem = "ku_gem_004"; break;
case 9: sGem = "ku_gem_026"; break;
case 10: sGem = "ku_gem_028"; break;
case 11: sGem = "ku_gem_014"; break;
case 12: sGem = "ku_gem_012"; break;
case 13: sGem = "ku_gem_029"; break;

            }
        }
        else if (GetRange(2, nHD, nTreasureType)) // 0 - 700
        {
            int nRandom = Random(26) + 1;;
            switch (nRandom)
            {
case 1: sGem = "ku_gem_020"; break;
case 2: sGem = "ku_gem_001"; break;
case 3: sGem = "ku_gem_034"; break;
case 4: sGem = "ku_gem_015"; break;
case 5: sGem = "ku_gem_023"; break;
case 6: sGem = "ku_gem_022"; break;
case 7: sGem = "ku_gem_037"; break;
case 8: sGem = "ku_gem_004"; break;
case 9: sGem = "ku_gem_026"; break;
case 10: sGem = "ku_gem_028"; break;
case 11: sGem = "ku_gem_014"; break;
case 12: sGem = "ku_gem_012"; break;
case 13: sGem = "ku_gem_029"; break;
case 14: sGem = "ku_gem_025"; break;
case 15: sGem = "ku_gem_030"; break;
case 16: sGem = "ku_gem_009"; break;
case 17: sGem = "ku_gem_010"; break;
case 18: sGem = "ku_gem_027"; break;
case 19: sGem = "ku_gem_033"; break;
case 20: sGem = "ku_gem_005"; break;
case 21: sGem = "ku_gem_007"; break;
case 22: sGem = "ku_gem_006"; break;
case 23: sGem = "ku_gem_018"; break;
case 24: sGem = "ku_gem_011"; break;
case 25: sGem = "ku_gem_013"; break;
case 26: sGem = "ku_gem_003"; break;

            }

        }
        else if (GetRange(3, nHD, nTreasureType))  // 100 - 2000
        {
            int nRandom = Random(29)+1;
            switch (nRandom)
            {
case 1: sGem = "ku_gem_022"; break;
case 2: sGem = "ku_gem_037"; break;
case 3: sGem = "ku_gem_004"; break;
case 4: sGem = "ku_gem_026"; break;
case 5: sGem = "ku_gem_028"; break;
case 6: sGem = "ku_gem_014"; break;
case 7: sGem = "ku_gem_012"; break;
case 8: sGem = "ku_gem_029"; break;
case 9: sGem = "ku_gem_025"; break;
case 10: sGem = "ku_gem_030"; break;
case 11: sGem = "ku_gem_009"; break;
case 12: sGem = "ku_gem_010"; break;
case 13: sGem = "ku_gem_027"; break;
case 14: sGem = "ku_gem_033"; break;
case 15: sGem = "ku_gem_005"; break;
case 16: sGem = "ku_gem_007"; break;
case 17: sGem = "ku_gem_006"; break;
case 18: sGem = "ku_gem_018"; break;
case 19: sGem = "ku_gem_011"; break;
case 20: sGem = "ku_gem_013"; break;
case 21: sGem = "ku_gem_003"; break;
case 22: sGem = "ku_gem_008"; break;
case 23: sGem = "ku_gem_039"; break;
case 24: sGem = "ku_gem_016"; break;
case 25: sGem = "ku_gem_040"; break;
case 26: sGem = "ku_gem_038"; break;
case 27: sGem = "ku_gem_017"; break;
case 28: sGem = "ku_gem_019"; break;
case 29: sGem = "ku_gem_021"; break;
            }

        }
        else if (GetRange(4, nHD, nTreasureType))  // 500 - 5000
        {
            int nRandom = Random(11)+1;
            switch (nRandom)
            {

case 1: sGem = "ku_gem_011"; break;
case 2: sGem = "ku_gem_013"; break;
case 3: sGem = "ku_gem_003"; break;
case 4: sGem = "ku_gem_008"; break;
case 5: sGem = "ku_gem_039"; break;
case 6: sGem = "ku_gem_016"; break;
case 7: sGem = "ku_gem_040"; break;
case 8: sGem = "ku_gem_038"; break;
case 9: sGem = "ku_gem_017"; break;
case 10: sGem = "ku_gem_019"; break;
case 11: sGem = "ku_gem_021"; break;
case 12: sGem = "ku_gem_032"; break;

            }
        }
        else if (GetRange(5, nHD, nTreasureType))  // 2000 - 10000
        {
            int nRandom = Random(8)+1;
            switch (nRandom)
            {
case 1: sGem = "ku_gem_019"; break;
case 2: sGem = "ku_gem_021"; break;
case 3: sGem = "ku_gem_032"; break;
case 4: sGem = "ku_gem_036"; break;
case 5: sGem = "ku_gem_024"; break;
case 6: sGem = "ku_gem_035"; break;
case 7: sGem = "ku_gem_031"; break;
case 8: sGem = "ku_gem_002"; break;
            }
        }
        else if (GetRange(6, nHD, nTreasureType))// 4000 +
        {
            int nRandom = Random(6) + 1;
            switch (nRandom)
            {
case 1: sGem = "ku_gem_032"; break;
case 2: sGem = "ku_gem_036"; break;
case 3: sGem = "ku_gem_024"; break;
case 4: sGem = "ku_gem_035"; break;
case 5: sGem = "ku_gem_031"; break;
case 6: sGem = "ku_gem_002"; break;

            }
        }
      //dbSpeak("Create Gem");
      dbCreateItemOnObject(sGem, oTarget, 1);
    }
    void CreateJewel(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sJewel = "";

        if (GetRange(1, nHD, nTreasureType))        // 15 gp avg; 75 gp max
        {
          int nRandom = Random(1) + 1;
          switch (nRandom)
          {
            case 1: sJewel = "li_loot_001";   break;
          }
        }
        else if (GetRange(2, nHD, nTreasureType))   // 30 GP Avg; 150 gp Max
        {
          int nRandom = 1;
          switch (nRandom)
          {
            case 1: sJewel = "li_loot_001";   break;
          }
        }
        else if (GetRange(3, nHD, nTreasureType))  // 75GP Avg; 500 gp max
        {
          int nRandom = Random(20) + 1;
          switch (nRandom)
          {
            case 1: sJewel = "li_kamulet024"; break;
            case 2: sJewel = "li_kamulet055"; break;
            case 3: sJewel = "li_kamulet054"; break;
            case 4: sJewel = "li_kamulet004"; break;
            case 5: sJewel = "li_kamulet008"; break;
            case 6: sJewel = "li_kamulet026"; break;
            case 7: sJewel = "li_kamulet006"; break;
            case 8: sJewel = "li_kamulet010"; break;
            case 9: sJewel = "li_kamulet058"; break;
            case 10: sJewel = "li_kamulet053"; break;
            case 11: sJewel = "li_kamulet012"; break;
            case 12: sJewel = "li_kamulet028"; break;
            case 13: sJewel = "li_kprsten004"; break;
            case 14: sJewel = "li_kprsten010"; break;
            case 15: sJewel = "li_kprsten010"; break;
            case 16: sJewel = "li_kprsten044"; break;
            case 17: sJewel = "li_kprsten012"; break;
            case 18: sJewel = "li_kprsten014"; break;
            case 19: sJewel = "li_kprsten043"; break;
            case 20: sJewel = "li_kprsten008"; break;

          }
        }
        else if (GetRange(4, nHD, nTreasureType))  // 150 gp avg; 1000 gp max
        {
          int nRandom = Random(37) + 1;
          switch (nRandom)
          {
            case 1: sJewel = "li_kamulet030"; break;
            case 2: sJewel = "li_kamulet032"; break;
            case 3: sJewel = "li_kamulet020"; break;
            case 4: sJewel = "li_kamulet016"; break;
            case 5: sJewel = "li_kamulet018"; break;
            case 6: sJewel = "li_kamulet022"; break;
            case 7: sJewel = "li_kamulet066"; break;
            case 8: sJewel = "li_kamulet027"; break;
            case 9: sJewel = "li_kamulet007"; break;
            case 10: sJewel = "li_kamulet011"; break;
            case 11: sJewel = "li_kamulet015"; break;
            case 12: sJewel = "li_kamulet034"; break;
            case 13: sJewel = "li_kamulet013"; break;
            case 14: sJewel = "li_kamulet024"; break;
            case 15: sJewel = "li_kamulet055"; break;
            case 16: sJewel = "li_kamulet054"; break;
            case 17: sJewel = "li_kamulet004"; break;
            case 18: sJewel = "li_kamulet008"; break;
            case 19: sJewel = "li_kamulet026"; break;
            case 20: sJewel = "li_kamulet006"; break;
            case 21: sJewel = "li_kamulet010"; break;
            case 22: sJewel = "li_kamulet058"; break;
            case 23: sJewel = "li_kamulet053"; break;
            case 24: sJewel = "li_kamulet012"; break;
            case 25: sJewel = "li_kamulet028"; break;
            case 26: sJewel = "li_kamulet031"; break;
            case 27: sJewel = "li_kamulet033"; break;
            case 28: sJewel = "li_kamulet035"; break;
            case 29: sJewel = "li_kprsten045"; break;
            case 30: sJewel = "li_kprsten004"; break;
            case 31: sJewel = "li_kprsten010"; break;
            case 32: sJewel = "li_kprsten010"; break;
            case 33: sJewel = "li_kprsten044"; break;
            case 34: sJewel = "li_kprsten012"; break;
            case 35: sJewel = "li_kprsten014"; break;
            case 36: sJewel = "li_kprsten043"; break;
            case 37: sJewel = "li_kprsten008"; break;

          }
        }
        else if (GetRange(5, nHD, nTreasureType))  // 300 gp avg; any
        {
          int nRandom = Random(50) + 1;
          switch (nRandom)
          {
            case 1: sJewel = "li_kamulet040"; break;
            case 2: sJewel = "li_kamulet030"; break;
            case 3: sJewel = "li_kamulet032"; break;
            case 4: sJewel = "li_kamulet005"; break;
            case 5: sJewel = "li_kamulet009"; break;
            case 6: sJewel = "li_kamulet020"; break;
            case 7: sJewel = "li_kamulet069"; break;
            case 8: sJewel = "li_kamulet016"; break;
            case 9: sJewel = "li_kamulet018"; break;
            case 10: sJewel = "li_kamulet064"; break;
            case 11: sJewel = "li_kamulet022"; break;
            case 12: sJewel = "li_kamulet063"; break;
            case 13: sJewel = "li_kamulet068"; break;
            case 14: sJewel = "li_kamulet070"; break;
            case 15: sJewel = "li_kamulet065"; break;
            case 16: sJewel = "li_kamulet066"; break;
            case 17: sJewel = "li_kamulet027"; break;
            case 18: sJewel = "li_kamulet007"; break;
            case 19: sJewel = "li_kamulet011"; break;
            case 20: sJewel = "li_kamulet015"; break;
            case 21: sJewel = "li_kamulet034"; break;
            case 22: sJewel = "li_kamulet013"; break;
            case 23: sJewel = "li_kamulet036"; break;
            case 24: sJewel = "li_kamulet031"; break;
            case 25: sJewel = "li_kamulet033"; break;
            case 26: sJewel = "li_kamulet021"; break;
            case 27: sJewel = "li_kamulet017"; break;
            case 28: sJewel = "li_kamulet019"; break;
            case 29: sJewel = "li_kamulet023"; break;
            case 30: sJewel = "li_kamulet067"; break;
            case 31: sJewel = "li_kamulet035"; break;
            case 32: sJewel = "li_kprsten045"; break;
            case 33: sJewel = "li_kprsten004"; break;
            case 34: sJewel = "li_kprsten010"; break;
            case 35: sJewel = "li_kprsten010"; break;
            case 36: sJewel = "li_kprsten012"; break;
            case 37: sJewel = "li_kprsten014"; break;
            case 38: sJewel = "li_kprsten008"; break;
            case 39: sJewel = "li_kprsten052"; break;
            case 40: sJewel = "li_kprsten005"; break;
            case 41: sJewel = "li_kprsten011"; break;
            case 42: sJewel = "li_kprsten007"; break;
            case 43: sJewel = "li_kprsten048"; break;
            case 44: sJewel = "li_kprsten013"; break;
            case 45: sJewel = "li_kprsten015"; break;
            case 46: sJewel = "li_kprsten047"; break;
            case 47: sJewel = "li_kprsten009"; break;
            case 48: sJewel = "li_kprsten046"; break;
            case 49: sJewel = "li_kprsten049"; break;
            case 50: sJewel = "li_kprsten050"; break;

          }
        }
        else if (GetRange(6, nHD, nTreasureType))
        {
          int nRandom = Random(59) + 1;
          switch (nRandom)
          {
case 1: sJewel = "li_kamulet040"; break;
case 2: sJewel = "li_kamulet030"; break;
case 3: sJewel = "li_kamulet032"; break;
case 4: sJewel = "li_kamulet005"; break;
case 5: sJewel = "li_kamulet009"; break;
case 6: sJewel = "li_kamulet020"; break;
case 7: sJewel = "li_kamulet069"; break;
case 8: sJewel = "li_kamulet016"; break;
case 9: sJewel = "li_kamulet018"; break;
case 10: sJewel = "li_kamulet064"; break;
case 11: sJewel = "li_kamulet022"; break;
case 12: sJewel = "li_kamulet063"; break;
case 13: sJewel = "li_kamulet068"; break;
case 14: sJewel = "li_kamulet070"; break;
case 15: sJewel = "li_kamulet065"; break;
case 16: sJewel = "li_kamulet066"; break;
case 17: sJewel = "li_kamulet027"; break;
case 18: sJewel = "li_kamulet007"; break;
case 19: sJewel = "li_kamulet011"; break;
case 20: sJewel = "li_kamulet015"; break;
case 21: sJewel = "li_kamulet034"; break;
case 22: sJewel = "li_kamulet013"; break;
case 23: sJewel = "li_kamulet036"; break;
case 24: sJewel = "li_kamulet045"; break;
case 25: sJewel = "li_kamulet031"; break;
case 26: sJewel = "li_kamulet033"; break;
case 27: sJewel = "li_kamulet056"; break;
case 28: sJewel = "li_kamulet061"; break;
case 29: sJewel = "li_kamulet021"; break;
case 30: sJewel = "li_kamulet017"; break;
case 31: sJewel = "li_kamulet019"; break;
case 32: sJewel = "li_kamulet023"; break;
case 33: sJewel = "li_kamulet067"; break;
case 34: sJewel = "li_kamulet062"; break;
case 35: sJewel = "li_kamulet060"; break;
case 36: sJewel = "li_kamulet059"; break;
case 37: sJewel = "li_kamulet014"; break;
case 38: sJewel = "li_kamulet035"; break;
case 39: sJewel = "li_kamulet057"; break;
case 40: sJewel = "li_kprsten052"; break;
case 41: sJewel = "li_kprsten005"; break;
case 42: sJewel = "li_kprsten011"; break;
case 43: sJewel = "li_kprsten007"; break;
case 44: sJewel = "li_kprsten048"; break;
case 45: sJewel = "li_kprsten013"; break;
case 46: sJewel = "li_kprsten015"; break;
case 47: sJewel = "li_kprsten047"; break;
case 48: sJewel = "li_kprsten009"; break;
case 49: sJewel = "li_kprsten046"; break;
case 50: sJewel = "li_kprsten053"; break;
case 51: sJewel = "li_kprsten049"; break;
case 52: sJewel = "li_kprsten037"; break;
case 53: sJewel = "li_kprsten041"; break;
case 54: sJewel = "li_kprsten038"; break;
case 55: sJewel = "li_kprsten051"; break;
case 56: sJewel = "li_kprsten039"; break;
case 57: sJewel = "li_kprsten039"; break;
case 58: sJewel = "li_kprsten050"; break;
case 59: sJewel = "li_kprsten042"; break;

          }
        }
      //dbSpeak("Create Jewel");

      dbCreateItemOnObject(sJewel, oTarget, 1);

    }
    // * returns the valid upper limit for any arcane spell scroll
    int TrimLevel(int nScroll, int nLevel)
    {   int nMax = 5;
        switch (nLevel)
        {
            case 0: nMax = 4; break;
            case 1: nMax = 13; break;
            case 2: nMax = 21; break;
            case 3: nMax = 15; break;
            case 4: nMax = 17; break;
            case 5: nMax = 13; break;
            case 6: nMax = 14; break;
            case 7: nMax = 8; break;
            case 8: nMax = 9; break;
            case 9: nMax = 12; break;
        }
        if (nScroll > nMax) nScroll = nMax;
        return nScroll;

    }
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // Author: Pavel A
    // 2015_01_12
    //
    /*
    Returns resref of a spell scroll that is randomly choosen from
    a particular level of arcane spells defined by 2da file.
    */
    string pa_GetARSpellResref(int nSpellLevel)
    // nSpellLevel ... spell level, (0, ... , 9) or Note2.
    //
    // This function use custom 2da files, which contain 3 columns of data:
    // 1st  row number, 2nd  spell's name, 3rd  resref of a particular spell's scroll
    // The named of these 2da files is as follows: pa_ASpells_0x
    // where: pa ... Pavel A; A ... arcane; x ... spell level (int nSpellLevel)
    // This function opens a 2da file, search through it to identify number of spells of the 
    // spell level and then it randomly chooses one spell and return the resref.
    //
    // Note: To speed up a function, it is possible to define total number of spells per spell level. If
    // this function is active, then every new spellscroll added to the 2da file has to be followed by alternation
    // of the hard-coded number, otherwise the new spellscrol(s) would not be included to loot.
    //
    // Note2: In a future, it is possible to generate scrolls higher than 9th spell level: e.g. epic spell scrolls
    // or customized/quest spell scrolls. In this case, create new 2da file of name pa_ASpells_zz, and use the same
    // function.
    {
      int nRandomNum; // random number
      int nTotalRows;  // number use to count rows of 2da file
      string sResRef = "";
      string sNameOf2DA = "";

      // generate name of a particular 2da file
      sNameOf2DA = "pa_ASpells_" + "0" + IntToString( nSpellLevel );

      nTotalRows = 0; // counter of data rows, actual row is the first one
      
      // cycle through 2da file to get its size
      sResRef = Get2DAString( sNameOf2DA, "Spell_Name", nTotalRows);  // get 1st spell name
      while (sResRef !="") 
      {
        nTotalRows++; // increase counter
        sResRef = Get2DAString( sNameOf2DA, "Spell_Name", nTotalRows);  // get next spell name
      }
  
      // generate random number of range (0, ..., (nTotalRows))
      nRandomNum = Random(nTotalRows);
      sResRef = Get2DAString( sNameOf2DA, "Scroll_resref", nRandomNum);
    
      return sResRef;
    }    
    
    
    
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // Author: Pavel A
    // 2015_01_12
    //
    // This function creates scroll of arcane magic. A level of the scroll is choosen
    // with respect to the function GetRange(...), a particular scroll's resref is
    // generated by a function pa_GetARSpellResref(...).
    // This function should provide statistic distribution of generated scrolls with 
    // an accord to specified level ranges of the spell. 
    //
    // * nModifier is to 'raise' the level of the oAdventurer
    void pa_CreateArcaneScroll(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        if( proceedDestroy( 70, "ja_carypapiru", oTarget ) ) return;

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        int nLevel = 1;

        if (GetRange(1, nHD, nTreasureType))           // l 1-2
        {
          nLevel = d2();
        }
        else if (GetRange(2, nHD, nTreasureType))      // l 1-4
        {
          nLevel = d4();
        }
        else if (GetRange(3, nHD, nTreasureType))    // l 2-6
        {
          nLevel = Random(5) + 2;
        }
        else if (GetRange(4, nHD, nTreasureType))   // l 3-8
        {
          nLevel = Random(6) + 3;
        }
        else if (GetRange(5, nHD, nTreasureType))   // l 4-9
        {
          nLevel = Random(6) + 4;
        }
        else if (GetRange(6, nHD, nTreasureType))   // 5 -9
        {
          nLevel = Random(5) + 5;
        }
        
        // generate resref of a randomly choosen spell scroll
        string sRes = pa_GetARSpellResref(nLevel);  
        
        // Create a scrolll into an inventory of oTarget
        dbCreateItemOnObject(sRes, oTarget, 1);  // create spell scroll
    }
    
    
    
    
    // * nModifier is to 'raise' the level of the oAdventurer
    // 
    // Modified by PA, 2015_01_12;  Changes: corrected statistics of generated random numbers of ranges.
    // 
    // However, a corrected function pa_CreateArcaneScroll(...) is highly recommended to use instead
    // of this function as this function can not create scrolls of datadiscs spells at all!
    // 
    void CreateArcaneScroll(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        if( proceedDestroy( 70, "ja_carypapiru", oTarget ) ) return;

        int nMaxSpells = 21;
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        int nScroll = 1;
        int nLevel = 1;

        if (GetRange(1, nHD, nTreasureType))           // l 1-2
        {
          nLevel = d2();
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(2, nHD, nTreasureType))      // l 1-4
        {
          nLevel = d4();
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(3, nHD, nTreasureType))    // l 2-6
        {
          nLevel = Random(5) + 2;
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(4, nHD, nTreasureType))   // l 3-8
        {
          nLevel = Random(6) + 3;
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(5, nHD, nTreasureType))   // l 4-9
        {
          nLevel = Random(6) + 4;
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(6, nHD, nTreasureType))   // 5 -9
        {
          nLevel = Random(5) + 5;
          nScroll =  Random(nMaxSpells) + 1;
        }

        // * Trims the level of the scroll to match the max # of scrolls in each level range
        nScroll = TrimLevel(nScroll, nLevel); 

        string sRes = "nw_it_sparscr216";

        if (nScroll < 10)
        {
            sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + "0" + IntToString(nScroll);
        }
        else
        {
            sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + IntToString(nScroll);
        }
          dbCreateItemOnObject(sRes, oTarget, 1);
        }

    void CreateDivineScroll(object oTarget, object oAdventurer, int nTreasureType, int nModifier=0)
    {
        if( proceedDestroy( 70, "ja_carypapiru", oTarget ) ) return;

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sScroll = "";
        if (GetRange(1, nHD, nTreasureType))
        {
            int nRandom = d4();
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202"; break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
            }
        }
        else if (GetRange(2, nHD, nTreasureType))
        {
            int nRandom = d8();
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202";break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
                case 5: sScroll = "nw_it_spdvscr301"; break;
                case 6: sScroll = "nw_it_spdvscr302"; break;
                case 7: sScroll = "nw_it_spdvscr401"; break;
                case 8: sScroll = "nw_it_spdvscr402"; break;
            }

        }
        else if (GetRange(3, nHD, nTreasureType))
        {
            int nRandom = Random(9) + 1;
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202"; break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
                case 5: sScroll = "nw_it_spdvscr301"; break;
                case 6: sScroll = "nw_it_spdvscr302"; break;
                case 7: sScroll = "nw_it_spdvscr401"; break;
                case 8: sScroll = "nw_it_spdvscr402"; break;
                case 9: sScroll = "it_spdvscr502"; break;
            }

        }
        else
        {
            int nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr301"; break;
                case 2: sScroll = "nw_it_spdvscr302";  break;
                case 3: sScroll = "nw_it_spdvscr401"; break;
                case 4: sScroll = "nw_it_spdvscr402"; break;
                case 5: sScroll = "it_spdvscr502"; break;
                case 6: sScroll = "nw_it_spdvscr701"; break;
                case 7: sScroll = "it_spdvscr703";  break;
            }
        }
        //dbSpeak("Divine Scroll");

        dbCreateItemOnObject(sScroll, oTarget, 1);

    }
    void CreateAmmo(object oTarget, object oAdventurer, int nTreasureType, int nModifier=0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sAmmo = "";

        if (GetRange(1, nHD, nTreasureType))           // * 200 gp max
        {
            int nRandom = d3();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";  break;
                case 2: sAmmo = "nw_wambo001";  break;
                case 3: sAmmo = "nw_wambu001";  break;
            }
          }
        else if (GetRange(2, nHD, nTreasureType))       // * 800 gp max
        {
            int nRandom = d6();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";  break;
                case 2: sAmmo = "nw_wambo001";  break;
                case 3: sAmmo = "nw_wambu001";  break;
                case 4: sAmmo = "nw_wammar001"; break;
                case 5: sAmmo = "nw_wammbo001"; break;
                case 6: sAmmo = "nw_wammbo002"; break;
            }
        }
        else if (GetRange(3, nHD, nTreasureType))    // *  - 2500 gp
        {
            int nRandom = d20();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";   break;
                case 2: sAmmo = "nw_wambo001";   break;
                case 3: sAmmo = "nw_wambu001";   break;
                case 4: sAmmo = "nw_wammar001";  break;
                case 5: sAmmo = "nw_wammbo001";  break;
                case 6: sAmmo = "nw_wammbo002";   break;
                case 7: sAmmo = "nw_wammbo003";  break;
                case 8: sAmmo = "nw_wammbu002";  break;
                case 9: sAmmo = "nw_wammar002";  break;
                case 10: sAmmo = "nw_wammar001"; break;
                case 11: sAmmo = "nw_wammar003"; break;
                case 12: sAmmo = "nw_wammar004"; break;
                case 13: sAmmo = "nw_wammar005"; break;
                case 14: sAmmo = "nw_wammar006"; break;
                case 15: sAmmo = "nw_wammbo004";  break;
                case 16: sAmmo = "nw_wammbo005"; break;
                case 17: sAmmo = "nw_wammbu004"; break;
                case 18: sAmmo = "nw_wammbu005"; break;
                case 19: sAmmo = "nw_wammbu006"; break;
                case 20: sAmmo = "nw_wammbu007"; break;
            }
        }
        else
        {
            int nRandom = d20();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";      break;
                case 2: sAmmo = "nw_wammbu001";     break;
                case 3: sAmmo = "nw_wammbu003";     break;
                case 4: sAmmo = "nw_wammar001";     break;
                case 5: sAmmo = "nw_wammbo001";      break;
                case 6: sAmmo = "nw_wammbo002";     break;
                case 7: sAmmo = "nw_wammbo003";     break;
                case 8: sAmmo = "nw_wammbu002";     break;
                case 9: sAmmo = "nw_wammar002";     break;
                case 10: sAmmo = "nw_wammar001";    break;
                case 11: sAmmo = "nw_wammar003";    break;
                case 12: sAmmo = "nw_wammar004";     break;
                case 13: sAmmo = "nw_wammar005";    break;
                case 14: sAmmo = "nw_wammar006";    break;
                case 15: sAmmo = "nw_wammbo004";    break;
                case 16: sAmmo = "nw_wammbo005";    break;
                case 17: sAmmo = "nw_wammbu004";    break;
                case 18: sAmmo = "nw_wammbu005";    break;
                case 19: sAmmo = "nw_wammbu006";    break;
                case 20: sAmmo = "nw_wammbu007";    break;
            }
        }
        //dbSpeak("ammo");
        dbCreateItemOnObject(sAmmo, oTarget, Random(30) + 1); // create up to 30 of the specified ammo type
    }

    void CreateTrapKit(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
      string sKit = "";
        if (GetRange(1, nHD, nTreasureType))      // 200
        {
            int nRandom = d3();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap001";    break;
                case 2: sKit = "nw_it_trap029";    break;
                case 3: sKit = "nw_it_trap033";    break;
            }
        }
        else if (GetRange(2, nHD, nTreasureType))  // 800
        {
            int nRandom = d12();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap001";    break;
                case 2: sKit = "nw_it_trap029";    break;
                case 3: sKit = "nw_it_trap033";    break;
                case 4: sKit = "nw_it_trap002";    break;
                case 5: sKit = "nw_it_trap030";    break;
                case 6: sKit = "nw_it_trap037";    break;
                case 7: sKit = "nw_it_trap034";   break;
                case 8: sKit = "nw_it_trap005";   break;
                case 9: sKit = "nw_it_trap038";   break;
                case 10: sKit = "nw_it_trap041";   break;
                case 11: sKit = "nw_it_trap003";    break;
                case 12: sKit = "nw_it_trap031";   break;
            }

        }
        else if (GetRange(3, nHD, nTreasureType))   // 200 - 2500
        {
            int nRandom = Random(17) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap002";  break;
                case 2: sKit = "nw_it_trap030";  break;
                case 3: sKit = "nw_it_trap037";  break;
                case 4: sKit = "nw_it_trap034";   break;
                case 5: sKit = "nw_it_trap005";  break;
                case 6: sKit = "nw_it_trap038";   break;
                case 7: sKit = "nw_it_trap041";   break;
                case 8: sKit = "nw_it_trap003";   break;
                case 9: sKit = "nw_it_trap031";   break;
                case 10: sKit = "nw_it_trap035";   break;
                case 11: sKit = "nw_it_trap006";   break;
                case 12: sKit = "nw_it_trap042";   break;
                case 13: sKit = "nw_it_trap004";   break;
                case 14: sKit = "nw_it_trap032";   break;
                case 15: sKit = "nw_it_trap039";    break;
                case 16: sKit = "nw_it_trap009";   break;
                case 17: sKit = "nw_it_trap036";   break;
            }

       }
        else if (GetRange(4, nHD, nTreasureType))  // 800 - 10000
        {
            int nRandom = Random(19) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap035";  break;
                case 2: sKit = "nw_it_trap006";  break;
                case 3: sKit = "nw_it_trap042";  break;
                case 4: sKit = "nw_it_trap004";   break;
                case 5: sKit = "nw_it_trap032";   break;
                case 6: sKit = "nw_it_trap039";   break;
                case 7: sKit = "nw_it_trap009";   break;
                case 8: sKit = "nw_it_trap036";   break;
                case 9: sKit = "nw_it_trap013";   break;
                case 10: sKit = "nw_it_trap040";  break;
                case 11: sKit = "nw_it_trap007";  break;
                case 12: sKit = "nw_it_trap043";  break;
                case 13: sKit = "nw_it_trap010";  break;
                case 14: sKit = "nw_it_trap017";  break;
                case 15: sKit = "nw_it_trap021"; break;
                case 16: sKit = "nw_it_trap014"; break;
                case 17: sKit = "nw_it_trap025"; break;
                case 18: sKit = "nw_it_trap008";  break;
                case 19: sKit = "nw_it_trap044";  break;
            }

        }
        else if (GetRange(5, nHD, nTreasureType))  // 2000 -16500
        {
            int nRandom = Random(18) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap039";   break;
                case 2: sKit = "nw_it_trap009";   break;
                case 3: sKit = "nw_it_trap036";   break;
                case 4: sKit = "nw_it_trap013";   break;
                case 5: sKit = "nw_it_trap040";   break;
                case 6: sKit = "nw_it_trap007";   break;
                case 7: sKit = "nw_it_trap043";   break;
                case 8: sKit = "nw_it_trap010";  break;
                case 9: sKit = "nw_it_trap017";  break;
                case 10: sKit = "nw_it_trap021";  break;
                case 11: sKit = "nw_it_trap014";  break;
                case 12: sKit = "nw_it_trap025";  break;
                case 13: sKit = "nw_it_trap008";  break;
                case 14: sKit = "nw_it_trap044";  break;
                case 15: sKit = "nw_it_trap018";  break;
                case 16: sKit = "nw_it_trap011";  break;
                case 17: sKit = "nw_it_trap022";  break;
                case 18: sKit = "nw_it_trap026";  break;
            }

        }
        else if (GetRange(6, nHD, nTreasureType))   // 2000 - ?
        {
            int nRandom = Random(27) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap039";  break;
                case 2: sKit = "nw_it_trap009";  break;
                case 3: sKit = "nw_it_trap036";  break;
                case 4: sKit = "nw_it_trap013";  break;
                case 5: sKit = "nw_it_trap040";  break;
                case 6: sKit = "nw_it_trap007";  break;
                case 7: sKit = "nw_it_trap043";  break;
                case 8: sKit = "nw_it_trap010"; break;
                case 9: sKit = "nw_it_trap017"; break;
                case 10: sKit = "nw_it_trap021"; break;
                case 11: sKit = "nw_it_trap014"; break;
                case 12: sKit = "nw_it_trap025"; break;
                case 13: sKit = "nw_it_trap008"; break;
                case 14: sKit = "nw_it_trap044"; break;
                case 15: sKit = "nw_it_trap018"; break;
                case 16: sKit = "nw_it_trap011"; break;
                case 17: sKit = "nw_it_trap022"; break;
                case 18: sKit = "nw_it_trap026"; break;
                case 19: sKit = "nw_it_trap015"; break;
                case 20: sKit = "nw_it_trap012"; break;
                case 21: sKit = "nw_it_trap019"; break;
                case 22: sKit = "nw_it_trap023"; break;
                case 23: sKit = "nw_it_trap016"; break;
                case 24: sKit = "nw_it_trap027"; break;
                case 25: sKit = "nw_it_trap020"; break;
                case 26: sKit = "nw_it_trap024"; break;
                case 27: sKit = "nw_it_trap028"; break;
             }

        }
        //dbSpeak("Create Trapkit");
        dbCreateItemOnObject(sKit, oTarget, 1);

    }
    void CreateHealingKit(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sKit = "";
        if (GetRange(1, nHD, nTreasureType))      // 200
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit001";  break;
            }
        }
        else if (GetRange(2, nHD, nTreasureType))  // 800
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit001";  break;
                case 2: sKit = "nw_it_medkit002";  break;
            }

        }
        else if (GetRange(3, nHD, nTreasureType))   // 200 - 2500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit002"; break;
                case 2: sKit = "nw_it_medkit003";  break;
            }

       }
        else if (GetRange(4, nHD, nTreasureType))  // 800 - 10000
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003";break;
                case 2: sKit = "nw_it_medkit004"; break;
            }

        }
        else if (GetRange(5, nHD, nTreasureType))  // 2000 -16500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003"; break;
                case 2: sKit = "nw_it_medkit004";break;
            }

        }
        else if (GetRange(6, nHD, nTreasureType))   // 2000 - ?
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003"; break;
                case 2: sKit = "nw_it_medkit004";break;
             }

        }
        //dbSpeak("Create Healing Kit");

        dbCreateItemOnObject(sKit, oTarget, 1);

    }
    void CreateLockPick(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        string sKit = "";
        if (GetRange(1, nHD, nTreasureType))      // 200
        {
            int nRandom = d8();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks001";   break;
                case 2: sKit = "nw_it_picks002";   break;
                case 3: sKit = "nw_it_picks001";   break;
                case 4: sKit = "nw_it_picks001";   break;
                case 5: sKit = "nw_it_picks001";   break;
                case 6: sKit = "nw_it_picks001";   break;
                case 7: sKit = "nw_it_picks001";   break;
                case 8: sKit = "nw_it_picks001";   break;
            }
        }
        else if (GetRange(2, nHD, nTreasureType))  // 800
        {
            int nRandom = d6();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks001";   break;
                case 2: sKit = "nw_it_picks002";    break;
                case 3: sKit = "nw_it_picks003";   break;
                case 4: sKit = "nw_it_picks002";    break;
                case 5: sKit = "nw_it_picks002";    break;
                case 6: sKit = "nw_it_picks002";    break;
            }

        }
        else if (GetRange(3, nHD, nTreasureType))   // 200 - 2500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks003";  break;
                case 2: sKit = "nw_it_picks004";  break;
            }

       }
        else if (GetRange(4, nHD, nTreasureType))  // 800 - 10000
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004";  break;
            }

        }
        else if (GetRange(5, nHD, nTreasureType))  // 2000 -16500
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004"; break;
            }

        }
        else if (GetRange(6, nHD, nTreasureType))   // 2000 - ?
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004"; break;
             }

        }
       //dbSpeak("Create Lockpick");

        dbCreateItemOnObject(sKit, oTarget, 1);

    }
// Chlast
    void CreateAle(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        int iLocType = GetLocalInt(GetArea(oTarget),"JA_LOC_TYPE");

        string sRes = "";
        if (GetRange(1, nHD, nTreasureType))      // 200
        {
            int nRandom;
            if(iLocType == 2)
              nRandom = Random(11)+1;
            else
              nRandom = Random(5)+1;
            switch (nRandom)
            {
                 case 1: sRes = "ry_napoj017"; break; //palenka
                 case 2: sRes = "ry_napoj016"; break;   //
                 case 3: sRes = "ry_napoj047"; break; // wine
                 case 4: sRes = "ry_napoj001"; break; // ale
                 case 5: sRes = "ry_napoj001"; break; // spirits

                 case 6: sRes = "ry_napoj066"; break; // vino - podtemno
                 case 7: sRes = "ry_napoj065"; break; // vino - podtemno
                 case 8: sRes = "ry_napoj062"; break; // vino - podtemno
                 case 9: sRes = "ry_napoj063"; break; // vino - podtemno
                 case 10: sRes = "ry_napoj064"; break; // vino - podtemno
                 case 11: sRes = "ry_napoj061"; break; // vino - podtemno

            }
        }
        else if (GetRange(2, nHD, nTreasureType) && (iLocType == 2))  // 800
        {
             int nRandom;
            if(iLocType == 2)
              nRandom = Random(12)+1;
            else
              nRandom = Random(5)+1;
            switch (nRandom)
            {
                 case 1: sRes = "ry_napoj017"; break; //palenka
                 case 2: sRes = "ry_napoj016"; break;   //
                 case 3: sRes = "ry_napoj047"; break; // wine
                 case 4: sRes = "ry_napoj001"; break; // ale
                 case 5: sRes = "ry_napoj001"; break; // spirits

                 case 6: sRes = "ry_napoj066"; break; // vino - podtemno
                 case 7: sRes = "ry_napoj065"; break; // vino - podtemno
                 case 8: sRes = "ry_napoj062"; break; // vino - podtemno
                 case 9: sRes = "ry_napoj063"; break; // vino - podtemno
                 case 10: sRes = "ry_napoj064"; break; // vino - podtemno
                 case 11: sRes = "ry_napoj061"; break; // vino - podtemno
                 case 12: sRes = "ry_napoj087"; break; // vino - podtemno

            }

        }
        else if (GetRange(3, nHD, nTreasureType) && (iLocType == 2))   // 200 - 2500
        {
            int nRandom = d2();
            switch (nRandom)
            {
                case 1: sRes = "ry_napoj087";  break;
                case 2: sRes = "ry_napoj085";;  break;
            }

       }
        else if (GetRange(4, nHD, nTreasureType) && (iLocType == 2))  // 800 - 10000
        {
            int nRandom = d2();
            switch (nRandom)
            {
                case 1: sRes = "ry_napoj086";  break;
                case 2: sRes = "ry_napoj085";;  break;
            }

        }
        else if (GetRange(5, nHD, nTreasureType) && (iLocType == 2))  // 2000 -16500
        {
            sRes = "ry_napoj086";

        }
        else if (GetRange(6, nHD, nTreasureType) && (iLocType == 2))   // 2000 - ?
        {
            sRes = "ry_napoj086";

        }

        dbCreateItemOnObject(sRes, oTarget, 1);
    }



    void CreateKit(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        // * April 23 2002: Major restructuring of this function
        // * to allow me to

        switch (Random(8) + 1)
        {
            case 1: CreateTrapKit(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 2: case 3: case 4: case 5: CreateHealingKit(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 6: case 7: case 8: CreateLockPick(oTarget, oAdventurer, nTreasureType, nModifier); break;
        }
    }

    void CreatePotion(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        if( proceedDestroy( 70, "ja_strepy", oTarget ) ) return;

        string sPotion = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

        if (GetRange(1, nHD, nTreasureType))
        {
            int nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1: sPotion = "li_bomb036";  break;
                case 2: sPotion = "li_bomb031";  break;
                case 3: sPotion = "li_bomb030";  break;
                case 4: sPotion = "li_bomb037";  break;
                case 5: sPotion = "li_bomb013";  break;
                case 6: sPotion = "li_bomb001";  break;
                case 7: sPotion = "li_bomb014";  break;
            }

        }
        else if (GetRange(2, nHD, nTreasureType))
        {
           int nRandom = Random(25) + 1;
            switch (nRandom)
            {
                case 1: sPotion = "li_bomb045"; break;
                case 2: sPotion = "li_bomb036"; break;
                case 3: sPotion = "li_bomb032"; break;
                case 4: sPotion = "li_bomb031"; break;
                case 5: sPotion = "li_bomb030"; break;
                case 6: sPotion = "li_bomb037"; break;
                case 7: sPotion = "li_bomb022"; break;
                case 8: sPotion = "li_bomb013"; break;
                case 9: sPotion = "li_bomb001"; break;
                case 10: sPotion = "li_bomb036"; break;
                case 11: sPotion = "li_bomb047"; break;
                case 12: sPotion = "li_bomb034"; break;
                case 13: sPotion = "li_bomb020"; break;
                case 14: sPotion = "li_bomb015"; break;
                case 15: sPotion = "li_bomb027"; break;
                case 16: sPotion = "li_bomb019"; break;
                case 17: sPotion = "li_bomb026"; break;
                case 18: sPotion = "li_bomb040"; break;
                case 19: sPotion = "li_bomb014"; break;
                case 20: sPotion = "li_bomb035"; break;
                case 21: sPotion = "li_bomb003"; break;
                case 22: sPotion = "li_bomb002"; break;
                case 23: sPotion = "li_bomb033"; break;
                case 24: sPotion = "li_ritems_010"; break;
                case 25: sPotion = "li_bomb042"; break;

            }

        }
        else if (GetRange(3, nHD, nTreasureType))
        {
           int nRandom = Random(31) + 1;
            switch (nRandom)
            {

                case 1: sPotion = "li_bomb045"; break;
                case 2: sPotion = "li_bomb036"; break;
                case 3: sPotion = "li_bomb032"; break;
                case 4: sPotion = "li_bomb031"; break;
                case 5: sPotion = "li_bomb022"; break;
                case 6: sPotion = "li_bomb013"; break;
                case 7: sPotion = "li_bomb001"; break;
                case 8: sPotion = "li_bomb036"; break;
                case 9: sPotion = "li_bomb047"; break;
                case 10: sPotion = "li_bomb034"; break;
                case 11: sPotion = "li_bomb039"; break;
                case 12: sPotion = "li_bomb020"; break;
                case 13: sPotion = "li_bomb017"; break;
                case 14: sPotion = "li_bomb041"; break;
                case 15: sPotion = "li_bomb015"; break;
                case 16: sPotion = "li_bomb027"; break;
                case 17: sPotion = "li_bomb021"; break;
                case 18: sPotion = "li_bomb038"; break;
                case 19: sPotion = "li_bomb026"; break;
                case 20: sPotion = "li_bomb040"; break;
                case 21: sPotion = "li_bomb014"; break;
                case 22: sPotion = "li_bomb025"; break;
                case 23: sPotion = "li_bomb024"; break;
                case 24: sPotion = "li_bomb035"; break;
                case 25: sPotion = "li_bomb018"; break;
                case 26: sPotion = "li_bomb003"; break;
                case 27: sPotion = "li_bomb002"; break;
                case 28: sPotion = "li_bomb033"; break;
                case 29: sPotion = "li_ritems_010"; break;
                case 30: sPotion = "li_bomb012"; break;
                case 31: sPotion = "li_bomb042"; break;

            }
        }
        else if (GetRange(4, nHD, nTreasureType))
        {
           int nRandom = Random(27) + 1;
            switch (nRandom)
            {

                case 1: sPotion = "li_bomb029"; break;
                case 2: sPotion = "li_bomb032"; break;
                case 3: sPotion = "li_bomb022"; break;
                case 4: sPotion = "li_bomb036"; break;
                case 5: sPotion = "AddictionCure"; break;
                case 6: sPotion = "li_bomb047"; break;
                case 7: sPotion = "li_bomb034"; break;
                case 8: sPotion = "li_bomb039"; break;
                case 9: sPotion = "li_bomb017"; break;
                case 10: sPotion = "li_bomb041"; break;
                case 11: sPotion = "li_bomb015"; break;
                case 12: sPotion = "li_bomb027"; break;
                case 13: sPotion = "li_bomb021"; break;
                case 14: sPotion = "li_bomb038"; break;
                case 15: sPotion = "li_bomb004"; break;
                case 16: sPotion = "li_bomb026"; break;
                case 17: sPotion = "li_bomb040"; break;
                case 18: sPotion = "li_bomb025"; break;
                case 19: sPotion = "li_bomb024"; break;
                case 20: sPotion = "li_bomb035"; break;
                case 21: sPotion = "li_bomb018"; break;
                case 22: sPotion = "li_bomb003"; break;
                case 23: sPotion = "li_bomb002"; break;
                case 24: sPotion = "li_bomb033"; break;
                case 25: sPotion = "li_ritems_010"; break;
                case 26: sPotion = "li_bomb012"; break;
                case 27: sPotion = "li_bomb042"; break;


            }
        }
        else if (GetRange(5, nHD, nTreasureType))
        {
           int nRandom = Random(15) + 1;
            switch (nRandom)
            {
                case 1: sPotion = "li_bomb028"; break;
                case 2: sPotion = "li_bomb029"; break;
                case 3: sPotion = "AddictionCure"; break;
                case 4: sPotion = "li_bomb017"; break;
                case 5: sPotion = "li_bomb041"; break;
                case 6: sPotion = "li_bomb021"; break;
                case 7: sPotion = "li_bomb038"; break;
                case 8: sPotion = "li_bomb004"; break;
                case 9: sPotion = "li_bomb025"; break;
                case 10: sPotion = "li_bomb034"; break;
                case 11: sPotion = "li_bomb018"; break;
                case 12: sPotion = "li_bomb003"; break;
                case 13: sPotion = "li_ritems_010"; break;
                case 14: sPotion = "li_bomb012"; break;
                case 15: sPotion = "li_bomb042"; break;

            }
        }
        else
        {
           int nRandom = Random(6) + 1;
            switch (nRandom)
            {
                case 1: sPotion = "li_bomb028"; break;
                case 2: sPotion = "li_bomb038"; break;
                case 3: sPotion = "AddictionCure"; break;
                case 4: sPotion = "li_bomb004"; break;
                case 5: sPotion = "li_bomb018"; break;
                case 6: sPotion = "li_bomb042"; break;

            }
        }
        //dbSpeak("Create Potion");
        dbCreateItemOnObject(sPotion, oTarget, 1);
    }
    //::///////////////////////////////////////////////
    //:: CreateTable2GenericItem
    //:: Copyright (c) 2002 Bioware Corp.
    //:://////////////////////////////////////////////
    /*
        Creates an item based upon the class of
        oAdventurer
    */
    //:://////////////////////////////////////////////
    //:: Created By:  Brent
    //:: Created On:
    //:://////////////////////////////////////////////
        void CreateGenericMiscItem(object oTarget, object oAdventurer, int nTreasureType, int nModifier=0)
        {
          if( proceedDestroy( 70, "ja_strepy", oTarget ) ) return;

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
        //SpeakString(IntToString(nHD));
            string sItem = "";
            if (GetRange(1, nHD, nTreasureType))    // 0 - 100
            {
                int nRandom = Random(25) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "li_loot_001";   break;
            case 2: sItem = "li_loot_002";   break;
            case 3: sItem = "li_loot_003";   break;
            case 4: sItem = "li_loot_004";   break;
            case 5: sItem = "li_loot_005";   break;
            case 6: sItem = "cnrwoodcutteraxe";   break;
            case 7: sItem = "cnrgemchisel";   break;
            case 8: sItem = "cnrsmithshammer";   break;
            case 9: sItem = "cnrShovel";   break;
            case 10: sItem = "cnrskinningknife";   break;
            case 11: sItem = "cnrsewingkit";   break;
            case 12: sItem = "li_loot_028";   break;
            case 13: sItem = "li_kamulet001";   break;
            case 14: sItem = "li_kamulet041";   break;
            case 15: sItem = "li_kamulet044";   break;
            case 16: sItem = "li_kprsten001";   break;
            case 17: sItem = "li_kprsten035";   break;
            case 18: sItem = "li_kprsten036";   break;
            case 19: sItem = "li_loot_065";   break;
            case 20: sItem = "li_loot_066";   break;
            case 21: sItem = "li_loot_067";   break;
            case 22: sItem = "li_loot_071";   break;
            case 23: sItem = "li_loot_072";   break;
            case 24: sItem = "li_loot_084";   break;
            case 25: sItem = "li_loot_085";   break;


                }
            }
            else if (GetRange(2, nHD, nTreasureType))   // 0-700
            {
                int nRandom = Random(51) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "li_loot_001"; break;
                 case 2: sItem = "li_loot_002"; break;
                 case 3: sItem = "li_loot_007"; break;
                 case 4: sItem = "li_loot_004"; break;
                 case 5: sItem = "li_loot_005"; break;
                 case 6: sItem = "li_loot_006"; break;
                 case 7: sItem = "cnrwoodcutteraxe"; break;
                 case 8: sItem = "cnrgemchisel"; break;
                 case 9: sItem = "cnrsmithshammer"; break;
                 case 10: sItem = "cnrShovel"; break;
                 case 11: sItem = "cnrskinningknife"; break;
                 case 12: sItem = "cnrsewingkit"; break;
                 case 13: sItem = "li_loot_008"; break;
//                 case 14: sItem = "li_loot_009"; break;
                 case 14: sItem = "li_loot_020"; break;
                 case 15: sItem = "li_loot_020"; break;
                 case 16: sItem = "li_loot_022"; break;
                 case 17: sItem = "li_loot_026"; break;
                 case 18: sItem = "li_loot_028"; break;
                 case 19: sItem = "li_loot_029"; break;
                 case 20: sItem = "li_loot_030"; break;

            case 21: sItem = "li_kamulet001";   break;
            case 22: sItem = "li_kamulet041";   break;
            case 23: sItem = "li_kamulet044";   break;
            case 24: sItem = "li_kamulet002";   break;
            case 25: sItem = "li_kamulet042";   break;
            case 26: sItem = "li_kamulet043";   break;

            case 27: sItem = "li_kprsten001";   break;
            case 28: sItem = "li_kprsten035";   break;
            case 29: sItem = "li_kprsten036";   break;
            case 30: sItem = "li_kprsten002";   break;
            case 31: sItem = "li_kprsten030";   break;
            case 32: sItem = "li_kprsten031";   break;
            case 33: sItem = "li_kprsten032";   break;
            case 34: sItem = "li_kprsten034";   break;

            case 35: sItem = "li_loot_052";   break;
            case 36: sItem = "li_loot_059";   break;
            case 37: sItem = "li_loot_060";   break;
            case 38: sItem = "li_loot_062";   break;
            case 39: sItem = "li_loot_066";   break;
            case 40: sItem = "li_loot_067";   break;
            case 41: sItem = "li_loot_068";   break;
            case 42: sItem = "li_loot_069";   break;
            case 43: sItem = "li_loot_071";   break;
            case 44: sItem = "li_loot_072";   break;
            case 45: sItem = "li_loot_073";   break;
            case 46: sItem = "li_loot_074";   break;
            case 47: sItem = "li_loot_075";   break;
            case 48: sItem = "li_loot_084";   break;
            case 49: sItem = "li_loot_085";   break;
            case 50: sItem = "li_loot_076";   break;
            case 51: sItem = "li_kprsten033";   break;


//~rejty loot 2
}

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 100 - 2500
            {
                 sItem = "li_loot_002";
                int nRandom = Random(128) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "li_loot_002"; break;
                 case 2: sItem = "li_loot_007"; break;
                 case 3: sItem = "li_loot_005"; break;
                 case 4: sItem = "li_loot_006"; break;
                 case 5: sItem = "li_loot_008"; break;
//                 case 6: sItem = "li_loot_009"; break;
//                 case 7: sItem = "li_loot_010"; break;
                 case 8: sItem = "li_loot_019"; break;
                 case 9: sItem = "li_loot_020"; break;
                 case 10: sItem = "li_loot_022"; break;
                 case 11: sItem = "li_loot_023"; break;
                 case 12: sItem = "li_loot_024"; break;
                 case 13: sItem = "li_loot_025"; break;
                 case 14: sItem = "li_loot_026"; break;
                 case 15: sItem = "li_loot_029"; break;
                 case 16: sItem = "li_loot_030"; break;
                 case 17: sItem = "li_loot_031"; break;

                 case 18: sItem = "li_kamulet002";   break;
                 case 19: sItem = "li_kamulet042";   break;
                 case 20: sItem = "li_kamulet043";   break;

                 case 21: sItem = "li_loot_052"; break;
                 case 22: sItem = "li_loot_053"; break;
                 case 23: sItem = "li_loot_058"; break;
                 case 24: sItem = "li_loot_059"; break;
                 case 25: sItem = "li_loot_060"; break;
                 case 26: sItem = "li_loot_061"; break;
                 case 27: sItem = "li_loot_062"; break;
                 case 28: sItem = "li_loot_063"; break;
                 case 29: sItem = "li_loot_068"; break;
                 case 30: sItem = "li_loot_069"; break;
                 case 31: sItem = "li_loot_073"; break;
                 case 32: sItem = "li_loot_074"; break;
                 case 33: sItem = "li_loot_075"; break;
                 case 34: sItem = "li_loot_076"; break;
                 case 35: sItem = "li_loot_078"; break;
                 case 36: sItem = "li_loot_079"; break;

                 case 37: sItem = "li_kprsten002";   break;
                 case 38: sItem = "li_kprsten030";   break;
                 case 39: sItem = "li_kprsten031";   break;
                 case 40: sItem = "li_kprsten032";   break;
                 case 41: sItem = "li_kprsten033";   break;
                 case 42: sItem = "li_kprsten034";   break;


//~rejty loot 3
                }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 500 - 5000
            {
                sItem = "li_loot_013";
                int nRandom = Random(55) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "li_loot_013"; break;
                 case 2: sItem = "li_loot_014"; break;
                 case 3: sItem = "li_loot_016"; break;
                 case 4: sItem = "li_loot_017"; break;
                 case 5: sItem = "li_loot_018"; break;
                 case 6: sItem = "li_loot_019"; break;
                 case 7: sItem = "li_loot_010"; break;
                 case 8: sItem = "li_loot_022"; break;
                 case 9: sItem = "li_loot_023"; break;
                 case 10: sItem = "li_loot_024"; break;
                 case 11: sItem = "li_loot_025"; break;
                 case 12: sItem = "li_loot_031"; break;
                 case 13: sItem = "li_loot_032"; break;

                 case 14: sItem = "li_kamulet003";   break;
                 case 15: sItem = "li_kamulet037";   break;
                 case 16: sItem = "li_kamulet038";   break;
                 case 17: sItem = "li_kamulet039";   break;
                 case 18: sItem = "li_kamulet002";   break;
                 case 19: sItem = "li_kamulet042";   break;
                 case 20: sItem = "li_kamulet043";   break;

                 case 21: sItem = "li_kprsten029";   break;

                 case 22: sItem = "li_loot_053"; break;
                 case 23: sItem = "li_loot_054"; break;
                 case 24: sItem = "li_loot_056"; break;
                 case 25: sItem = "li_loot_057"; break;
                 case 26: sItem = "li_loot_058"; break;
                 case 27: sItem = "li_loot_059"; break;
                 case 28: sItem = "li_loot_060"; break;
                 case 29: sItem = "li_loot_061"; break;
                 case 30: sItem = "li_loot_063"; break;
                 case 31: sItem = "li_loot_069"; break;
                 case 32: sItem = "li_loot_073"; break;
                 case 33: sItem = "li_loot_074"; break;
                 case 34: sItem = "li_loot_075"; break;
                 case 35: sItem = "li_loot_076"; break;
                 case 36: sItem = "li_loot_078"; break;
                 case 37: sItem = "li_loot_079"; break;
                 case 38: sItem = "li_loot_080"; break;
                 case 39: sItem = "li_loot_081"; break;
                 case 40: sItem = "li_loot_082"; break;

                 case 41: sItem = "li_kprsten024";   break;
                 case 42: sItem = "li_kprsten025";   break;
                 case 43: sItem = "li_kprsten026";   break;
                 case 44: sItem = "li_kprsten027";   break;
                 case 45: sItem = "li_kprsten028";   break;
                 case 46: sItem = "li_kprsten003";   break;
                 case 47: sItem = "li_kprsten021";   break;
                 case 48: sItem = "li_kprsten022";   break;
                 case 49: sItem = "li_kprsten023";   break;
                 case 50: sItem = "li_kprsten002";   break;
                 case 51: sItem = "li_kprsten030";   break;
                 case 52: sItem = "li_kprsten031";   break;
                 case 53: sItem = "li_kprsten032";   break;
                 case 54: sItem = "li_kprsten033";   break;
                 case 55: sItem = "li_kprsten034";   break;


//~rejty loot 4
                }
            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2000 - 10000
            {
                int nRandom = Random(45) + 1;
                switch (nRandom)
                {

                 case 1: sItem = "li_kprsten024";   break;
                 case 2: sItem = "li_kprsten025";   break;
                 case 3: sItem = "li_kprsten026";   break;
                 case 4: sItem = "li_kprsten027";   break;
                 case 5: sItem = "li_kprsten028";   break;
                 case 6: sItem = "li_kprsten003";   break;
                 case 7: sItem = "li_kprsten021";   break;
                 case 8: sItem = "li_kprsten022";   break;
                 case 9: sItem = "li_kprsten023";   break;
                 case 10: sItem = "li_kprsten029";   break;

                 case 11: sItem = "li_loot_044"; break;
                 case 12: sItem = "li_loot_045"; break;
                 case 13: sItem = "li_loot_046"; break;
                 case 14: sItem = "li_loot_047"; break;
                 case 15: sItem = "li_loot_048"; break;
                 case 16: sItem = "li_loot_054"; break;
                 case 17: sItem = "li_loot_056"; break;
                 case 18: sItem = "li_loot_057"; break;
                 case 19: sItem = "li_loot_064"; break;
                 case 20: sItem = "li_loot_077"; break;
                 case 21: sItem = "li_loot_078"; break;
                 case 22: sItem = "li_loot_079"; break;
                 case 23: sItem = "li_loot_080"; break;
                 case 24: sItem = "li_loot_081"; break;
                 case 25: sItem = "li_loot_082"; break;
                 case 26: sItem = "li_loot_083"; break;
                 case 27: sItem = "li_loot_012"; break;
                 case 28: sItem = "li_loot_013"; break;
                 case 29: sItem = "li_loot_014"; break;
                 case 30: sItem = "li_loot_015"; break;
                 case 31: sItem = "li_loot_016"; break;
                 case 32: sItem = "li_loot_017"; break;
                 case 33: sItem = "li_loot_018"; break;
                 case 34: sItem = "li_loot_021"; break;
                 case 35: sItem = "li_loot_024"; break;
                 case 36: sItem = "li_loot_031"; break;
                 case 37: sItem = "li_loot_032"; break;
                 case 38: sItem = "li_loot_033"; break;
                 case 39: sItem = "li_loot_035"; break;
                 case 40: sItem = "li_loot_036"; break;
                 case 41: sItem = "li_loot_040"; break;

                 case 42: sItem = "li_kamulet003";   break;
                 case 43: sItem = "li_kamulet037";   break;
                 case 44: sItem = "li_kamulet038";   break;
                 case 45: sItem = "li_kamulet039";   break;


//~rejty loot 5

                }
            }
            else if (GetRange(6, nHD, nTreasureType))   // * 4000 - 16250
            {
                int nRandom = Random(45) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "li_kamulet003";   break;
                 case 2: sItem = "li_kamulet037";   break;
                 case 3: sItem = "li_kamulet038";   break;
                 case 4: sItem = "li_kamulet039";   break;

                 case 5: sItem = "li_kprsten003";   break;
                 case 6: sItem = "li_kprsten021";   break;
                 case 7: sItem = "li_kprsten022";   break;

                 case 8: sItem = "li_loot_081"; break;
                 case 9: sItem = "li_loot_082"; break;
                 case 10: sItem = "li_loot_083"; break;
                 case 11: sItem = "li_loot_009"; break;
                 case 12: sItem = "li_loot_010"; break;
                 case 13: sItem = "li_loot_011"; break;
                 case 14: sItem = "li_loot_012"; break;
                 case 15: sItem = "li_loot_013"; break;
                 case 16: sItem = "li_loot_015"; break;
                 case 17: sItem = "li_loot_016"; break;
                 case 18: sItem = "li_loot_021"; break;
                 case 19: sItem = "li_loot_027"; break;
                 case 20: sItem = "li_loot_032"; break;
                 case 21: sItem = "li_loot_033"; break;
                 case 22: sItem = "li_loot_034"; break;
                 case 23: sItem = "li_loot_035"; break;
                 case 24: sItem = "li_loot_036"; break;
                 case 25: sItem = "li_loot_037"; break;
                 case 26: sItem = "li_loot_038"; break;
                 case 27: sItem = "li_loot_039"; break;
                 case 28: sItem = "li_loot_040"; break;
                 case 29: sItem = "li_loot_041"; break;
                 case 30: sItem = "li_loot_042"; break;
                 case 31: sItem = "li_loot_043"; break;
                 case 32: sItem = "li_loot_044"; break;
                 case 33: sItem = "li_loot_045"; break;
                 case 34: sItem = "li_loot_046"; break;
                 case 35: sItem = "li_loot_047"; break;
                 case 36: sItem = "li_loot_048"; break;
                 case 37: sItem = "li_loot_049"; break;
                 case 38: sItem = "li_loot_050"; break;
                 case 39: sItem = "li_loot_051"; break;
                 case 40: sItem = "li_loot_054"; break;
                 case 41: sItem = "li_loot_055"; break;
                 case 42: sItem = "li_loot_056"; break;
                 case 43: sItem = "li_loot_064"; break;
                 case 44: sItem = "li_loot_070"; break;
                 case 45: sItem = "li_loot_077"; break;



//~rejty loot 6
                 }
             }
             //dbSpeak("Create Misc");

             dbCreateItemOnObject(sItem, oTarget, 1);
         }

        void CreateGenericRodStaffWand(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                int nRandom = Random(1) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_it_gem002";  break;  // gem for variety
                }
            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                int nRandom = Random(8) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_it_gem002";  break;// gem for variety
                    case 2: sItem = "ry_hulka041";  break;
                    case 3: sItem = "ry_hulka040";  break;
                    case 4: sItem = "ry_hulka016";  break;
                    case 5: sItem = "ry_hulka029";  break;
                    case 6: sItem = "ry_hulka032";  break;
                    case 7: sItem = "armhe024";  break;
                    case 8: sItem = "ry_kouzhul015";  break;
                }
            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                int nRandom = Random(22) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "ry_hulka039";  break;
                    case 2: sItem = "ry_hulka001";  break;
                    case 3: sItem = "ry_hulka021";  break;
                    case 4: sItem = "ry_hulka022";  break;
                    case 5: sItem = "ry_hulka025";  break;
                    case 6: sItem = "ry_hulka026";  break;
                    case 7: sItem = "ry_hulka020";  break;
                    case 8: sItem = "ry_hulka019";  break;
                    case 9: sItem = "ry_hulka031";  break;
                    case 10: sItem = "ry_hulka";  break;
                    case 11: sItem = "ry_hulka004";  break;
                    case 12: sItem = "ry_hulka006";  break;
                    case 13: sItem = "ry_hulka008";  break;
                    case 14: sItem = "ry_hulka023";  break;
                    case 15: sItem = "ry_hulka024";  break;
                    case 16: sItem = "ry_hulka018";  break;
                    case 17: sItem = "ry_hulka011";  break;
                    case 18: sItem = "ry_hulka030";  break;
                    case 19: sItem = "ry_hulka045";  break;
                    case 20: sItem = "ry_hulka042";  break;
                    case 21: sItem = "armhe024";  break;
                    case 22: sItem = "ry_kouzhul015";  break;
                }
            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                int nRandom = Random(23) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "ry_hulka035";  break;
                    case 2: sItem = "ry_hulka002";  break;
                    case 3: sItem = "ry_hulka013";  break;
                    case 4: sItem = "ry_hulka037";  break;
                    case 5: sItem = "ry_hulka038";  break;
                    case 6: sItem = "ry_hulka034";  break;
                    case 7: sItem = "ry_hulka014";  break;
                    case 8: sItem = "ry_hulka027";  break;
                    case 9: sItem = "ry_hulka043";  break;
                    case 10: sItem = "ry_hulka044";  break;
                    case 11: sItem = "ry_hulka046";  break;
                    case 12: sItem = "ry_hulka047";  break;
                    case 13: sItem = "ry_hulka048";  break;
                    case 14: sItem = "armhe026";  break;
                    case 15: sItem = "ry_kouzhul001";  break;
                    case 16: sItem = "ry_kouzhul002";  break;
                    case 17: sItem = "ry_kouzhul003";  break;
                    case 18: sItem = "ry_kouzhul004";  break;
                    case 19: sItem = "ry_kouzhul005";  break;
                    case 20: sItem = "ry_kouzhul006";  break;
                    case 21: sItem = "ry_kouzhul007";  break;
                    case 22: sItem = "ry_kouzhul016";  break;
                    case 23: sItem = "ry_kouzhul019";  break;
                }
            }
            else if (GetRange(5, nHD, nTreasureType))
            {
                int nRandom = Random(20)+1;
                switch (nRandom)
                {
                    case 1: sItem = "ry_hulka015";  break;
                    case 2: sItem = "ry_hulka036";  break;
                    case 3: sItem = "ry_hulka028";  break;
                    case 4: sItem = "ry_hulka012";  break;
                    case 5: sItem = "ry_hulka017";  break;
                    case 6: sItem = "ry_hulka003";  break;
                    case 7: sItem = "ry_hulka005";  break;
                    case 8: sItem = "ry_hulka007";  break;
                    case 9: sItem = "ry_hulka009";  break;
                    case 10: sItem = "ry_hulka010";  break;
                    case 11: sItem = "armhe027";  break;
                    case 12: sItem = "ry_kouzhul008";  break;
                    case 13: sItem = "ry_kouzhul009";  break;
                    case 14: sItem = "ry_kouzhul010";  break;
                    case 15: sItem = "ry_kouzhul011";  break;
                    case 16: sItem = "ry_kouzhul012";  break;
                    case 17: sItem = "ry_kouzhul013";  break;
                    case 18: sItem = "ry_kouzhul014";  break;
                    case 19: sItem = "ry_kouzhul017";  break;
                    case 20: sItem = "ry_kouzhul018";  break;
                }
            }
            else if (GetRange(6, nHD, nTreasureType))
            {
                int nRandom = Random(19)+1;
                switch (nRandom)
                {
                    case 1: sItem = "armhe027";  break;
                    case 2: sItem = "x2_is_paleblue";  break;
                    case 3: sItem = "x2_is_drose";  break;
                    case 4: sItem = "x2_is_blue";  break;
                    case 5: sItem = "x2_is_pandgreen";  break;
                    case 6: sItem = "x2_is_pink";  break;
                    case 7: sItem = "x2_is_sandblue";  break;
                    case 8: sItem = "x2_is_deepred";  break;
                    case 9: sItem = "nw_maarcl106";  break;
                    case 10: sItem = "nw_it_mboots017";  break;
                    case 11: sItem = "ry_kouzhul008";  break;
                    case 12: sItem = "ry_kouzhul009";  break;
                    case 13: sItem = "ry_kouzhul010";  break;
                    case 14: sItem = "ry_kouzhul011";  break;
                    case 15: sItem = "ry_kouzhul012";  break;
                    case 16: sItem = "ry_kouzhul013";  break;
                    case 17: sItem = "ry_kouzhul014";  break;
                    case 18: sItem = "ry_kouzhul017";  break;
                    case 19: sItem = "ry_kouzhul018";  break;
                }
            }
          //dbSpeak("Generic Rod staff wand");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }

        void CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wbwsl001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspka001"; break;
                       case 7: sItem = "nw_wbwxh001"; break;
                       case 8: sItem = "nw_waxhn001"; break;
                       case 9: sItem = "nw_wbwxl001"; break;
                       case 10: sItem = "nw_wthmsh002"; break;
                   }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wbwsl001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspka001"; break;
                       case 7: sItem = "nw_wbwxh001"; break;
                       case 8: sItem = "nw_waxhn001"; break;
                       case 9: sItem = "nw_wbwxl001"; break;
                       case 10: sItem = "nw_wthmsh002"; break;
                       case 11: sItem = "nw_wbwmsl001"; break;
                       case 12: sItem = "nw_wbwmxh002"; break;
                       case 13: sItem = "nw_wthmsh008"; break;
                       case 14: sItem = "nw_wbwmxl002"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsl001"; break;
                       case 2: sItem = "nw_wbwmxh002"; break;
                       case 3: sItem = "nw_wthmsh008"; break;
                       case 4: sItem = "nw_wbwmxl002"; break;
                       case 5: sItem = "nw_wthmsh009"; break;
                       case 6: sItem = "nw_wblmcl002"; break;
                       case 7: sItem = "nw_wdbmqs002"; break;
                       case 8: sItem = "nw_wswmdg002"; break;
                       case 9: sItem = "nw_wspmka002"; break;
                       case 10: sItem = "nw_waxmhn002"; break;
                       case 11: sItem = "nw_wbwmsl009"; break;
                       case 12: sItem = "nw_wbwmxh008"; break;
                       case 13: sItem = "nw_wbwmxl008"; break;
                   }


            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh009"; break;
                       case 2: sItem = "nw_wblmcl002"; break;
                       case 3: sItem = "nw_wdbmqs002"; break;
                       case 4: sItem = "nw_wswmdg002"; break;
                       case 5: sItem = "nw_wspmka002"; break;
                       case 6: sItem = "nw_waxmhn002"; break;
                       case 7: sItem = "nw_wbwmsl009"; break;
                       case 8: sItem = "nw_wbwmxh008"; break;
                       case 9: sItem = "nw_wbwmxl008"; break;
                       case 10: sItem = "nw_wbwmsl010"; break;
                       case 11: sItem = "nw_wbwmxh009"; break;
                       case 12: sItem = "nw_wbwmxl009"; break;
                       case 13: sItem = "nw_wblmcl010"; break;
                       case 14: sItem = "nw_wdbmqs008"; break;
                       case 15: sItem = "nw_wswmdg008"; break;
                       case 16: sItem = "nw_wspmka008"; break;
                       case 17: sItem = "nw_waxmhn010"; break;
                   }
            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsl010"; break;
                       case 2: sItem = "nw_wbwmxh009"; break;
                       case 3: sItem = "nw_wbwmxl009"; break;
                       case 4: sItem = "nw_wblmcl010"; break;
                       case 5: sItem = "nw_wdbmqs008"; break;
                       case 6: sItem = "nw_wswmdg008"; break;
                       case 7: sItem = "nw_wspmka008"; break;
                       case 8: sItem = "nw_waxmhn010"; break;
                       case 9: sItem = "nw_wblmcl011"; break;
                       case 10: sItem = "nw_wdbmqs009"; break;
                       case 11: sItem = "nw_wswmdg009"; break;
                       case 12: sItem = "nw_wspmka009"; break;
                       case 13: sItem = "nw_waxmhn011"; break;
                   }
            }
          //dbSpeak("Generic Monk Weapon");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }

        void CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthdt001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wplss001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspsc001"; break;
                       case 7: sItem = "nw_wswsc001"; break;
                       case 8: sItem = "nw_wthmdt002"; break;
                   }
            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthdt001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wplss001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspsc001"; break;
                       case 7: sItem = "nw_wswsc001"; break;
                       case 8: sItem = "nw_wthmdt002"; break;
                       case 9: sItem = "nw_wthmdt005"; break;
                       case 10: sItem = "nw_wbwmsl001"; break;
                       case 11: sItem = "nw_wthmdt008"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt005"; break;
                       case 2: sItem = "nw_wbwmsl001"; break;
                       case 3: sItem = "nw_wthmdt008"; break;
                       case 4: sItem = "nw_wthmdt009"; break;
                       case 5: sItem = "nw_wthmdt006"; break;
                       case 6: sItem = "nw_wblmcl002"; break;
                       case 7: sItem = "nw_wdbmqs002"; break;
                       case 8: sItem = "nw_wplmss002"; break;
                       case 9: sItem = "nw_wswmdg002"; break;
                       case 10: sItem = "nw_wspmsc002"; break;
                       case 11: sItem = "nw_wswmsc002"; break;
                       case 12: sItem = "nw_wthmdt003"; break;
                       case 13: sItem = "nw_wbwmsl009"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(19) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt009"; break;
                       case 2: sItem = "nw_wthmdt006"; break;
                       case 3: sItem = "nw_wblmcl002"; break;
                       case 4: sItem = "nw_wdbmqs002"; break;
                       case 5: sItem = "nw_wplmss002"; break;
                       case 6: sItem = "nw_wswmdg002"; break;
                       case 7: sItem = "nw_wspmsc002"; break;
                       case 8: sItem = "nw_wswmsc002"; break;
                       case 9: sItem = "nw_wthmdt003"; break;
                       case 10: sItem = "nw_wbwmsl009"; break;
                       case 11: sItem = "nw_wthmdt007"; break;
                       case 12: sItem = "nw_wthmdt004"; break;
                       case 13: sItem = "nw_wbwmsl010"; break;
                       case 14: sItem = "nw_wblmcl010"; break;
                       case 15: sItem = "nw_wdbmqs008"; break;
                       case 16: sItem = "nw_wplmss010"; break;
                       case 17: sItem = "nw_wswmdg008"; break;
                       case 18: sItem = "nw_wspmsc010"; break;
                       case 19: sItem = "nw_wswmsc010"; break;
                   }

            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt007"; break;
                       case 2: sItem = "nw_wthmdt004"; break;
                       case 3: sItem = "nw_wbwmsl010"; break;
                       case 4: sItem = "nw_wblmcl010"; break;
                       case 5: sItem = "nw_wdbmqs008"; break;
                       case 6: sItem = "nw_wplmss010"; break;
                       case 7: sItem = "nw_wswmdg008"; break;
                       case 8: sItem = "nw_wspmsc010"; break;
                       case 9: sItem = "nw_wswmsc010"; break;
                       case 10: sItem = "nw_wblmcl011"; break;
                       case 11: sItem = "nw_wdbmqs009"; break;
                       case 12: sItem = "nw_wplmss011"; break;
                       case 13: sItem = "nw_wswmdg009"; break;
                       case 14: sItem = "nw_wspmsc011"; break;
                       case 15: sItem = "nw_wswmsc011"; break;
                   }

            }
          //dbSpeak("Generic Druid weapon");

           dbCreateItemOnObject(sItem, oTarget, 1);


        }

        void CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblcl001"; break;
                       case 2: sItem = "nw_wdbqs001"; break;
                       case 3: sItem = "nw_wswdg001"; break;
                       case 4: sItem = "nw_wbwxh001"; break;
                       case 5: sItem = "nw_wbwxl001"; break;
                   }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblcl001"; break;
                       case 2: sItem = "nw_wdbqs001"; break;
                       case 3: sItem = "nw_wswdg001"; break;
                       case 4: sItem = "nw_wbwxh001"; break;
                       case 5: sItem = "nw_wbwxl001"; break;
                       case 6: sItem = "nw_wbwmxl002"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxl002"; break;
                       case 2: sItem = "nw_wblmcl002"; break;
                       case 3: sItem = "nw_wdbmqs002"; break;
                       case 4: sItem = "nw_wswmdg002"; break;
                       case 5: sItem = "nw_wbwmxh008"; break;
                       case 6: sItem = "nw_wbwmxl008"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmcl002"; break;
                       case 2: sItem = "nw_wdbmqs002"; break;
                       case 3: sItem = "nw_wswmdg002"; break;
                       case 4: sItem = "nw_wbwmxh008"; break;
                       case 5: sItem = "nw_wbwmxl008"; break;
                       case 6: sItem = "nw_wbwmxh009"; break;
                       case 7: sItem = "nw_wbwmxl009"; break;
                       case 8: sItem = "nw_wblmcl010"; break;
                       case 9: sItem = "nw_wdbmqs008"; break;
                       case 10: sItem = "nw_wswmdg008"; break;
                   }

            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxh009"; break;
                       case 2: sItem = "nw_wbwmxl009"; break;
                       case 3: sItem = "nw_wblmcl010"; break;
                       case 4: sItem = "nw_wdbmqs008"; break;
                       case 5: sItem = "nw_wswmdg008"; break;
                       case 6: sItem = "nw_wblmcl011"; break;
                       case 7: sItem = "nw_wdbmqs009"; break;
                       case 8: sItem = "nw_wswmdg009"; break;
                   }

            }
          //dbSpeak("Generic Wizard or Sorcerer Weapon");

           dbCreateItemOnObject(sItem, oTarget, 1);

        }
        void CreateGenericSimple(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
           string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                int nRandom = d12();
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthdt001"; break;
                    case 2: sItem = "nw_wblcl001"; break;
                    case 3: sItem = "nw_wbwsl001"; break;
                    case 4: sItem = "nw_wplss001"; break;
                    case 5: sItem = "nw_wdbqs001"; break;
                    case 6: sItem = "nw_wswdg001"; break;
                    case 7: sItem = "nw_wblml001"; break;
                    case 8: sItem = "nw_wbwxh001"; break;
                    case 9: sItem = "nw_wspsc001"; break;
                    case 10: sItem = "nw_wblms001"; break;
                    case 11: sItem = "nw_wbwxl001"; break;
                    case 12: sItem = "nw_wthmdt002"; break;
                }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                int nRandom = Random(17) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthdt001"; break;
                    case 2: sItem = "nw_wblcl001"; break;
                    case 3: sItem = "nw_wbwsl001"; break;
                    case 4: sItem = "nw_wplss001"; break;
                    case 5: sItem = "nw_wdbqs001"; break;
                    case 6: sItem = "nw_wswdg001"; break;
                    case 7: sItem = "nw_wblml001"; break;
                    case 8: sItem = "nw_wbwxh001"; break;
                    case 9: sItem = "nw_wspsc001"; break;
                    case 10: sItem = "nw_wblms001"; break;
                    case 11: sItem = "nw_wbwxl001"; break;
                    case 12: sItem = "nw_wthmdt002"; break;
                    case 13: sItem = "nw_wthmdt005"; break;
                    case 14: sItem = "nw_wbwmsl001"; break;
                    case 15: sItem = "nw_wbwmxh002"; break;
                    case 16: sItem = "nw_wthmdt008"; break;
                    case 17: sItem = "nw_wbwmxl002"; break;
                }
            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                int nRandom = Random(19) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt005"; break;
                    case 2: sItem = "nw_wbwmsl001"; break;
                    case 3: sItem = "nw_wbwmxh002"; break;
                    case 4: sItem = "nw_wthmdt008"; break;
                    case 5: sItem = "nw_wbwmxl002"; break;
                    case 6: sItem = "nw_wthmdt009"; break;
                    case 7: sItem = "nw_wthmdt006"; break;
                    case 8: sItem = "nw_wblmcl002"; break;
                    case 9: sItem = "nw_wplmss002"; break;
                    case 10: sItem = "nw_wdbmqs002"; break;
                    case 11: sItem = "nw_wswmdg002"; break;
                    case 12: sItem = "nw_wblmml002"; break;
                    case 13: sItem = "nw_wspmsc002"; break;
                    case 14: sItem = "nw_wblmms002"; break;
                    case 15: sItem = "nw_wthmdt003"; break;
                    case 16: sItem = "nw_wthmdt003"; break;
                    case 17: sItem = "nw_wbwmsl009"; break;
                    case 18: sItem = "nw_wbwmxh008"; break;
                    case 19: sItem = "nw_wbwmxl008"; break;
                }
            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                int nRandom = Random(27) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt009"; break;
                    case 2: sItem = "nw_wthmdt006"; break;
                    case 3: sItem = "nw_wblmcl002"; break;
                    case 4: sItem = "nw_wplmss002"; break;
                    case 5: sItem = "nw_wdbmqs002"; break;
                    case 6: sItem = "nw_wswmdg002"; break;
                    case 7: sItem = "nw_wblmml002"; break;
                    case 8: sItem = "nw_wspmsc002"; break;
                    case 9: sItem = "nw_wblmms002"; break;
                    case 10: sItem = "nw_wthmdt003"; break;
                    case 11: sItem = "nw_wthmdt003"; break;
                    case 12: sItem = "nw_wbwmsl009"; break;
                    case 13: sItem = "nw_wbwmxh008"; break;
                    case 14: sItem = "nw_wbwmxl008"; break;
                    case 15: sItem = "nw_wthmdt007"; break;
                    case 16: sItem = "nw_wthmdt004"; break;
                    case 17: sItem = "nw_wbwmsl010"; break;
                    case 18: sItem = "nw_wbwmxh009"; break;
                    case 19: sItem = "nw_wbwmxl009"; break;
                    case 20: sItem = "nw_wbwmsl005"; break;
                    case 21: sItem = "nw_wblmcl010"; break;
                    case 22: sItem = "nw_wplmss010"; break;
                    case 23: sItem = "nw_wdbmqs008"; break;
                    case 24: sItem = "nw_wswmdg008"; break;
                    case 25: sItem = "nw_wblmml011"; break;
                    case 26: sItem = "nw_wspmsc010"; break;
                    case 27: sItem = "nw_wblmms010"; break;



                }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                int nRandom = Random(23) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt007"; break;
                    case 2: sItem = "nw_wthmdt004"; break;
                    case 3: sItem = "nw_wbwmsl010"; break;
                    case 4: sItem = "nw_wbwmxh009"; break;
                    case 5: sItem = "nw_wbwmxl009"; break;
                    case 6: sItem = "nw_wbwmsl005"; break;
                    case 7: sItem = "nw_wblmcl010"; break;
                    case 8: sItem = "nw_wplmss010"; break;
                    case 9: sItem = "nw_wdbmqs008"; break;
                    case 10: sItem = "nw_wswmdg008"; break;
                    case 11: sItem = "nw_wblmml011"; break;
                    case 12: sItem = "nw_wspmsc010"; break;
                    case 13: sItem = "nw_wblmms010"; break;
                    case 14: sItem = "nw_wblmms010"; break;
                    case 15: sItem = "nw_wblmms010"; break;
                    case 16: sItem = "nw_wblmms010"; break;
                    case 17: sItem = "nw_wblmcl011"; break;
                    case 18: sItem = "nw_wplmss011"; break;
                    case 19: sItem = "nw_wdbmqs009"; break;
                    case 20: sItem = "nw_wswmdg009"; break;
                    case 21: sItem = "nw_wblmml012"; break;
                    case 22: sItem = "nw_wspmsc011"; break;
                    case 23: sItem = "nw_wblmms011"; break;



                }
            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
                int nRandom = Random(7) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wblmcl011"; break;
                    case 2: sItem = "nw_wplmss011"; break;
                    case 3: sItem = "nw_wdbmqs009"; break;
                    case 4: sItem = "nw_wswmdg009"; break;
                    case 5: sItem = "nw_wblmml012"; break;
                    case 6: sItem = "nw_wspmsc011"; break;
                    case 7: sItem = "nw_wblmms011"; break;



                }
            }
            //dbSpeak("Create Generic SImple; Specific = " + IntToString(nModifier));

            dbCreateItemOnObject(sItem, oTarget, 1);
        }
        void CreateGenericMartial(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
           string sItem = "";

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                int nRandom = Random(17) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthax001"; break;
                    case 2: sItem = "nw_wblhl001"; break;
                    case 3: sItem = "nw_waxhn001"; break;
                    case 4: sItem = "nw_wblfl001"; break;
                    case 5: sItem = "nw_waxbt001"; break;
                    case 6: sItem = "nw_wplhb001"; break;
                    case 7: sItem = "nw_wswss001"; break;
                    case 8: sItem = "nw_wblhw001"; break;
                    case 9: sItem = "nw_wblfh001"; break;
                    case 10: sItem = "nw_wswls001"; break;
                    case 11: sItem = "nw_wswsc001"; break;
                    case 12: sItem = "nw_waxgr001"; break;
                    case 13: sItem = "nw_wswrp001"; break;
                    case 14: sItem = "nw_wbwsh001"; break;
                    case 15: sItem = "nw_wswbs001"; break;
                    case 16: sItem = "nw_wswgs001"; break;
                    case 17: sItem = "nw_wbwln001"; break;
                }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                int nRandom = Random(20) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthax001"; break;
                    case 2: sItem = "nw_wblhl001"; break;
                    case 3: sItem = "nw_waxhn001"; break;
                    case 4: sItem = "nw_wblfl001"; break;
                    case 5: sItem = "nw_waxbt001"; break;
                    case 6: sItem = "nw_wplhb001"; break;
                    case 7: sItem = "nw_wswss001"; break;
                    case 8: sItem = "nw_wblhw001"; break;
                    case 9: sItem = "nw_wblfh001"; break;
                    case 10: sItem = "nw_wswls001"; break;
                    case 11: sItem = "nw_wswsc001"; break;
                    case 12: sItem = "nw_waxgr001"; break;
                    case 13: sItem = "nw_wswrp001"; break;
                    case 14: sItem = "nw_wbwsh001"; break;
                    case 15: sItem = "nw_wswbs001"; break;
                    case 16: sItem = "nw_wswgs001"; break;
                    case 17: sItem = "nw_wbwln001"; break;
                    case 18: sItem = "nw_wthmax002"; break;
                    case 19: sItem = "nw_wbwmsh002"; break;
                    case 20: sItem = "nw_wbwmln002"; break;
                }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                int nRandom = Random(20) + 1;
                switch (nRandom)
                {
                         case 1: sItem = "nw_wthmax002"; break;
                         case 2: sItem = "nw_wbwmsh002"; break;
                         case 3: sItem = "nw_wbwmln002"; break;
                         case 4: sItem = "nw_wblmhl002"; break;
                         case 5: sItem = "nw_waxmhn002"; break;
                         case 6: sItem = "nw_wblmfl002"; break;
                         case 7: sItem = "nw_waxmbt002"; break;
                         case 8: sItem = "nw_wplmhb002"; break;
                         case 9: sItem = "nw_wblmhw002"; break;
                         case 10: sItem = "nw_wblmfh002"; break;
                         case 11: sItem = "nw_wswmls002"; break;
                         case 12: sItem = "nw_wswmsc002"; break;
                         case 13: sItem = "nw_waxmgr002"; break;
                         case 14: sItem = "nw_wswmrp002"; break;
                         case 15: sItem = "nw_wswmbs002"; break;
                         case 16: sItem = "nw_wswmgs002"; break;
                         case 17: sItem = "nw_wthmax008"; break;
                         case 18: sItem = "nw_wbwmsh008"; break;
                         case 19: sItem = "nw_wbwmln008"; break;
                         case 20: sItem = "nw_wswmss002"; break;

                 }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                int nRandom = Random(33) + 1;
                switch (nRandom)
                {
                     case 1: sItem = "nw_wblmhl002"; break;
                     case 2: sItem = "nw_waxmhn002"; break;
                     case 3: sItem = "nw_wblmfl002"; break;
                     case 4: sItem = "nw_waxmbt002"; break;
                     case 5: sItem = "nw_wplmhb002"; break;
                     case 6: sItem = "nw_wblmhw002"; break;
                     case 7: sItem = "nw_wblmfh002"; break;
                     case 8: sItem = "nw_wswmls002"; break;
                     case 9: sItem = "nw_wswmsc002"; break;
                     case 10: sItem = "nw_waxmgr002"; break;
                     case 11: sItem = "nw_wswmrp002"; break;
                     case 12: sItem = "nw_wswmbs002"; break;
                     case 13: sItem = "nw_wswmgs002"; break;
                     case 14: sItem = "nw_wthmax008"; break;
                     case 15: sItem = "nw_wbwmsh008"; break;
                     case 16: sItem = "nw_wbwmln008"; break;
                     case 17: sItem = "nw_wbwmsh009"; break;
                     case 18: sItem = "nw_wbwmln009"; break;
                     case 19: sItem = "nw_wblmhl010"; break;
                     case 20: sItem = "nw_waxmhn010"; break;
                     case 21: sItem = "nw_wblmfl010"; break;
                     case 22: sItem = "nw_waxmbt010"; break;
                     case 23: sItem = "nw_wplmhb010"; break;
                     case 24: sItem = "nw_wblmhw011"; break;
                     case 25: sItem = "nw_wblmfh010"; break;
                     case 26: sItem = "nw_wswmls010"; break;
                     case 27: sItem = "nw_waxmgr009"; break;
                     case 28: sItem = "nw_wswmbs009"; break;
                     case 29: sItem = "nw_wswmgs011"; break;
                     case 30: sItem = "nw_wswmrp010"; break;
                    case 31: sItem = "nw_wswmsc010"; break;
                    case 32: sItem = "nw_wswmss002"; break;
                    case 33: sItem = "nw_wswmss009"; break;
                 }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                  int nRandom = Random(20) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsh009"; break;
                       case 2: sItem = "nw_wbwmln009"; break;
                       case 3: sItem = "nw_wblmhl010"; break;
                       case 4: sItem = "nw_waxmhn010"; break;
                       case 5: sItem = "nw_wblmfl010"; break;
                       case 6: sItem = "nw_waxmbt010"; break;
                       case 7: sItem = "nw_wplmhb010"; break;
                       case 8: sItem = "nw_wblmhw011"; break;
                       case 9: sItem = "nw_wblmfh010"; break;
                       case 10: sItem = "nw_wswmls010"; break;
                       case 11: sItem = "nw_waxmgr009"; break;
                       case 12: sItem = "nw_wswmbs009"; break;
                       case 13: sItem = "nw_wswmgs011"; break;
                       case 14: sItem = "nw_wthmax009"; break;
                        case 15: sItem = "nw_wswmrp010"; break;
                        case 16: sItem = "nw_wswmrp011"; break;
                        case 17: sItem = "nw_wswmsc010"; break;
                        case 18: sItem = "nw_wswmss009"; break;
                        case 19: sItem = "nw_wswmsc011"; break;
                        case 20: sItem = "nw_wswmss011"; break;
                   }

            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmax009"; break;
                       case 2: sItem = "nw_waxmhn011"; break;
                       case 3: sItem = "nw_wblmfl011"; break;
                       case 4: sItem = "nw_waxmbt011"; break;
                       case 5: sItem = "nw_wplmhb011"; break;
                       case 6: sItem = "nw_wblmhw012"; break;
                       case 7: sItem = "nw_wblmfh011"; break;
                       case 8: sItem = "nw_wswmls012"; break;
                       case 9: sItem = "nw_waxmgr011"; break;
                       case 10: sItem = "nw_wswmbs010"; break;
                       case 11: sItem = "nw_wswmgs012"; break;
                        case 12: sItem = "nw_wswmrp011"; break;
                        case 13: sItem = "nw_wswmsc011"; break;
                        case 14: sItem = "nw_wswmss011"; break;
                   }

            }

            //dbSpeak("Create Generic Martial");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }
        void CreateGenericExotic(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wspka001"; break;
                       case 3: sItem = "nw_wspku001"; break;
                       case 4: sItem = "nw_wplsc001"; break;
                       case 5: sItem = "nw_wdbax001"; break;
                       case 6: sItem = "nw_wdbma001"; break;
                       case 7: sItem = "nw_wswka001"; break;
                       case 8: sItem = "nw_wthmsh002"; break;
                       case 9: sItem = "nw_wdbsw001"; break;
                   }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wspka001"; break;
                       case 3: sItem = "nw_wspku001"; break;
                       case 4: sItem = "nw_wplsc001"; break;
                       case 5: sItem = "nw_wdbax001"; break;
                       case 6: sItem = "nw_wdbma001"; break;
                       case 7: sItem = "nw_wswka001"; break;
                       case 8: sItem = "nw_wthmsh002"; break;
                       case 9: sItem = "nw_wdbsw001"; break;
                       case 10: sItem = "nw_wthmsh005"; break;
                       case 11: sItem = "nw_wspmka002"; break;
                       case 12: sItem = "nw_wspmku002"; break;
                       case 13: sItem = "nw_wplmsc002"; break;
                       case 14: sItem = "nw_wdbmax002"; break;
                       case 15: sItem = "nw_wdbmma002"; break;
                       case 16: sItem = "nw_wswmka002"; break;
                       case 17: sItem = "nw_wdbmsw002"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbsw001"; break;
                       case 2: sItem = "nw_wthmsh005"; break;
                       case 3: sItem = "nw_wspmka002"; break;
                       case 4: sItem = "nw_wspmku002"; break;
                       case 5: sItem = "nw_wplmsc002"; break;
                       case 6: sItem = "nw_wdbmax002"; break;
                       case 7: sItem = "nw_wdbmma002"; break;
                       case 8: sItem = "nw_wswmka002"; break;
                       case 9: sItem = "nw_wdbmsw002"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh005"; break;
                       case 2: sItem = "nw_wspmka002"; break;
                       case 3: sItem = "nw_wspmku002"; break;
                       case 4: sItem = "nw_wplmsc002"; break;
                       case 5: sItem = "nw_wdbmax002"; break;
                       case 6: sItem = "nw_wdbmma002"; break;
                       case 7: sItem = "nw_wswmka002"; break;
                       case 8: sItem = "nw_wdbmsw002"; break;
                       case 9: sItem = "nw_wthmsh008"; break;
                       case 10: sItem = "nw_wspmka008"; break;
                       case 11: sItem = "nw_wspmku008"; break;
                       case 12: sItem = "nw_wplmsc010"; break;
                       case 13: sItem = "nw_wdbmax010"; break;
                       case 14: sItem = "nw_wdbmma010"; break;
                       case 15: sItem = "nw_wswmka010"; break;
                       case 16: sItem = "nw_wdbmsw010"; break;
                       case 17: sItem = "nw_wthmsh009"; break;
                   }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wspmka008"; break;
                       case 2: sItem = "nw_wspmku008"; break;
                       case 3: sItem = "nw_wplmsc010"; break;
                       case 4: sItem = "nw_wdbmax010"; break;
                       case 5: sItem = "nw_wdbmma010"; break;
                       case 6: sItem = "nw_wswmka010"; break;
                       case 7: sItem = "nw_wdbmsw010"; break;
                       case 8: sItem = "nw_wthmsh009"; break;
                       case 9: sItem = "nw_wspmka009"; break;
                       case 10: sItem = "nw_wspmku009"; break;
                       case 11: sItem = "nw_wplmsc011"; break;
                       case 12: sItem = "nw_wdbmax011"; break;
                       case 13: sItem = "nw_wdbmma011"; break;
                   }

            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
            int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmsw010"; break;
                       case 2: sItem = "nw_wthmsh009"; break;
                       case 3: sItem = "nw_wspmka009"; break;
                       case 4: sItem = "nw_wspmku009"; break;
                       case 5: sItem = "nw_wplmsc011"; break;
                       case 6: sItem = "nw_wdbmax011"; break;
                       case 7: sItem = "nw_wdbmma011"; break;
                       case 8: sItem = "nw_wswmka011"; break;
                       case 9: sItem = "nw_wdbmsw011"; break;
                   }

            }
                  //dbSpeak("Create generic exotic");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }
        void CreateGenericLightArmor(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";

        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl009"; break;
                       case 2: sItem = "nw_ashsw001"; break;
                       case 3: sItem = "nw_aarcl001"; break;
                       case 4: sItem = "nw_aarcl002"; break;
                       case 5: sItem = "nw_aarcl012"; break;
                   }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl009"; break;
                       case 2: sItem = "nw_ashsw001"; break;
                       case 3: sItem = "nw_aarcl001"; break;
                       case 4: sItem = "nw_aarcl002"; break;
                       case 5: sItem = "nw_aarcl012"; break;
                       case 6: sItem = "nw_maarcl043"; break;
                       case 7: sItem = "nw_ashmsw002"; break;
                       case 8: sItem = "nw_maarcl044"; break;
                       case 9: sItem = "nw_maarcl045"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl043"; break;
                       case 2: sItem = "nw_ashmsw002"; break;
                       case 3: sItem = "nw_maarcl044"; break;
                       case 4: sItem = "nw_maarcl045"; break;
                       case 5: sItem = "nw_maarcl072"; break;
                       case 6: sItem = "nw_ashmsw008"; break;
                       case 7: sItem = "nw_maarcl071"; break;
                       case 8: sItem = "nw_maarcl075"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl072"; break;
                       case 2: sItem = "nw_ashmsw008"; break;
                       case 3: sItem = "nw_maarcl071"; break;
                       case 4: sItem = "nw_maarcl075"; break;
                       case 5: sItem = "nw_maarcl084"; break;
                       case 6: sItem = "nw_ashmsw009"; break;
                       case 7: sItem = "nw_maarcl083"; break;
                       case 8: sItem = "nw_maarcl087"; break;
                       case 9: sItem = "nw_maarcl079"; break;
                   }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl084"; break;
                       case 2: sItem = "nw_ashmsw009"; break;
                       case 3: sItem = "nw_maarcl083"; break;
                       case 4: sItem = "nw_maarcl087"; break;
                       case 5: sItem = "nw_maarcl079"; break;
                   }

            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl084"; break;
                       case 2: sItem = "nw_ashmsw009"; break;
                       case 3: sItem = "nw_maarcl083"; break;
                       case 4: sItem = "nw_maarcl087"; break;
                       case 5: sItem = "nw_maarcl079"; break;
                   }

            }
                  //dbSpeak("Create Generic light");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }
        void CreateGenericMediumArmor(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }
            string sItem = "";
            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                 int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_arhe001"; break;
                       case 2: sItem = "nw_arhe002"; break;
                       case 3: sItem = "nw_arhe003"; break;
                       case 4: sItem = "nw_arhe004"; break;
                       case 5: sItem = "nw_arhe005"; break;
                       case 6: sItem = "nw_aarcl008"; break;
                       case 7: sItem = "nw_ashlw001"; break;
                       case 8: sItem = "nw_aarcl003"; break;
                       case 9: sItem = "nw_aarcl004"; break;
                       case 10: sItem = "nw_aarcl010"; break;
                   }
            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_arhe001"; break;
                       case 2: sItem = "nw_arhe002"; break;
                       case 3: sItem = "nw_arhe003"; break;
                       case 4: sItem = "nw_arhe004"; break;
                       case 5: sItem = "nw_arhe005"; break;
                       case 6: sItem = "nw_aarcl008"; break;
                       case 7: sItem = "nw_ashlw001"; break;
                       case 8: sItem = "nw_aarcl003"; break;
                       case 9: sItem = "nw_aarcl004"; break;
                       case 10: sItem = "nw_aarcl010"; break;
                       case 11: sItem = "nw_maarcl047"; break;
                       case 12: sItem = "nw_ashmlw002"; break;
                       case 13: sItem = "nw_maarcl046"; break;
                       case 14: sItem = "nw_maarcl048"; break;
                       case 15: sItem = "nw_maarcl035"; break;
                       case 16: sItem = "nw_maarcl049"; break;
                       case 17: sItem = "nw_maarcl050"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl047"; break;
                       case 2: sItem = "nw_ashmlw002"; break;
                       case 3: sItem = "nw_maarcl046"; break;
                       case 4: sItem = "nw_maarcl048"; break;
                       case 5: sItem = "nw_maarcl035"; break;
                       case 6: sItem = "nw_maarcl049"; break;
                       case 7: sItem = "nw_maarcl050"; break;
                       case 8: sItem = "nw_maarcl070"; break;
                       case 9: sItem = "nw_ashmlw008"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                   int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl035"; break;
                       case 2: sItem = "nw_maarcl049"; break;
                       case 3: sItem = "nw_maarcl050"; break;
                       case 4: sItem = "nw_maarcl070"; break;
                       case 5: sItem = "nw_ashmlw008"; break;
                       case 6: sItem = "nw_maarcl067"; break;
                       case 7: sItem = "nw_maarcl073"; break;
                       case 8: sItem = "nw_maarcl065"; break;
                       case 9: sItem = "nw_maarcl066"; break;
                       case 10: sItem = "nw_maarcl082"; break;
                       case 11: sItem = "nw_ashmlw009"; break;
                       case 12: sItem = "nw_maarcl085"; break;
                       case 13: sItem = "nw_maarcl077"; break;
                       case 14: sItem = "nw_maarcl078"; break;
                   }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl070"; break;
                       case 2: sItem = "nw_ashmlw008"; break;
                       case 3: sItem = "nw_maarcl067"; break;
                       case 4: sItem = "nw_maarcl073"; break;
                       case 5: sItem = "nw_maarcl065"; break;
                       case 6: sItem = "nw_maarcl066"; break;
                       case 7: sItem = "nw_maarcl082"; break;
                       case 8: sItem = "nw_ashmlw009"; break;
                       case 9: sItem = "nw_maarcl085"; break;
                       case 10: sItem = "nw_maarcl077"; break;
                       case 11: sItem = "nw_maarcl078"; break;
                   }

            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl070"; break;
                       case 2: sItem = "nw_ashmlw008"; break;
                       case 3: sItem = "nw_maarcl067"; break;
                       case 4: sItem = "nw_maarcl073"; break;
                       case 5: sItem = "nw_maarcl065"; break;
                       case 6: sItem = "nw_maarcl066"; break;
                       case 7: sItem = "nw_maarcl082"; break;
                       case 8: sItem = "nw_ashmlw009"; break;
                       case 9: sItem = "nw_maarcl085"; break;
                       case 10: sItem = "nw_maarcl077"; break;
                       case 11: sItem = "nw_maarcl078"; break;
                   }

            }
                  //dbSpeak("Create Generic medium");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }
        void CreateGenericHeavyArmor(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
        {
            string sItem = "";
        int nHD;
        if(nModifier != 0){
         nHD = nModifier;
        }
        else{
         nHD = GetHitDice(oAdventurer);
        }

            if (GetRange(1, nHD, nTreasureType))    // * 200
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashto001"; break;
                       case 2: sItem = "nw_aarcl005"; break;
                       case 3: sItem = "nw_aarcl011"; break;
                   }

            }
            else if (GetRange(2, nHD, nTreasureType))   // * 800
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashto001"; break;
                       case 2: sItem = "nw_aarcl005"; break;
                       case 3: sItem = "nw_aarcl011"; break;
                       case 4: sItem = "nw_aarcl006"; break;
                       case 5: sItem = "nw_ashmto002"; break;
                       case 6: sItem = "nw_maarcl051"; break;
                   }

            }
            else if (GetRange(3, nHD, nTreasureType))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl005"; break;
                       case 2: sItem = "nw_aarcl011"; break;
                       case 3: sItem = "nw_aarcl006"; break;
                       case 4: sItem = "nw_ashmto002"; break;
                       case 5: sItem = "nw_maarcl051"; break;
                       case 6: sItem = "nw_maarcl052"; break;
                       case 7: sItem = "nw_aarcl007"; break;
                       case 8: sItem = "nw_maarcl053"; break;
                       case 9: sItem = "nw_ashmto008"; break;
                   }

            }
            else if (GetRange(4, nHD, nTreasureType))   // * 800 - 10000
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl051"; break;
                       case 2: sItem = "nw_maarcl052"; break;
                       case 3: sItem = "nw_aarcl007"; break;
                       case 4: sItem = "nw_maarcl053"; break;
                       case 5: sItem = "nw_ashmto008"; break;
                       case 6: sItem = "nw_maarcl064"; break;
                       case 7: sItem = "nw_maarcl074"; break;
                       case 8: sItem = "nw_maarcl069"; break;
                       case 9: sItem = "nw_maarcl068"; break;
                       case 10: sItem = "nw_ashmto003"; break;
                       case 11: sItem = "nw_ashmto009"; break;
                       case 12: sItem = "nw_maarcl076"; break;
                       case 13: sItem = "nw_maarcl086"; break;
                       case 14: sItem = "nw_maarcl081"; break;
                       case 15: sItem = "nw_maarcl080"; break;
                   }

            }
            else if (GetRange(5, nHD, nTreasureType))   // * 2500 - 16500
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashmto008"; break;
                       case 2: sItem = "nw_maarcl064"; break;
                       case 3: sItem = "nw_maarcl074"; break;
                       case 4: sItem = "nw_maarcl069"; break;
                       case 5: sItem = "nw_maarcl068"; break;
                       case 6: sItem = "nw_ashmto009"; break;
                       case 7: sItem = "nw_maarcl076"; break;
                       case 8: sItem = "nw_maarcl086"; break;
                       case 9: sItem = "nw_maarcl081"; break;
                       case 10: sItem = "nw_maarcl080"; break;
                   }


            }
            else if (GetRange(6, nHD, nTreasureType))   // * 8000 - 25000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashmto009"; break;
                       case 2: sItem = "nw_maarcl076"; break;
                       case 3: sItem = "nw_maarcl086"; break;
                       case 4: sItem = "nw_maarcl081"; break;
                       case 5: sItem = "nw_maarcl080"; break;
                   }

            }
                 // dbSpeak("Create Generic heavy");

           dbCreateItemOnObject(sItem, oTarget, 1);
        }

    void CreateTable2Item(object oTarget, object oAdventurer, int nTreasureType, int nModifier=0)
    {
        int rand = Random(10)+1;

        switch(rand){
            case 1: CreateGenericDruidWeapon(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 2: CreateGenericWizardWeapon(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 3: CreateGenericMonkWeapon(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 4: CreateGenericMiscItem(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 5: CreateGenericRodStaffWand(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 6: CreateGenericSimple(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 7: CreateGenericMartial(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 8: CreateGenericExotic(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 9: CreateGenericLightArmor(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 10: CreateGenericMediumArmor(oTarget, oAdventurer, nTreasureType, nModifier); break;
            case 11: CreateGenericHeavyArmor(oTarget, oAdventurer, nTreasureType, nModifier); break;
        }
    }
//jaara
void CreateBossItems(object oTarget){

  string sItem = "";
  switch(Random(108)) {

case 0: sItem="ry_ca_bspost_1"; break;
case 1: sItem="ry_ca_bspost_2"; break;
case 2: sItem="ry_ca_bspost_3"; break;
case 3: sItem="ry_ca_bermr_1"; break;
case 4: sItem="ry_ca_bermr_2"; break;
case 5: sItem="ry_ca_bermr_3"; break;
case 6: sItem="ry_ca_bourliv_1"; break;
case 7: sItem="ry_ca_bourliv_2"; break;
case 8: sItem="ry_ca_bourliv_3"; break;
case 9: sItem="ry_ca_cars_1"; break;
case 10: sItem="ry_ca_cars_2"; break;
case 11: sItem="ry_ca_cars_3"; break;
case 12: sItem="ry_ca_cepv_1"; break;
case 13: sItem="ry_ca_cepv_2"; break;
case 14: sItem="ry_ca_cepv_3"; break;
case 15: sItem="ry_ca_drkat_1"; break;
case 16: sItem="ry_ca_drkat_2"; break;
case 17: sItem="ry_ca_drkat_3"; break;
case 18: sItem="ry_ca_drzub_1"; break;
case 19: sItem="ry_ca_drzub_2"; break;
case 20: sItem="ry_ca_drzub_3"; break;
case 21: sItem="ry_ca_drtleb_1"; break;
case 22: sItem="ry_ca_drtleb_2"; break;
case 23: sItem="ry_ca_drtleb_3"; break;
case 24: sItem="ry_ca_duha_1"; break;
case 25: sItem="ry_ca_duha_2"; break;
case 26: sItem="ry_ca_duha_3"; break;
case 27: sItem="ry_ca_dvvsl_1"; break;
case 28: sItem="ry_ca_dvvsl_2"; break;
case 29: sItem="ry_ca_dvvsl_3"; break;
case 30: sItem="ry_ca_genluk_1"; break;
case 31: sItem="ry_ca_genluk_2"; break;
case 32: sItem="ry_ca_genluk_3"; break;
case 33: sItem="ry_ca_hnprir_1"; break;
case 34: sItem="ry_ca_hnprir_2"; break;
case 35: sItem="ry_ca_hnprir_3"; break;
case 36: sItem="ry_ca_hohne_1"; break;
case 37: sItem="ry_ca_hohne_2"; break;
case 38: sItem="ry_ca_hohne_3"; break;
case 39: sItem="ry_ca_inkviz_1"; break;
case 40: sItem="ry_ca_inkviz_2"; break;
case 41: sItem="ry_ca_inkviz_3"; break;
case 42: sItem="ry_art_kopjedn_1"; break;
case 43: sItem="ry_art_kopjedn_2"; break;
case 44: sItem="ry_art_kopjedn_3"; break;
case 45: sItem="ry_ca_lukobr_1"; break;
case 46: sItem="ry_ca_lukobr_2"; break;
case 47: sItem="ry_ca_lukobr_3"; break;
case 48: sItem="ry_ca_mecrovn_1"; break;
case 49: sItem="ry_ca_mecrovn_2"; break;
case 50: sItem="ry_ca_mecrovn_3"; break;
case 51: sItem="ry_ca_mlzspar_1"; break;
case 52: sItem="ry_ca_mlzspar_2"; break;
case 53: sItem="ry_ca_mlzspar_3"; break;
case 54: sItem="ry_ca_obrsrp_1"; break;
case 55: sItem="ry_ca_obrsrp_2"; break;
case 56: sItem="ry_ca_obrsrp_3"; break;
case 57: sItem="ry_ca_palcrus_1"; break;
case 58: sItem="ry_ca_palcrus_2"; break;
case 59: sItem="ry_ca_palcrus_3"; break;
case 60: sItem="ry_ca_pansmrt_1"; break;
case 61: sItem="ry_ca_pansmrt_2"; break;
case 62: sItem="ry_ca_pansmrt_3"; break;
case 63: sItem="ry_ca_pekspoj_1"; break;
case 64: sItem="ry_ca_pekspoj_2"; break;
case 65: sItem="ry_ca_pekspoj_3"; break;
case 66: sItem="ry_ca_plamsev_1"; break;
case 67: sItem="ry_ca_plamsev_2"; break;
case 68: sItem="ry_ca_plamsev_3"; break;
case 69: sItem="ry_ca_plamjaz_1"; break;
case 70: sItem="ry_ca_plamjaz_2"; break;
case 71: sItem="ry_ca_plamjaz_3"; break;
case 72: sItem="ry_ca_pospek_1"; break;
case 73: sItem="ry_ca_pospek_2"; break;
case 74: sItem="ry_ca_pospek_3"; break;
case 75: sItem="ry_ca_posmsrt_1"; break;
case 76: sItem="ry_ca_posmsrt_2"; break;
case 77: sItem="ry_ca_posmsrt_3"; break;
case 78: sItem="ry_ca_postrmor_1"; break;
case 79: sItem="ry_ca_postrmor_2"; break;
case 80: sItem="ry_ca_postrmor_3"; break;
case 81: sItem="ry_ca_rucbal_1"; break;
case 82: sItem="ry_ca_rucbal_2"; break;
case 83: sItem="ry_ca_rucbal_3"; break;
case 84: sItem="ry_ca_sedlud_1"; break;
case 85: sItem="ry_ca_sedlud_2"; break;
case 86: sItem="ry_ca_sedlud_3"; break;
case 87: sItem="ry_ca_sekacek_1"; break;
case 88: sItem="ry_ca_sekacek_2"; break;
case 89: sItem="ry_ca_sekacek_3"; break;
case 90: sItem="ry_ca_skripav_1"; break;
case 91: sItem="ry_ca_skripav_2"; break;
case 92: sItem="ry_ca_skripav_3"; break;
case 93: sItem="ry_art_stribrm_1"; break;
case 94: sItem="ry_art_stribrm_2"; break;
case 95: sItem="ry_art_stribrm_3"; break;
case 96: sItem="ry_ca_tothul_1"; break;
case 97: sItem="ry_ca_tothul_2"; break;
case 98: sItem="ry_ca_tothul_3"; break;
case 99: sItem="ry_ca_vlna_1"; break;
case 100: sItem="ry_ca_vlna_2"; break;
case 101: sItem="ry_ca_vlna_3"; break;
case 102: sItem="ry_ca_xitesak_1"; break;
case 103: sItem="ry_ca_xitesak_2"; break;
case 104: sItem="ry_ca_xitesak_3"; break;
case 105: sItem="ry_ca_zachran_1"; break;
case 106: sItem="ry_ca_zachran_2"; break;
case 107: sItem="ry_ca_zachran_3"; break;

  }

  CreateItemOnObject(sItem, oTarget, 1);

    /*
    if(Random(100) < 5){
        string sItem;
        switch(Random(27)){
            case 0: sItem = "kh_rcp_amulhrd"; break;
            case 1: sItem = "kh_rcp_bourli"; break;
            case 2: sItem = "kh_rcp_celcerno"; break;
            case 3: sItem = "kh_rcp_cplsvetla"; break;
            case 4: sItem = "kh_rcp_drtleb"; break;
            case 5: sItem = "kh_rcp_dusclon"; break;
            case 6: sItem = "kh_rcp_gladsek"; break;
            case 7: sItem = "kh_rcp_hulmoc"; break;
            case 8: sItem = "kh_rcp_magbit"; break;
            case 9: sItem = "kh_rcp_ocelkuze"; break;
            case 10: sItem = "kh_rcp_ocelpal"; break;
            case 11: sItem = "kh_rcp_ohnkrunyr"; break;
            case 12: sItem = "kh_rcp_ohnpiest"; break;
            case 13: sItem = "kh_rcp_ohnstit"; break;
            case 14: sItem = "kh_rcp_paskyk"; break;
            case 15: sItem = "kh_rcp_plmjaz"; break;
            case 16: sItem = "kh_rcp_pospek"; break;
            case 17: sItem = "kh_rcp_possmrt"; break;
            case 18: sItem = "kh_rcp_pulmes"; break;
            case 19: sItem = "kh_rcp_rucbal"; break;
            case 20: sItem = "kh_rcp_sedlak"; break;
            case 21: sItem = "kh_rcp_sedmil"; break;
            case 22: sItem = "kh_rcp_sparslad"; break;
            case 23: sItem = "kh_rcp_spevcep"; break;
            case 24: sItem = "kh_rcp_temcep"; break;
            case 25: sItem = "kh_rcp_totem"; break;
            case 26: sItem = "kh_rcp_tygzbroj"; break;
        }

        CreateItemOnObject(sItem, oTarget, 1);
    }
    */
}
//~jaara

void nt_CreateSpecificTreasure(int iType, int nTreasureType, object oLastOpener, object oCreateOn, int nLvl)
{
  if(iType & LOOT_TYPE_DISP > 0) {}
  if(iType & LOOT_TYPE_AMMO > 0)
    CreateAmmo(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_GOLD > 0)
    CreateGold(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_ITEM > 0) { }
  if(iType & LOOT_TYPE_BOOK > 0)
    CreateBook(oCreateOn);
  if(iType & LOOT_TYPE_ANIMAL > 0)
    CreateAnimalPart(oCreateOn);
  if(iType & LOOT_TYPE_JUNK > 0)
    CreateJunk(oCreateOn);
  if(iType & LOOT_TYPE_GEM > 0)
    CreateGem(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_JEWEL > 0)
    CreateJewel(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_SCROLL_A > 0)
    pa_CreateArcaneScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_SCROLL_D > 0)
    CreateDivineScroll(oCreateOn, oLastOpener, nTreasureType, nLvl); 
  if(iType & LOOT_TYPE_KIT > 0)
    CreateKit(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_POTION > 0)
    CreatePotion(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_WEAPON > 0)
    CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_WEAPON_RANGED > 0)
    CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_WEAPON_MELEE > 0)
    CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);
  if(iType & LOOT_TYPE_ARMOR > 0)
    CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);
    
  if(iType & LOOT_TYPE_CLOTHING > 0) { }
    CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);
  
}

void nt_GenerateSpecificTreasure(int iType, int nTreasureType, object oLastOpener, object oCreateOn) {
    SetNextSpawn();

    // Postih na skryvani a zruseni kouzel pri otevreni bedny
    effect eEff = GetFirstEffect(oLastOpener);
    while(GetIsEffectValid(eEff)) {
      int iEffType = GetEffectType(eEff);
      switch(iEffType) {
        case EFFECT_TYPE_INVISIBILITY:
        case EFFECT_TYPE_IMPROVEDINVISIBILITY:
        case EFFECT_TYPE_SANCTUARY:
        case 81:
          RemoveEffect(oLastOpener,eEff);
          break;
        default: break;
      }
      eEff = GetNextEffect(oLastOpener);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,30),oLastOpener,15.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,30),oLastOpener,15.0);

    //dbSpeak("*********************NEW TREASURE*************************");

    // * abort treasure if no one opened the container
    if (GetIsObjectValid(oLastOpener) == FALSE)
    {
        //dbSpeak("Aborted.  No valid Last Opener");
        return;
    }

    // * if no valid create on object, then create on oLastOpener
    if (oCreateOn == OBJECT_INVALID)
    {
        oCreateOn = oLastOpener;
    }

    int nLvl = 0;

    if( oLastOpener != OBJECT_SELF){
        object oArea = GetArea(oCreateOn);
        nLvl = GetLocalInt(oArea, "TREASURE_VALUE");
        if(!nLvl) nLvl = 1;
    }
    else{
        nLvl = FloatToInt( GetChallengeRating(OBJECT_SELF)/2.0f );
    }

   // Pokud v okoli neni nikdo, kdo nema plny loot limit, negeneruj nic - by Kucik
/*   if(GetLocalInt(OBJECT_SELF,"KU_TREASURE_TYPE")!=1) {
     if(!KU_LootFunctions_CheckLimitInGroup())
       return;
   }
*/

   int iCount = 1;
   if(nTreasureType == TREASURE_MEDIUM )
     iCount = d2();
   if(nTreasureType ==  TREASURE_HIGH)
     iCount = d3();

   int i;
   for(i = 0; i < iCount; i++) {
     nt_CreateSpecificTreasure(iType, nTreasureType, oLastOpener, oCreateOn, nLvl);
   }

}

//::///////////////////////////////////////////////
//:: GenerateTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Generate Treasure
   NOTE: When used by NPCs, the treasure is scaled
   to how powerful the NPC is.

   If used by containers, it is scaled by how
   powerful the PC is.

   PARAMETERS
   oLastOpener = The creature that opened the container
   oCreateOn = The place to put the treasure. If this is
    invalid then the treasure is placed on oLastOpener


*/
//:://////////////////////////////////////////////
//:: Created By:  Andrew
//:: Created On:
//:://////////////////////////////////////////////
void GenerateTreasure(int nTreasureType, object oLastOpener, object oCreateOn)
{
    SetNextSpawn();

    // Postih na skryvani a zruseni kouzel pri otevreni bedny
    effect eEff = GetFirstEffect(oLastOpener);
    while(GetIsEffectValid(eEff)) {
      int iEffType = GetEffectType(eEff);
      switch(iEffType) {
        case EFFECT_TYPE_INVISIBILITY:
        case EFFECT_TYPE_IMPROVEDINVISIBILITY:
        case EFFECT_TYPE_SANCTUARY:
        case 81:
          RemoveEffect(oLastOpener,eEff);
          break;
        default: break;
      }
/*      SpeakString("Effect is "+IntToString(iEffType)+"Compare with:"+IntToString(EFFECT_TYPE_INVISIBILITY)+";"+IntToString(EFFECT_TYPE_SANCTUARY)+";"+IntToString(EFFECT_TYPE_IMPROVEDINVISIBILITY)+";");
      if( (GetEffectType(eEff) == EFFECT_TYPE_INVISIBILITY) ||
          (GetEffectType(eEff) == EFFECT_TYPE_SANCTUARY) ||
          (GetEffectType(eEff) == EFFECT_TYPE_IMPROVEDINVISIBILITY) ) {

        RemoveEffect(oLastOpener,eEff);
      }*/
      eEff = GetNextEffect(oLastOpener);
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,30),oLastOpener,15.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,30),oLastOpener,15.0);

    //dbSpeak("*********************NEW TREASURE*************************");

    // * abort treasure if no one opened the container
    if (GetIsObjectValid(oLastOpener) == FALSE)
    {
        //dbSpeak("Aborted.  No valid Last Opener");
        return;
    }

    // * if no valid create on object, then create on oLastOpener
    if (oCreateOn == OBJECT_INVALID)
    {
        oCreateOn = oLastOpener;
    }

    int nLvl = 0;

    if( oLastOpener != OBJECT_SELF){
        object oArea = GetArea(oCreateOn);
        nLvl = GetLocalInt(oArea, "TREASURE_VALUE");
        if(!nLvl) nLvl = 5;
    }
    else{
        nLvl = FloatToInt( GetChallengeRating(OBJECT_SELF)/2.0f );
    }

   // Pokud v okoli neni nikdo, kdo nema plny loot limit, negeneruj nic - by Kucik
/*   if(GetLocalInt(OBJECT_SELF,"KU_TREASURE_TYPE")!=1) {
     if(!KU_LootFunctions_CheckLimitInGroup())
       return;
   }
*/

   // * VARIABLES
   int nProbBook = 0;
   int nProbAnimal = 0;
   int nProbJunk = 0;
   int nProbGold = 0;
   int nProbGem = 0;
   int nProbJewel = 0;
   int nProbArcane = 0;
   int nProbDivine = 0;
   int nProbAmmo = 0;
   int nProbKit = 0;
   int nProbPotion = 0;
   int nProbTable2 = 0;
   int nProbMisc = 0;


   int i = 0;
//   int nNumberItems = GetNumberOfItems(nTreasureType);
   int nNumberItems = 1;  //odted jen jeden item na poklad


   int nProbOnlyGold;
   int nProbItem;
   int nProbGoldAndItem;

   if (nTreasureType == TREASURE_LOW) {
     nProbOnlyGold      = LOW_PROB_ONLYGOLD;
     nProbItem          = LOW_PROB_ITEM;
     nProbGoldAndItem   = LOW_PROB_GOLDANDITEM;
   }
   else if (nTreasureType == TREASURE_MEDIUM) {
     nProbOnlyGold      = MEDIUM_PROB_ONLYGOLD;
     nProbItem          = MEDIUM_PROB_ITEM;
     nProbGoldAndItem   = MEDIUM_PROB_GOLDANDITEM;
   }
   else if (nTreasureType == TREASURE_HIGH) {
     nProbOnlyGold      = HIGH_PROB_ONLYGOLD;
     nProbItem          = HIGH_PROB_ITEM;
     nProbGoldAndItem   = HIGH_PROB_GOLDANDITEM;
   }
   else
     return;

      // * Set Treasure Type Values
   if (nTreasureType == TREASURE_LOW)
   {
    nProbMisc   = LOW_PROB_MISC;
    nProbGem    = LOW_PROB_GEM;
    nProbArcane = LOW_PROB_ARCANE;
    nProbDivine = LOW_PROB_DIVINE;
    nProbPotion = LOW_PROB_POTION;
   }
   else if (nTreasureType == TREASURE_MEDIUM)
   {
    nProbMisc   = MEDIUM_PROB_MISC;
    nProbGem    = MEDIUM_PROB_GEM;
    nProbArcane = MEDIUM_PROB_ARCANE;
    nProbDivine = MEDIUM_PROB_DIVINE;
    nProbPotion = MEDIUM_PROB_POTION;
   }
   else if (nTreasureType == TREASURE_HIGH)
   {
    nProbMisc   = HIGH_PROB_MISC;
    nProbGem    = HIGH_PROB_GEM;
    nProbArcane = HIGH_PROB_ARCANE;
    nProbDivine = HIGH_PROB_DIVINE;
    nProbPotion = HIGH_PROB_POTION;
   }
   int nProbSum = nProbMisc + nProbGem + nProbArcane + nProbDivine + nProbPotion;

   int nRandom = Random(nProbOnlyGold + nProbItem + nProbGoldAndItem) + 1;
   if(nRandom <= nProbOnlyGold ) {                 // pouze zlato
     CreateGold(oCreateOn, oLastOpener, nTreasureType, nLvl);    // * Gold
   }
   else if(nRandom <= nProbOnlyGold + nProbItem) { //pouze item
     nRandom = Random(nProbSum) + 1;
     if (nRandom <= nProbMisc)
       CreateGenericMiscItem(oCreateOn, oLastOpener, nTreasureType, nLvl); //misc
     else if (nRandom <= nProbMisc + nProbGem)
       CreateGem(oCreateOn, oLastOpener, nTreasureType, nLvl);     // * Gem
     else if (nRandom <= nProbMisc + nProbGem + nProbArcane)
       pa_CreateArcaneScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Arcane Scroll
     else if (nRandom <= nProbMisc + nProbGem + nProbArcane + nProbDivine)
       CreateDivineScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Divine Scroll
     else
       CreatePotion(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Potion
   }
   else {                                          // zlato i item
     CreateGold(oCreateOn, oLastOpener, nTreasureType, nLvl);    // * Gold
     nRandom = Random(nProbSum) + 1;
     if (nRandom <= nProbMisc)
       CreateGenericMiscItem(oCreateOn, oLastOpener, nTreasureType, nLvl); //misc
     else if (nRandom <= nProbMisc + nProbGem)
       CreateGem(oCreateOn, oLastOpener, nTreasureType, nLvl);     // * Gem
     else if (nRandom <= nProbMisc + nProbGem + nProbArcane)
       pa_CreateArcaneScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Arcane Scroll
     else if (nRandom <= nProbMisc + nProbGem + nProbArcane + nProbDivine)
       CreateDivineScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Divine Scroll
     else
       CreatePotion(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Potion

   }
   if(d100() <= 2)
     CreateAle(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Ale
// Generovat se bude jinak
/*
   // * Set Treasure Type Values
   if (nTreasureType == TREASURE_LOW)
   {
    nProbBook   = LOW_PROB_BOOK;
    nProbAnimal = LOW_PROB_ANIMAL;
    nProbJunk   = LOW_PROB_JUNK;
    nProbGold   = LOW_PROB_GOLD;
    nProbGem    = LOW_PROB_GEM;
    nProbJewel  = LOW_PROB_JEWEL;
    nProbArcane = LOW_PROB_ARCANE;
    nProbDivine  = LOW_PROB_DIVINE;
    nProbAmmo = LOW_PROB_AMMO ;
    nProbKit = LOW_PROB_KIT;
    nProbPotion = LOW_PROB_POTION;
    nProbTable2 = LOW_PROB_TABLE2;
   }
   else if (nTreasureType == TREASURE_MEDIUM)
   {
    nProbBook   = MEDIUM_PROB_BOOK;
    nProbAnimal = MEDIUM_PROB_ANIMAL;
    nProbJunk   = MEDIUM_PROB_JUNK;
    nProbGold   = MEDIUM_PROB_GOLD;
    nProbGem    = MEDIUM_PROB_GEM;
    nProbJewel  = MEDIUM_PROB_JEWEL;
    nProbArcane = MEDIUM_PROB_ARCANE;
    nProbDivine = MEDIUM_PROB_DIVINE;
    nProbAmmo   = MEDIUM_PROB_AMMO ;
    nProbKit    = MEDIUM_PROB_KIT;
    nProbPotion = MEDIUM_PROB_POTION;
    nProbTable2 = MEDIUM_PROB_TABLE2;
   }
   else if (nTreasureType == TREASURE_HIGH)
   {
    nProbBook   = HIGH_PROB_BOOK;
    nProbAnimal = HIGH_PROB_ANIMAL;
    nProbJunk   = HIGH_PROB_JUNK;
    nProbGold   = HIGH_PROB_GOLD;
    nProbGem    = HIGH_PROB_GEM;
    nProbJewel  = HIGH_PROB_JEWEL;
    nProbArcane = HIGH_PROB_ARCANE;
    nProbDivine = HIGH_PROB_DIVINE;
    nProbAmmo   = HIGH_PROB_AMMO ;
    nProbKit    = HIGH_PROB_KIT;
    nProbPotion = HIGH_PROB_POTION;
    nProbTable2 = HIGH_PROB_TABLE2;
   }


   for (i = 1; i <= nNumberItems; i++)
   {
     int nRandom = d100();
     if (nRandom <= nProbBook)
        CreateBook(oCreateOn);                                // * Book
     else if (nRandom <= nProbBook + nProbAnimal)
        CreateAnimalPart(oCreateOn);                          // * Animal
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk)
        CreateJunk(oCreateOn);                                // * Junk
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold)
        CreateGold(oCreateOn, oLastOpener, nTreasureType, nLvl);    // * Gold
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem)
        CreateGem(oCreateOn, oLastOpener, nTreasureType, nLvl);     // * Gem
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel)
        CreateJewel(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Jewel
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane)
        pa_CreateArcaneScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Arcane Scroll
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine)
        CreateDivineScroll(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Divine Scroll
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo)
        CreateAmmo(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Ammo
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit)
        CreateKit(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Healing, Trap, or Thief kit
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit + nProbPotion)
        CreatePotion(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Potion
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit + nProbPotion + nProbTable2)
        CreateTable2Item(oCreateOn, oLastOpener, nTreasureType, nLvl);   // * Weapons, Armor, Misc - Class based

   }
*/

  DeleteLocalInt(OBJECT_SELF,"KU_TREASURE_TYPE");
}


void GenerateLowTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_LOW, oLastOpener, oCreateOn);
}
void GenerateMediumTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_MEDIUM, oLastOpener, oCreateOn);
}
void GenerateHighTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_HIGH, oLastOpener, oCreateOn);
}

void GenerateUniqueTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_HIGH, oLastOpener, oCreateOn);
}

struct skincorpse
{
  int id;
  string sTag;
  string sPelt;
  string sMeat;
  string sMisc;
  int iDiff;
};

struct skincorpse ku_getPelt(string sResRef) {
  struct skincorpse corpse;

  string sSql = "SELECT id, param1, param2, param3, param4 FROM static_quests WHERE quest = 'stahovani' AND name = '"+sResRef+"';";
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    corpse.id = StringToInt(SQLGetData(1));
    corpse.sPelt = SQLGetData(2);
    corpse.iDiff = StringToInt(SQLGetData(3));
    corpse.sMeat = SQLGetData(4);
    corpse.sMisc = SQLGetData(5);
  }
  else {
    corpse.iDiff = -1;
  }

  return corpse;
}

//::///////////////////////////////////////////////
//:: GenerateNPCTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Preferrably called from OnSpawn scripts.
   Use the random treasure functions to generate
   appropriate treasure for the creature to drop.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 2002
//:://////////////////////////////////////////////

void GenerateNPCTreasure()
{
    object oTreasureGetter = OBJECT_SELF;

    string sResSelf = GetResRef(OBJECT_SELF);
    string sTagSelf = GetTag(OBJECT_SELF);
    int iRacialType = GetRacialType(OBJECT_SELF);
    string sGenericMeat = "01";
    SetLocalInt(OBJECT_SELF,"KU_TREASURE_TYPE",1);

    //by melvik, zjednoduseni :)
//    object oModule = GetModule();
    struct skincorpse corpse;
    corpse = ku_getPelt(sResSelf);
    if(corpse.iDiff < 0)
      corpse = ku_getPelt("tag" + sTagSelf);

    if(corpse.iDiff >= 0) {
        SetLocalString(oTreasureGetter,"sPelt", corpse.sPelt);
        SetLocalString(oTreasureGetter,"sMeat", corpse.sMeat);
        SetLocalString(oTreasureGetter,"sMisc", corpse.sMisc);
        SetLocalInt(oTreasureGetter,"iPenalty", corpse.iDiff);
    }
    

/*    string resRefItem = GetLocalString(oModule, "thTrofejMisc_" + sResSelf);
    if(resRefItem == "") resRefItem = GetLocalString(oModule, "thTrofejMisc_" + "tag" + sTagSelf);
    if(resRefItem != "")
    {
        SetLocalString(oTreasureGetter,"sPelt", resRefItem );
        SetLocalString(oTreasureGetter,"sMeat", GetLocalString(oModule, "thTrofejMeat_" + sResSelf));
        SetLocalInt(oTreasureGetter,"iPenalty", GetLocalInt(oModule, "thTrofejDiff_" + sResSelf));
    }*/


    // ZVIRATKA BEGIN

    int iBoss = GetLocalInt(OBJECT_SELF, "JA_BOSS_LOOT");
    if( (Random(100)+1) <= iBoss ) {    //it is boss
        CreateBossItems(OBJECT_SELF);
        // Here place boss loot spawn
//        ku_LootCreateBossUniqueLootItems(OBJECT_SELF);
    }

    if (GetObjectType(oTreasureGetter) == OBJECT_TYPE_CREATURE)
    {
        if (
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_BEAST) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_MAGICAL_BEAST) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_VERMIN) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_ANIMAL)
           )
        {
            return;
        }
    }

    int nTreasureValue = TREASURE_MEDIUM;

    int rand = Random(100);
    if( GetLocalInt(OBJECT_SELF, "AI_BOSS") ){
        rand = 0;
        nTreasureValue = TREASURE_HIGH;
    }

    if (rand < 20) //80% - no treasure
        GenerateTreasure(nTreasureValue, OBJECT_SELF, OBJECT_SELF);
}

// *
// * Theft Prevention
// *

//::///////////////////////////////////////////////
//:: ShoutDisturbed
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

// * Container shouts if disturbed
void ShoutDisturbed()
{
    object oAttacker;
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
        oAttacker = GetLastAttacker();
    }
    else if (GetIsOpen(OBJECT_SELF) == TRUE)
    {
        oAttacker = GetLastOpener();
    }

    if(!GetIsPC(oAttacker) || GetIsDM(oAttacker)) return;

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
      if (GetIsFriend(oTarget, OBJECT_SELF) == TRUE)
      {
         // * Make anyone who is a member of my faction hostile if I am violated
         SetIsTemporaryEnemy(oAttacker,oTarget,TRUE);
         AssignCommand(oTarget, DetermineCombatRound(oAttacker));
      }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }

}
///////////////////////////
//Dynamic boss loot spawn
////////////////////////////////////
void SetNextSpawn() {
  object oNPC = OBJECT_SELF;
//  SendMessageToPC(GetFirstPC(),"NPC death");

  if(!GetLocalInt(oNPC,"SPAWNED_BOSS_LOOT"))
    return;

//  SendMessageToPC(GetFirstPC(),"BOSS death");

  object oArea = GetArea(oNPC);
  int iSpawnDelay = GetLocalInt(oArea,"BOSS_RESPAWN_TIME");
  if(iSpawnDelay == 0) {
    iSpawnDelay = 6; // Default Six hours
  }
  iSpawnDelay = iSpawnDelay * 6; //Real time to In Game time

  int iNextSpawn = ku_GetTimeStamp(0,0,iSpawnDelay);

  if(iNextSpawn < GetLocalInt(oArea,"NEXT_BOSS_SPAWN_TIME")) {
  //OK time is already set
    return;
  }

//  iSpawnDelay = iSpawnDelay * 6; //Real time to In Game time
//  int iSpawnDelayMin = Random(iSpawnDelay*5);

  WriteTimestampedLogEntry("BOSS NextSpawn 'BOSS_LOOT' in '"+GetName(GetArea(oNPC))+"'. Next: in ("+IntToString(iNextSpawn)+")"+IntToString(iSpawnDelay)+"h 0min");

  SetLocalInt(oArea,"NEXT_BOSS_SPAWN_TIME",iNextSpawn);

  string sResRef = GetResRef(oArea);
  string sTag = GetTag(oArea);
  string sSQL = "UPDATE location_property SET boss_spawn_time = '"+IntToString(iNextSpawn)+"' WHERE resref = '"+sResRef+"' AND tag = '"+sTag+"' AND boss_spawn_time < "+IntToString(iNextSpawn)+"; ";
//  SendMessageToPC(GetFirstPC(),sSQL);
  SQLExecDirect(sSQL);

}



