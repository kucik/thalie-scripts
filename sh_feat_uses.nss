

#include "nwnx_funcs"
#include "nwnx_structs"
#include "sh_classes_const"

/*
System pro dopocet poctu pouziti na den

*/



int __getGetFeatUsesPerDay(int iFeat, object oPC) {
  switch(iFeat) {
    // Paladin
    case FEAT_SMITE_EVIL: {
      int lvlPaladin = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
      int lvlTorm = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC);
      int iCnt = 0;
      if(lvlPaladin > 0)
        iCnt = ((lvlPaladin + 1) / 5) +1;
/*      if(lvlTorm > 5)
        iCnt = iCnt + ((lvltorm-3) / 5)+1;
*/
      return iCnt;
    }
    case FEAT_REMOVE_DISEASE:
      return (GetLevelByClass(CLASS_TYPE_PALADIN,oPC) - 2) /5 +1;
    // Paladin + Torm
    case FEAT_LAY_ON_HANDS: {
      int lvlPaladin = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
      int iCnt = 0;
      if(lvlPaladin > 0)
        iCnt = ((lvlPaladin + 1) / 10);
      int lvlTorm = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC);
      if(lvlTorm > 0) {
        iCnt = iCnt + (lvlTorm / 10) + 1;
      }
      return iCnt;
    }
    // Torm
    case FEAT_DIVINE_WRATH:
      return GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC) / 5;
    // DD
    case FEAT_POSTOJ_TRPASLICI_OBRANCE1:
      return (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) - 1) /2 +1;
    // PDK
    case FEAT_PDK_RALLY:
      return GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) / 5 + 1 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    case FEAT_PDK_SHIELD:
      return GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) / 5 + 1 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    case FEAT_PDK_FEAR:
      return (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) - 3) /5 +1;
    case FEAT_PDK_WRATH:
      return (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) - 7) /5 +1 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    case FEAT_PDK_INSPIRE_1:
      return (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) - 6) /5 +1 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    case FEAT_PDK_STAND:
      return (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC) - 9) /5 +1 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    // Blackguard
    case FEAT_SMITE_GOOD:
      return GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) /5 + 1;
    case FEAT_BULLS_STRENGTH:
      return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) - 2) /6 +1;
    case FEAT_INFLICT_SERIOUS_WOUNDS:
      return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) - 6) /6 +1;
    case FEAT_INFLICT_CRITICAL_WOUNDS:
      return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) - 9) /6 +1;
    case FEAT_BG_HARM:
      return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) -17) /6 +1;
    case FEAT_CONTAGION:
      return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) -7) /6 +1;
    // Arcane Archer
    case FEAT_PRESTIGE_IMBUE_ARROW:
      return GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC) /5 +1;
    case FEAT_PRESTIGE_SEEKER_ARROW_1:
      return GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC) /4;
    case FEAT_PRESTIGE_HAIL_OF_ARROWS:
      return (GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC) -7) /4 +1;
    case FEAT_PRESTIGE_ARROW_OF_DEATH: {
      int iCnt = (GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC) - 10) /5 +1;
      if(iCnt > 4)
        iCnt = 4;
      return iCnt;
    }
    // Shadowdancer
    case FEAT_SHADOW_EVADE:
      return GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) / 5 +1;
    case FEAT_SHADOW_DAZE:
      return (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) - 3) /4 +1;
    case FEAT_SD_TEMNOTA:
      return (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) -2) /4 +1;
    // Assassin
    case FEAT_PRESTIGE_DARKNESS:
      return (GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) - 4) /5 +1;
    case FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE:
      return (GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) - 2) /5 +1;
    case FEAT_PRESTIGE_INVISIBILITY_1:
      return (GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) - 6) /5 +1;
    case FEAT_PRESTIGE_INVISIBILITY_2:
      return (GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) - 8) /5 +1;
    case FEAT_ASSASSIN_ZNACKA_SMRTI:
      return GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) / 10 + 1;
    // Sermir
    case FEAT_SERMIR_RYCHLY_BLESK:
      return (GetLevelByClass(CLASS_TYPE_SERMIR,oPC) -3) /5 +1;
    // Samuraj
    case FEAT_SAMURAJ_KI_SILA:
      return GetLevelByClass(CLASS_TYPE_SAMURAJ,oPC) /5;
    case FEAT_SAMURAJ_PRESNY_UDER:
      return (GetLevelByClass(CLASS_TYPE_SAMURAJ,oPC) -3) /5 +1;
    // Exorcista
    case FEAT_EXORCISTA_OCHRANA_PRED_ZLEM:
      return (GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC) -1) /5 +1;
    case FEAT_EXORCISTA_NARUSENI_MAGIE:
      return (GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC) -3) /5 +1;
    case FEAT_EXORCISTA_ROZPTYL_MAGII:
      return (GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC) -4) /5 +1;
    case FEAT_EXORCISTA_SILNEJSI_ROZPTYL_MAGII:
      return (GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC) -7) /5 +1;
    case FEAT_EXORCISTA_PRAVDIVE_VIDENI:
      return (GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC) -11) /5 +1;
    // Shinobi
    case FEAT_SHINOBI_UTISUJICI_UTOK:
      return GetLevelByClass(CLASS_TYPE_SHINOBI,oPC) /5 +1;
    case FEAT_SHINOBI_SOVI_MOUDROST:
      return (GetLevelByClass(CLASS_TYPE_SHINOBI,oPC) -2) /6 +1;
    case FEAT_SHINOBI_NEVIDITELNOST:
      return (GetLevelByClass(CLASS_TYPE_SHINOBI,oPC) -6) /5 +1;
    case FEAT_SHINOBI_ZMATENI:
      return (GetLevelByClass(CLASS_TYPE_SHINOBI,oPC) -8) /5 +1;
    // Druid
//    case FEAT_ELEMENTAL_SHAPE:
//      return (GetLevelByClass(CLASS_TYPE_DRUID,oPC) -17) /2 +1;
    // Monk
//    case FEAT_WHOLENESS_OF_BODY:
//      return (GetLevelByClass(CLASS_TYPE_MONK,oPC) - 6) /10 +1;
//    case FEAT_QUIVERING_PALM:
//      return (GetLevelByClass(CLASS_TYPE_MONK,oPC) - 14) /8 +1;
//    case FEAT_EMPTY_BODY:
//      return (GetLevelByClass(CLASS_TYPE_MONK,oPC) - 17) /10 +2;
    // Kurtizana
    case FEAT_KURTIZANA_ODHALENY_ZIVUTEK:
      return (GetLevelByClass(CLASS_TYPE_KURTIZANA,oPC) -1) /2 +2;
    case FEAT_KURTIZANA_JAK_JSI_MI_TO_REKL:
      return (GetLevelByClass(CLASS_TYPE_KURTIZANA,oPC) -4) /4 +1;
  }
  return 0;
}

void __restoreFeatUsesPerDay(int iFeat, object oPC) {
  if(!GetHasFeat(iFeat, oPC))
    return;

  int iShouldHave = __getGetFeatUsesPerDay(iFeat, oPC);
  // If we have feat, we must have at least one use
  if(iShouldHave <=0 )
    iShouldHave = 1;

  int iHave = GetRemainingFeatUses(oPC, iFeat);
  int i;
  if(iShouldHave > iHave) {
    for(i = 0; i < iShouldHave - iHave; i++)
      IncrementRemainingFeatUses(oPC, iFeat);
  }
  if(iShouldHave < iHave) {
    for(i = 0; i < iHave - iShouldHave; i++)
      DecrementRemainingFeatUses(oPC, iFeat);
  }
}


void RestoreFeatUses(object oPC)
{
  __restoreFeatUsesPerDay(FEAT_SMITE_EVIL, oPC);
  __restoreFeatUsesPerDay(FEAT_REMOVE_DISEASE, oPC);
  __restoreFeatUsesPerDay(FEAT_LAY_ON_HANDS, oPC);
  __restoreFeatUsesPerDay(FEAT_DIVINE_WRATH, oPC);
  __restoreFeatUsesPerDay(FEAT_POSTOJ_TRPASLICI_OBRANCE1, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_RALLY, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_SHIELD, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_FEAR, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_WRATH, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_INSPIRE_1, oPC);
  __restoreFeatUsesPerDay(FEAT_PDK_STAND, oPC);
  __restoreFeatUsesPerDay(FEAT_SMITE_GOOD, oPC);
  __restoreFeatUsesPerDay(FEAT_BULLS_STRENGTH, oPC);
  __restoreFeatUsesPerDay(FEAT_INFLICT_SERIOUS_WOUNDS, oPC);
  __restoreFeatUsesPerDay(FEAT_INFLICT_CRITICAL_WOUNDS, oPC);
  __restoreFeatUsesPerDay(FEAT_BG_HARM, oPC);
  __restoreFeatUsesPerDay(FEAT_CONTAGION, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_IMBUE_ARROW, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_SEEKER_ARROW_1, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_HAIL_OF_ARROWS, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_ARROW_OF_DEATH, oPC);
  __restoreFeatUsesPerDay(FEAT_SHADOW_EVADE, oPC);
  __restoreFeatUsesPerDay(FEAT_SHADOW_DAZE, oPC);
  __restoreFeatUsesPerDay(FEAT_SD_TEMNOTA, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_DARKNESS, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_INVISIBILITY_1, oPC);
  __restoreFeatUsesPerDay(FEAT_PRESTIGE_INVISIBILITY_2, oPC);
  __restoreFeatUsesPerDay(FEAT_ASSASSIN_ZNACKA_SMRTI, oPC);
  __restoreFeatUsesPerDay(FEAT_SERMIR_RYCHLY_BLESK, oPC);
  __restoreFeatUsesPerDay(FEAT_SAMURAJ_KI_SILA, oPC);
  __restoreFeatUsesPerDay(FEAT_SAMURAJ_PRESNY_UDER, oPC);
  __restoreFeatUsesPerDay(FEAT_EXORCISTA_OCHRANA_PRED_ZLEM, oPC);
  __restoreFeatUsesPerDay(FEAT_EXORCISTA_NARUSENI_MAGIE, oPC);
  __restoreFeatUsesPerDay(FEAT_EXORCISTA_ROZPTYL_MAGII, oPC);
  __restoreFeatUsesPerDay(FEAT_EXORCISTA_SILNEJSI_ROZPTYL_MAGII, oPC);
  __restoreFeatUsesPerDay(FEAT_EXORCISTA_PRAVDIVE_VIDENI, oPC);
  __restoreFeatUsesPerDay(FEAT_SHINOBI_UTISUJICI_UTOK, oPC);
  __restoreFeatUsesPerDay(FEAT_SHINOBI_SOVI_MOUDROST, oPC);
  __restoreFeatUsesPerDay(FEAT_SHINOBI_NEVIDITELNOST, oPC);
  __restoreFeatUsesPerDay(FEAT_SHINOBI_ZMATENI, oPC);
//  __restoreFeatUsesPerDay(FEAT_ELEMENTAL_SHAPE, oPC);
//  __restoreFeatUsesPerDay(FEAT_WHOLENESS_OF_BODY, oPC);
//  __restoreFeatUsesPerDay(FEAT_QUIVERING_PALM, oPC);
//  __restoreFeatUsesPerDay(FEAT_EMPTY_BODY, oPC);
  __restoreFeatUsesPerDay(FEAT_KURTIZANA_ODHALENY_ZIVUTEK, oPC);
  __restoreFeatUsesPerDay(FEAT_KURTIZANA_JAK_JSI_MI_TO_REKL, oPC);
}


