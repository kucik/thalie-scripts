

#include "nwnx_funcs"
#include "nwnx_structs"
#include "sh_classes_const"
#include "sh_spells_inc"
/*
System pro dopocet poctu pouziti na den

*/



int __getGetFeatUsesPerDay(int iFeat, object oPC) {
    switch(iFeat) {
    // DD
    case FEAT_POSTOJ_TRPASLICI_OBRANCE1:
      return (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) - 1) /2 +1;
    // Sermir
    case FEAT_SERMIR_RYCHLY_BLESK:
      return (GetLevelByClass(CLASS_TYPE_SERMIR,oPC) -3) /5 +1;
    case 1621:                                                                  //Magovy dvere
    {
         int nCasterLvl = GetLevelByClass(CLASS_TYPE_WIZARD,oPC)+GetLevelByClass(CLASS_TYPE_SORCERER,oPC)+1;
         return  (nCasterLvl / 10) +1;
    }
    case 1647:                                                                  //Sermirske finty
    {
        int iCount = 3 + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        if (GetHasFeat(1649,oPC) == TRUE)//Vylepseny necestny boj 1
        {
          iCount += 1;
        }
        if (GetHasFeat(1650,oPC) == TRUE)//Vylepseny necestny boj 2
        {
            iCount += 1;
        }
        if (GetHasFeat(1651,oPC) == TRUE)//Vylepseny necestny boj 3
        {
            iCount += 1;
        }
        if (GetHasFeat(1662,oPC) == TRUE)//Extra finty 1
        {
            iCount += 3;
        }
        if (GetHasFeat(1663,oPC) == TRUE)//Extra finty 2
        {
            iCount += 3;
        }
        if (GetHasFeat(1664,oPC) == TRUE)//Extra finty 3
        {
            iCount += 3;
        }
        return  iCount;
    }
    //Paladin
    case FEAT_SMITE_EVIL:
    {
     int lvlPaladin = GetLevelByClass (CLASS_TYPE_PALADIN,oPC);
     int iCnt= 0;
     if (lvlPaladin > 0)
      iCnt = (lvlPaladin / 5) +1;
      return iCnt;
    }
  //Blackguard - heretik
  case FEAT_SMITE_GOOD:
   return GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) /5 + 1;

  case FEAT_INFLICT_SERIOUS_WOUNDS:
   return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) - 6) /6 +1;

  case FEAT_INFLICT_CRITICAL_WOUNDS:
   return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) - 9) /6 +1;

  case FEAT_BG_HARM:
   return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) -17) /6 +1;

  case FEAT_CONTAGION:
   return (GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) -7) /6 +1;

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
  __restoreFeatUsesPerDay(FEAT_SMITE_GOOD, oPC);
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
  __restoreFeatUsesPerDay(1621, oPC);
  __restoreFeatUsesPerDay(1647, oPC);
}


