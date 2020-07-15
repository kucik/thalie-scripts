

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
  //Blackguard - heretik


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
  __restoreFeatUsesPerDay(FEAT_POSTOJ_TRPASLICI_OBRANCE1, oPC);
  __restoreFeatUsesPerDay(FEAT_SERMIR_RYCHLY_BLESK, oPC);
  __restoreFeatUsesPerDay(1621, oPC);
  __restoreFeatUsesPerDay(1647, oPC);
}


