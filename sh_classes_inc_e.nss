/*
Obsahuje pomocne metody ktere jsou jednoduche ale prilis dlouhe a
zneprehlednovali by hlavni include.
Dale obsahuje pomocne funkce
*/
#include "nwnx_funcs"
#include "nwnx_structs"
#include "sh_classes_const"
#include "me_soul_inc"

// Vraci o kolik se zvednou staty pri barbarove rage
int GetBarbarianAbilityBonus(object oPC)
{
    if (GetKnowsFeat(FEAT_LEGENDARNI_ZURIVOST3, oPC))
    {
        return 16;
    }
    if (GetKnowsFeat(FEAT_LEGENDARNI_ZURIVOST2, oPC))
    {
        return 14;
    }
    if (GetKnowsFeat(FEAT_LEGENDARNI_ZURIVOST1, oPC))
    {
        return 12;
    }
    if (GetKnowsFeat(FEAT_EPICKA_ZURIVOST, oPC))
    {
        return 10;
    }
    if (GetKnowsFeat(FEAT_MOCNA_ZURIVOST, oPC))
    {
        return 8;
    }
    if (GetKnowsFeat(FEAT_VETSI_ZURIVOST, oPC))
    {
        return 6;
    }
    return 4;

}


/*
Pro hodnoty 1 - 20 vrati pozadovane konstanty.
Jinak vraci 0.
*/
int GetDamageBonusByValue(int iValue)
{
    switch (iValue)
    {
        case 1: return DAMAGE_BONUS_1;
        case 2: return DAMAGE_BONUS_2;
        case 3: return DAMAGE_BONUS_3;
        case 4: return DAMAGE_BONUS_4;
        case 5: return DAMAGE_BONUS_5;
        case 6: return DAMAGE_BONUS_6;
        case 7: return DAMAGE_BONUS_7;
        case 8: return DAMAGE_BONUS_8;
        case 9: return DAMAGE_BONUS_9;
        case 10: return DAMAGE_BONUS_10;
        case 11: return DAMAGE_BONUS_11;
        case 12: return DAMAGE_BONUS_12;
        case 13: return DAMAGE_BONUS_13;
        case 14: return DAMAGE_BONUS_14;
        case 15: return DAMAGE_BONUS_15;
        case 16: return DAMAGE_BONUS_16;
        case 17: return DAMAGE_BONUS_17;
        case 18: return DAMAGE_BONUS_18;
        case 19: return DAMAGE_BONUS_19;
        case 20: return DAMAGE_BONUS_20;
        default: return 0;


    }
    return 0;
}



/*
Pro hodnoty 1 - 10 vrati IP_CONST_DAMAGEBONUS konstanty.
Jinak vraci 0.
*/
int GetIPDamageBonusByValue(int iValue)
{
    switch (iValue)
    {
        case 1: return IP_CONST_DAMAGEBONUS_1;
        case 2: return IP_CONST_DAMAGEBONUS_2;
        case 3: return IP_CONST_DAMAGEBONUS_3;
        case 4: return IP_CONST_DAMAGEBONUS_4;
        case 5: return IP_CONST_DAMAGEBONUS_5;
        case 6: return IP_CONST_DAMAGEBONUS_6;
        case 7: return IP_CONST_DAMAGEBONUS_7;
        case 8: return IP_CONST_DAMAGEBONUS_8;
        case 9: return IP_CONST_DAMAGEBONUS_9;
        case 10: return IP_CONST_DAMAGEBONUS_10;
        default: return 0;
    }
    return 0;
}





/*Vraci typ zbroje, pokud to neni zbroj tak 0*/
int GetItemACBase (object oItem) {
     if (!GetIsObjectValid(oItem))
         return 0;

     switch (GetBaseItemType(oItem)) {
         case BASE_ITEM_SMALLSHIELD: return 0;
         case BASE_ITEM_LARGESHIELD: return 0;
         case BASE_ITEM_TOWERSHIELD: return 0;
         case BASE_ITEM_ARMOR: break;
         default: return 0;
     }

    int nBaseAC = 0;

     switch (GetGoldPieceValue(oItem)) {
         case 5:    nBaseAC = 1; break;  // Padded
         case 10:   nBaseAC = 2; break;  // Leather
         case 15:   nBaseAC = 3; break;  // Studded Leather / Hide
         case 100:  nBaseAC = 4; break;  // Chain Shirt / Scale Mail
         case 150:  nBaseAC = 5; break;  // Chainmail / Breastplate
         case 200:  nBaseAC = 6; break;  // Splint Mail / Banded Mail
         case 600:  nBaseAC = 7; break;  // Half Plate
         case 1500: nBaseAC = 8; break;  // Full Plate
     }

     return nBaseAC;
 }

/*Vraci konstantu pro urceni bonusoveho divine dmge exorcisty*/
 int GetDamageBonusByLevelExorcista(int iLevel)
 {
    if (iLevel == 30)
    {
        return   DAMAGE_BONUS_2d10;
    }
    if (iLevel >= 25)
    {
        return   DAMAGE_BONUS_2d8;
    }
    if (iLevel >= 20)
    {
        return   DAMAGE_BONUS_1d12;
    }
    if (iLevel >= 15)
    {
        return   DAMAGE_BONUS_1d10;
    }
    if (iLevel >= 10)
    {
        return   DAMAGE_BONUS_1d8;
    }
    return DAMAGE_BONUS_1d6;

 }


int GetFavoredDamageByRangerLevel(int iRangerLevel)
{
    switch (iRangerLevel) {
         case  1: return 0;
         case  2: return 0;
         case  3: return 1;
         case  4: return 1;
         case  5: return 1;
         case  6: return 1;
         case  7: return 2;
         case  8: return 2;
         case  9: return 3;
         case 10: return 2;
         case 11: return 3;
         case 12: return 3;
         case 13: return 4;
         case 14: return 4;
         case 15: return 4;
         case 16: return 4;
         case 17: return 5;
         case 18: return 5;
         case 19: return 6;
         case 20: return 5;
         case 21: return 6;
         case 22: return 6;
         case 23: return 7;
         case 24: return 7;
         case 25: return 7;
         case 26: return 7;
         case 27: return 8;
         case 28: return 8;
         case 29: return 9;
         case 30: return 8;
         case 31: return 9;
         case 32: return 9;
         case 33: return 10;
         case 34: return 10;
         case 35: return 10;
         case 36: return 10;
         case 37: return 11;
         case 38: return 11;
         case 39: return 12;
         default: return 0;
     }
     return 0;
}
                            //EFFECT_AB_AC_DMG


int GetIPDamageReductionHPResistConstant(int iAmount)
{
    if (iAmount >= 50)
    {
        return IP_CONST_DAMAGERESIST_50;
    }
    else if (iAmount >= 45)
    {
        return IP_CONST_DAMAGERESIST_45;
    }
    else if (iAmount >= 40)
    {
        return IP_CONST_DAMAGERESIST_40;
    }
    else if (iAmount >= 35)
    {
        return IP_CONST_DAMAGERESIST_35;
    }
    else if (iAmount >= 30)
    {
        return IP_CONST_DAMAGERESIST_30;
    }
    else if (iAmount >= 25)
    {
        return IP_CONST_DAMAGERESIST_25;
    }
    else if (iAmount >= 20)
    {
        return IP_CONST_DAMAGERESIST_20;
    }
    else if (iAmount >= 15)
    {
        return IP_CONST_DAMAGERESIST_15;
    }
    else if (iAmount >= 10)
    {
        return IP_CONST_DAMAGERESIST_10;
    }
    else
    {
        return IP_CONST_DAMAGERESIST_5;
    }
    return IP_CONST_DAMAGERESIST_5;
}

int GetIPDamageVulnerabilityConstant(int iAmount)
{
    if (iAmount >= 100)
    {
        return IP_CONST_DAMAGEVULNERABILITY_100_PERCENT;
    }
    else if (iAmount >= 90)
    {
        return IP_CONST_DAMAGEVULNERABILITY_90_PERCENT;
    }
    else if (iAmount >= 75)
    {
        return IP_CONST_DAMAGEVULNERABILITY_75_PERCENT;
    }
    else if (iAmount >= 50)
    {
        return IP_CONST_DAMAGEVULNERABILITY_50_PERCENT;
    }
    else if (iAmount >= 25)
    {
        return IP_CONST_DAMAGEVULNERABILITY_25_PERCENT;
    }
    else if (iAmount >= 10)
    {
        return IP_CONST_DAMAGEVULNERABILITY_10_PERCENT;
    }
    else
    {
        return IP_CONST_DAMAGEVULNERABILITY_5_PERCENT;
    }
    return IP_CONST_DAMAGEVULNERABILITY_5_PERCENT;
}

int GetIPDamageImmunityConstant(int iAmount)
{
    if (iAmount >= 100)
    {
        return IP_CONST_DAMAGEIMMUNITY_100_PERCENT;
    }
    else if (iAmount >= 90)
    {
        return IP_CONST_DAMAGEIMMUNITY_90_PERCENT;
    }
    else if (iAmount >= 75)
    {
        return IP_CONST_DAMAGEIMMUNITY_75_PERCENT;
    }
    else if (iAmount >= 50)
    {
        return IP_CONST_DAMAGEIMMUNITY_50_PERCENT;
    }
    else if (iAmount >= 25)
    {
        return IP_CONST_DAMAGEIMMUNITY_25_PERCENT;
    }
    else if (iAmount >= 10)
    {
        return IP_CONST_DAMAGEIMMUNITY_10_PERCENT;
    }
    else
    {
        return IP_CONST_DAMAGEIMMUNITY_5_PERCENT;
    }
    return IP_CONST_DAMAGEIMMUNITY_5_PERCENT;
}

void ChangeDomain(object oTarget,int iNewDomain, int iIndex )
{
    int iOldDomain = GetClericDomain(oTarget, iIndex);
    int iFindFeat = StringToInt(Get2DAString("domains", "GrantedFeat", iOldDomain));
    int iNewFeat = StringToInt(Get2DAString("domains", "GrantedFeat", iNewDomain));
    SetClericDomain(oTarget, iIndex, iNewDomain);
    int iFeatIdx = 0;
    int iFeats = GetTotalKnownFeats(oTarget);
    while(iFeatIdx < iFeats)
    {
        if(GetKnownFeat(oTarget, iFeatIdx) == iFindFeat)
        {
            SetKnownFeat(oTarget, iFeatIdx, iNewFeat);
            break;
        }
        ++iFeatIdx;
    }

    int iHD = GetHitDice(oTarget);
    int iLevel = 1;

    while(iLevel <=iHD)
    {
        if(GetClassByLevel(oTarget, iLevel) == CLASS_TYPE_CLERIC)
        {
            break;
        }
        ++iLevel;
    }

    iFeatIdx = 0;
    iFeats = GetTotalKnownFeatsByLevel(oTarget, iLevel);

    while(iFeatIdx < iFeats)
    {
        if(GetKnownFeatByLevel(oTarget, iLevel, iFeatIdx) == iFindFeat)
        {
            SetKnownFeatByLevel(oTarget, iLevel, iFeatIdx, iNewFeat);
            break;
        }
        ++iFeatIdx;
    }

}

void RestoreCantripSpells(object oPC, int iClass) {

  if(GetLevelByClass(iClass, oPC) <= 0)
    return;

  int i;
  int iSlots = GetMaxSpellSlots(oPC, iClass, 0);
  for(i = 0; i< iSlots; i++) {
    struct MemorizedSpellSlot ms = GetMemorizedSpell(oPC, iClass, 0, i);

//    SendMessageToPC(oPC," Spell:"+IntToString(ms.id)+" ready:"+IntToString(ms.ready)+" meta:"+IntToString(ms.meta));
    ms.ready = 1;
    if(ms.id > 0)
      SetMemorizedSpell(oPC, iClass, 0, i, ms);
  }

}

void RestoreCantripsSlots(object oPC)
{
    SetRemainingSpellSlots(oPC,CLASS_TYPE_BARD,0,GetMaxSpellSlots(oPC,CLASS_TYPE_BARD,0));
    RestoreCantripSpells(oPC, CLASS_TYPE_CLERIC);
    RestoreCantripSpells(oPC, CLASS_TYPE_DRUID);
    SetRemainingSpellSlots(oPC,CLASS_TYPE_SORCERER,0,GetMaxSpellSlots(oPC,CLASS_TYPE_SORCERER,0));
    RestoreCantripSpells(oPC, CLASS_TYPE_WIZARD);

}

/*Funkce pro WM - supperior weapon focus
*/
int GetWeaponOfChoiceFeatForWeapon(int iWeapon)
{
    switch(iWeapon)
	    {
         case BASE_ITEM_SICKLE: return FEAT_WEAPON_OF_CHOICE_SICKLE;
         case BASE_ITEM_KAMA: return FEAT_WEAPON_OF_CHOICE_KAMA;
        	case BASE_ITEM_KUKRI: return FEAT_WEAPON_OF_CHOICE_KUKRI;
        	case BASE_ITEM_CLUB: return FEAT_WEAPON_OF_CHOICE_CLUB;
        	case BASE_ITEM_DAGGER: return FEAT_WEAPON_OF_CHOICE_DAGGER;
        	case BASE_ITEM_LIGHTMACE: return FEAT_WEAPON_OF_CHOICE_LIGHTMACE;
        	case BASE_ITEM_MORNINGSTAR: return FEAT_WEAPON_OF_CHOICE_MORNINGSTAR;
        	case BASE_ITEM_QUARTERSTAFF: return FEAT_WEAPON_OF_CHOICE_QUARTERSTAFF;
        	case BASE_ITEM_SHORTSPEAR: return FEAT_WEAPON_OF_CHOICE_SHORTSPEAR;
        	case BASE_ITEM_SHORTSWORD: return FEAT_WEAPON_OF_CHOICE_SHORTSWORD;
        	case BASE_ITEM_RAPIER: return FEAT_WEAPON_OF_CHOICE_RAPIER;
        	case BASE_ITEM_SCIMITAR: return FEAT_WEAPON_OF_CHOICE_SCIMITAR;
        	case BASE_ITEM_LONGSWORD: return FEAT_WEAPON_OF_CHOICE_LONGSWORD;
        	case BASE_ITEM_GREATSWORD: return FEAT_WEAPON_OF_CHOICE_GREATSWORD;
        	case BASE_ITEM_HANDAXE: return FEAT_WEAPON_OF_CHOICE_HANDAXE;
        	case BASE_ITEM_BATTLEAXE: return FEAT_WEAPON_OF_CHOICE_BATTLEAXE;
        	case BASE_ITEM_GREATAXE: return FEAT_WEAPON_OF_CHOICE_GREATAXE;
        	case BASE_ITEM_HALBERD: return FEAT_WEAPON_OF_CHOICE_HALBERD;
        	case BASE_ITEM_LIGHTHAMMER: return FEAT_WEAPON_OF_CHOICE_LIGHTHAMMER;
        	case BASE_ITEM_LIGHTFLAIL: return FEAT_WEAPON_OF_CHOICE_LIGHTFLAIL;
        	case BASE_ITEM_WARHAMMER: return FEAT_WEAPON_OF_CHOICE_WARHAMMER;
        	case BASE_ITEM_HEAVYFLAIL: return FEAT_WEAPON_OF_CHOICE_HEAVYFLAIL;
        	case BASE_ITEM_SCYTHE: return FEAT_WEAPON_OF_CHOICE_SCYTHE;
        	case BASE_ITEM_KATANA: return FEAT_WEAPON_OF_CHOICE_KATANA;
        	case BASE_ITEM_BASTARDSWORD: return FEAT_WEAPON_OF_CHOICE_BASTARDSWORD;
        	case BASE_ITEM_DIREMACE: return FEAT_WEAPON_OF_CHOICE_DIREMACE;
        	case BASE_ITEM_DOUBLEAXE: return FEAT_WEAPON_OF_CHOICE_DOUBLEAXE;
        	case BASE_ITEM_TWOBLADEDSWORD: return FEAT_WEAPON_OF_CHOICE_TWOBLADEDSWORD;
        	case BASE_ITEM_DWARVENWARAXE: return FEAT_WEAPON_OF_CHOICE_DWAXE;
        	case BASE_ITEM_WHIP: return FEAT_WEAPON_OF_CHOICE_WHIP;
        	case BASE_ITEM_TRIDENT: return FEAT_WEAPON_OF_CHOICE_TRIDENT;
         case 305: return 1180;
         case 202: return 1173;
         case 210: return 1174;
         case 300: return 1175;
         case 301: return 1176;
         case 302: return 1177;
         case 303: return 1178;
         case 304: return 1179;
         case 308: return 1181;
         case 309: return 1182;
         case 310: return 1183;
         case 317: return 1184;
         case 318: return 1185;
         case 319: return 1186;
         case 320: return 1187;
         case 321: return 1188;
         case 322: return 1189;
         case 323: return 1190;
         case 324: return 1191;
    }
    return -1; //chyba
}



