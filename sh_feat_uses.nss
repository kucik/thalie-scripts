

#include "nwnx_funcs"
#include "nwnx_structs"
#include "sh_classes_const"

/*
System pro dopocet poctu pouziti na den

*/
void RestoreFeatUses(object oPC)
{

    int aktualne;
    int pocet;
    int feat;
    // Smite Evil    - PALADIN, TORM
    if (GetHasFeat(FEAT_SMITE_EVIL,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,FEAT_SMITE_EVIL);
        int pocet = 0;
        int lvlpaladin =  GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
        int lvltorm =  GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC);
        if (lvlpaladin > 0)
        {
            pocet = ((lvlpaladin+1) / 5) +1;
        }
        if (lvltorm > 0)
        {
            pocet = ((lvltorm-3) / 5)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,FEAT_SMITE_EVIL);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,FEAT_SMITE_EVIL);
        aktualne = GetRemainingFeatUses(oPC,FEAT_SMITE_EVIL);
        }

    }
//-------------------------

 // Odstran chorobu - PALADIN
    feat = FEAT_REMOVE_DISEASE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvlpaladin =  GetLevelByClass(CLASS_TYPE_PALADIN,oPC);

        if (lvlpaladin > 0)
        {
            pocet = ((lvlpaladin-2) / 5)+1;
        }


        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


    // Lay on hands - PALADIN
    feat = FEAT_LAY_ON_HANDS;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvlpaladin =  GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
        int lvltorm =  GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC);
        if (lvlpaladin > 0)
        {
           pocet = 1;
           if (lvlpaladin >= 19) pocet = 2;
           if (lvlpaladin >= 29) pocet = 3;
           if (lvlpaladin >= 39) pocet = 4;


        }
        if (lvltorm > 0)
        {
            pocet = (lvltorm / 10)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

    // Divine wrath
    feat = FEAT_DIVINE_WRATH;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5);
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


    // Postoj trpasliciho obrance
    feat = FEAT_POSTOJ_TRPASLICI_OBRANCE1;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvldd =  GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER,oPC);
        if (lvldd > 0)
        {
            pocet = ((lvldd-1) / 2)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// PDK - RALLYING CRY
    feat = FEAT_PDK_RALLY;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5)+1;
        }
        pocet = pocet + GetAbilityModifier(ABILITY_CHARISMA,oPC);
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// PDK - HEORIC SHIEDL
    feat = FEAT_PDK_SHIELD;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5)+1;
        }
        pocet = pocet + GetAbilityModifier(ABILITY_CHARISMA,oPC);
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// PDK - FEAR
    feat = FEAT_PDK_FEAR;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-3) / 5)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

    // PDK - oath of wrath
    feat = FEAT_PDK_WRATH;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-7) / 5)+1;
        }
        pocet = pocet + GetAbilityModifier(ABILITY_CHARISMA,oPC);
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

    // PDK - inspire courage
    feat = FEAT_PDK_INSPIRE_1;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-6) / 5)+1;
        }
        pocet = pocet + GetAbilityModifier(ABILITY_CHARISMA,oPC);
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

    // PDK - final stand
    feat = FEAT_PDK_STAND;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-9) / 5)+1;
        }
        pocet = pocet + GetAbilityModifier(ABILITY_CHARISMA,oPC);
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// BG - SMITE GOOD
    feat = FEAT_SMITE_GOOD;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5)+1;
        }
        //SendMessageToPC(oPC,IntToString(aktualne)+ " "+IntToString(pocet) + " "+IntToString(lvl));
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// BG - byci sila
    feat = FEAT_BULLS_STRENGTH;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-2) / 6)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// BG - zposob vazna zraneni
    feat = FEAT_INFLICT_SERIOUS_WOUNDS;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-6) / 6)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// BG - zposob kriticka zraneni
    feat = FEAT_INFLICT_CRITICAL_WOUNDS;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-9) / 6)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// BG - HARM - nove
    feat = FEAT_BG_HARM;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-17) / 6)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// BG - contaigon
    feat = FEAT_CONTAGION;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-7) / 6)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// AA - imbue arrow
    feat = FEAT_PRESTIGE_IMBUE_ARROW;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// AA - seeker arrow
    feat = FEAT_PRESTIGE_SEEKER_ARROW_1;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 4);
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// AA - hail of arrows
    feat = FEAT_PRESTIGE_HAIL_OF_ARROWS;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-7) / 4)+1;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// AA - arrow of death
    feat = FEAT_PRESTIGE_ARROW_OF_DEATH;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-10) / 5)+1;
            if (pocet >=4) pocet = 4;
        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// SD - Shadow Evade
    feat = FEAT_SHADOW_EVADE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// SD - Shadow DAZE
    feat = FEAT_SHADOW_DAZE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-3) / 4)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// SD - TEMNOTA
    feat = FEAT_SD_TEMNOTA;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-2) / 4)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// ASSASSIN - TEMNOTA FEAT_PRESTIGE_DARKNESS
    feat = FEAT_PRESTIGE_DARKNESS;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-4) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// ASSASSIN - VZHLED DUCHA
    feat = FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-2) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// ASSASSIN - NEVIDITELNOST
    feat = FEAT_PRESTIGE_INVISIBILITY_1;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-6) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// ASSASSIN - VYLEPSENA NEVIDITELNOST
    feat = FEAT_PRESTIGE_INVISIBILITY_2;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-8) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// ASSASSIN - ZNACKA SMRTI
    feat = FEAT_ASSASSIN_ZNACKA_SMRTI;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl) / 10)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }

// Sermir - rychly jako blesk
    feat = FEAT_SERMIR_RYCHLY_BLESK;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SERMIR,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-3) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Samuraj - ki sila
    feat = FEAT_SAMURAJ_KI_SILA;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SAMURAJ,oPC);
        if (lvl > 0)
        {
            pocet = (lvl / 5);

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Samuraj - presny uder
    feat = FEAT_SAMURAJ_PRESNY_UDER;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SAMURAJ,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-3) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Exorcista - ochrana pred zlem
    feat = FEAT_EXORCISTA_OCHRANA_PRED_ZLEM;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-1) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Exorcista - naruseni magie
    feat = FEAT_EXORCISTA_NARUSENI_MAGIE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-3) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Exorcista - rozptyl magii
    feat = FEAT_EXORCISTA_ROZPTYL_MAGII;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-4) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// Exorcista - rozptyl magii silnejsi
    feat = FEAT_EXORCISTA_SILNEJSI_ROZPTYL_MAGII;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-7) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// Exorcista - prave videni
    feat = FEAT_EXORCISTA_PRAVDIVE_VIDENI;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-11) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// Shinobi FEAT_SHINOBI_UTISUJICI_UTOK
    feat = FEAT_SHINOBI_UTISUJICI_UTOK;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHINOBI,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------


// FEAT_SHINOBI_SOVI_MOUDROST
    feat = FEAT_SHINOBI_SOVI_MOUDROST;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHINOBI,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-2) / 6)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// FEAT_SHINOBI_NEVIDITELNOST
    feat = FEAT_SHINOBI_NEVIDITELNOST;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHINOBI,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// FEAT_SHINOBI_ZMATENI
    feat = FEAT_SHINOBI_ZMATENI;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_SHINOBI,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-8) / 5)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------



// druid - elemental shape
    feat = FEAT_ELEMENTAL_SHAPE;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_DRUID,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-17) / 2)+1;

        }

        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }
//-------------------------

// monk wholeness
feat = FEAT_WHOLENESS_OF_BODY;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_MONK,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-6) / 10)+1;

        }
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }


//-------------------------

// monk dlan
    feat = FEAT_QUIVERING_PALM;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_MONK,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-14) / 8)+1;

        }
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }


//-------------------------

// monk cistota tela
    feat = FEAT_QUIVERING_PALM;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_MONK,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-17) / 10)+2;

        }
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }


//-------------------------

// kurtizana - zivutek
    feat = FEAT_KURTIZANA_ODHALENY_ZIVUTEK;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_KURTIZANA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-1) / 2)+2;

        }
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }


//-------------------------

//kurtizana - jak jsi mi to rekl
    feat = FEAT_KURTIZANA_JAK_JSI_MI_TO_REKL;
    if (GetHasFeat(feat,oPC))
    {
        aktualne = GetRemainingFeatUses(oPC,feat);
        int pocet = 0;
        int lvl =  GetLevelByClass(CLASS_TYPE_KURTIZANA,oPC);
        if (lvl > 0)
        {
            pocet = ((lvl-4) /4)+1;

        }
        while (aktualne!=pocet)
        {
        if (aktualne > pocet) DecrementRemainingFeatUses(oPC,feat);
        if (aktualne < pocet) IncrementRemainingFeatUses(oPC,feat);
        aktualne = GetRemainingFeatUses(oPC,feat);
        }

    }


//-------------------------
}


