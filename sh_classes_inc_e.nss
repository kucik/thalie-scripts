/*
Obsahuje pomocne metody ktere jsou jednoduche ale prilis dlouhe a
zneprehlednovali by hlavni include.
Dale obsahuje pomocne funkce
*/
#include "nwnx_funcs"
#include "nwnx_structs"
#include "sh_classes_const"
#include "me_soul_inc"


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


int GetIsTwoHandedWeapon(object oPC, int iWeaponType)
{
    int iRace = GetRacialType(oPC);
    if ((iRace==RACIAL_TYPE_HALFLING) | (iRace==RACIAL_TYPE_GNOME))
    {
        switch (iWeaponType)
        {
            case BASE_ITEM_CLUB:
            case BASE_ITEM_MAGICSTAFF:
            case BASE_ITEM_MORNINGSTAR:
            case BASE_ITEM_BATTLEAXE:
            case BASE_ITEM_LIGHTFLAIL:
            case BASE_ITEM_LONGSWORD:
            case BASE_ITEM_RAPIER:
            case BASE_ITEM_SCIMITAR:
            case BASE_ITEM_SHORTBOW:
            case BASE_ITEM_WARHAMMER:
            case BASE_ITEM_BASTARDSWORD:
            case BASE_ITEM_DWARVENWARAXE:
            case BASE_ITEM_KATANA:
                return TRUE;


        }
    }
    else
    {
        switch (iWeaponType)
        {
            case BASE_ITEM_QUARTERSTAFF:
            case BASE_ITEM_SHORTSPEAR:
            case BASE_ITEM_GREATAXE:
            case BASE_ITEM_GREATSWORD:
            case BASE_ITEM_HALBERD:
            case BASE_ITEM_HEAVYFLAIL:
            case BASE_ITEM_TRIDENT:
            case BASE_ITEM_DIREMACE:
            case BASE_ITEM_DOUBLEAXE:
            case BASE_ITEM_SCYTHE:
            case BASE_ITEM_TWOBLADEDSWORD:
                return TRUE;

        }


    }
    return FALSE;


}


