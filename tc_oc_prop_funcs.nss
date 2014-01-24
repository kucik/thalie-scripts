// This function adds property specified by type and its power iPower to oItem
// oItem - Item to which have to be property added
// iType  - Effect type
// iPower - Power of stone 0 - 10 (10 = 200%)
// bAllowOverPOwer - If this is set TRUE, iPower can be more than 10. Do not use this in player craft.
//
// Return: TRUE  - Property succesfully added
//         FALSE - iPower is too low and property is not applied
//         -1    - This type cannot be applied on this item.
int tc_EnchantmentAddEnchantment(object oItem, int iType, int iPower);

const int TC_OC_TOTALENCHANT_TYPES = 56;

int tc_EnchantmentPowerToDamageBonus(int iPower);
int tc_EnchantmentPowerToOnHitDC(int iPower);
int tc_oc_GetWeaponDmgType(int iType);
int tc_EnchantmentPowerToweightReduction(int iPower);
int tc_oc_GetIsSlashing(object oItem);
int tc_CanHaveEnhancenmentBonus(object oItem);

int tc_EnchantmentAddEnchantment(object oItem, int iType, int iPower){

  if( (iType < 1) || (iType > TC_OC_TOTALENCHANT_TYPES)) {
    return -1;
  }
  if( iPower < 1) {
    return -1;
  }


  int iSubtype = -1;
  int iDC = -1;
  int iDmgType = -1;
  int iEnhance = -1;
  int iLevel = -1;

  switch(iType) {
    /////////////////////////
    // Elemental damage bonus
    case 1: if(iSubtype < 0)  {iSubtype = IP_CONST_DAMAGETYPE_ACID; }
    case 2: if(iSubtype < 0)  {iSubtype = IP_CONST_DAMAGETYPE_ELECTRICAL; }
    case 3: if(iSubtype < 0)  {iSubtype = IP_CONST_DAMAGETYPE_FIRE; }
    case 4: if(iSubtype < 0)  {iSubtype = IP_CONST_DAMAGETYPE_COLD; }
    case 5: if(iSubtype < 0)  {iSubtype = IP_CONST_DAMAGETYPE_SONIC;
                               iPower--;}
      if(iPower > 0) {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(iSubtype,tc_EnchantmentPowerToDamageBonus(iPower)),oItem);
        return TRUE;
      }
      break;
    /////////////////////////
    // Keen
    case 6:
      if(iPower > 4 && tc_oc_GetIsSlashing(oItem)) {
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),oItem);
        return TRUE;
      }
      return FALSE;
      break;
   //////////////////////////
   //OnhitProperties
   case  7: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_HOLD; }
   case  8: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_DEAFNESS; }
   case  9: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_DAZE; }
   case 10: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_SILENCE; }
   case 11: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_FEAR; }
     iDC = tc_EnchantmentPowerToOnHitDC(iPower);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(iSubtype,iDC,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),oItem);
     return TRUE;
     break;
   //////////////////////////
   // Against race
   case 12: {if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_UNDEAD; }}
   case 13: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_GIANT; }
   case 14: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_DRAGON; }
   case 15: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_ORC; }
   case 16: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN; }
   case 17: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_ANIMAL; }
   case 18: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_VERMIN; }
   case 19: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID; }
   case 20: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_ABERRATION ;}
   case 21: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_SHAPECHANGER ;}
     iDmgType = tc_oc_GetWeaponDmgType(GetBaseItemType(oItem));
     iEnhance = (iPower + 4) /2;
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(iSubtype,iDmgType,tc_EnchantmentPowerToDamageBonus(iPower + 1)),oItem);
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(iSubtype,iEnhance),oItem);
     return TRUE;
     break;
   //////////////////////////
   // Slay race
   case 22: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_UNDEAD; }
   case 23: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_GIANT; }
   case 24: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_DRAGON; }
   case 25: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_ORC; }
   case 26: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN; }
   case 27: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_ANIMAL; }
   case 28: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_VERMIN; }
   case 29: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID; }
   case 30: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_ABERRATION; }
   case 31: if(iSubtype < 0)  {iSubtype = IP_CONST_RACIALTYPE_SHAPECHANGER; }
     iDC = tc_EnchantmentPowerToOnHitDC(iPower -2);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,iDC,iSubtype),oItem);
     return TRUE;
   //////////////////////////
   // Bonus vs. alignemnt
   case 32: if(iSubtype < 0)  {iSubtype = IP_CONST_ALIGNMENTGROUP_EVIL; }
   case 33: if(iSubtype < 0)  {iSubtype = IP_CONST_ALIGNMENTGROUP_GOOD; }
   case 34: if(iSubtype < 0)  {iSubtype = IP_CONST_ALIGNMENTGROUP_LAWFUL; }
   case 35: if(iSubtype < 0)  {iSubtype = IP_CONST_ALIGNMENTGROUP_CHAOTIC; }
     iDmgType = tc_oc_GetWeaponDmgType(GetBaseItemType(oItem));
     iEnhance = (iPower + 3) /2;
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(iSubtype,iDmgType,tc_EnchantmentPowerToDamageBonus(iPower)),oItem);
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(iSubtype,iEnhance),oItem);
     return TRUE;
   //////////////////////////
   // Vampiric regeneration
   case 36:
     if(iPower > 4) {
       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(iPower-4),oItem);
       return TRUE;
     }
     else {
       return FALSE;
     }
   /////////////////////////
   // Fireball
   case 37: return FALSE;
   /////////////////////////
   // Onhitproperties
   case 38: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_WOUNDING; }
   case 39: if(iSubtype < 0)  {iSubtype = IP_CONST_ONHIT_LESSERDISPEL; }
     iDC = tc_EnchantmentPowerToOnHitDC(iPower);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(iSubtype,iDC),oItem);
     return TRUE;
   /////////////////////////
   // Poisons
   case 40: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_STRDAMAGE; }
   case 41: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_INTDAMAGE; }
   case 42: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_WISDAMAGE; }
   case 43: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_CHADAMAGE; }
   case 44: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_DEXDAMAGE; }
   case 45: if(iSubtype < 0)  {iSubtype = IP_CONST_POISON_1D2_CONDAMAGE; }
     iDC = tc_EnchantmentPowerToOnHitDC(iPower);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,iDC,iSubtype),oItem);
     return TRUE;
   /////////////////////////
   // Level drain
   case 46:
     iDC = tc_EnchantmentPowerToOnHitDC(iPower-1);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN,iDC),oItem);
     return TRUE;
   //////////////////////////
   // Ability drain
   case 47: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_STR; }
   case 48: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_INT; }
   case 49: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_WIS; }
   case 50: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_CHA; }
   case 51: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_DEX; }
   case 52: if(iSubtype < 0)  {iSubtype = IP_CONST_ABILITY_CON; }
     iDC = tc_EnchantmentPowerToOnHitDC(iPower+1);
     if(iDC < 0) {
       return FALSE;
     }
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,iDC,iSubtype),oItem);
     return TRUE;
   ///////////////////////////
   // weight reduction
   case 53:
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(tc_EnchantmentPowerToweightReduction(iPower)),oItem);
      return TRUE;
    //////////////////////////
    // Enhancenment
    case 54:
      if(tc_CanHaveEnhancenmentBonus(oItem) == FALSE) {
        return FALSE;
      }
      iEnhance = (iPower - 4) /2;
      if(iEnhance <=0) {
        return FALSE;
      }
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(iEnhance),oItem);
      return TRUE;
    /////////////////////////
    // Vorpal
    case 55:
      iDC = tc_EnchantmentPowerToOnHitDC(iPower - 5);
      if(iDC < 0) {
       return FALSE;
      }
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL,iDC),oItem);
      return TRUE;
    //////////////////////////
    // Freeze
    case 56:
      iLevel = 2 * (iPower - 3);
      if(iLevel < 1)
        return FALSE;
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_FREEZE,iLevel),oItem);
      return TRUE;
   default: return FALSE;
  }


  return FALSE;
}

/*
int IP_CONST_DAMAGEBONUS_1                      = 1;
int IP_CONST_DAMAGEBONUS_2                      = 2;
int IP_CONST_DAMAGEBONUS_3                      = 3;
int IP_CONST_DAMAGEBONUS_4                      = 4;
int IP_CONST_DAMAGEBONUS_5                      = 5;
int IP_CONST_DAMAGEBONUS_1d4                    = 6;
int IP_CONST_DAMAGEBONUS_1d6                    = 7;
int IP_CONST_DAMAGEBONUS_1d8                    = 8;
int IP_CONST_DAMAGEBONUS_1d10                   = 9;
int IP_CONST_DAMAGEBONUS_2d6                    = 10;
int IP_CONST_DAMAGEBONUS_2d8                = 11;
int IP_CONST_DAMAGEBONUS_2d4                = 12;
int IP_CONST_DAMAGEBONUS_2d10               = 13;
int IP_CONST_DAMAGEBONUS_1d12               = 14;
int IP_CONST_DAMAGEBONUS_2d12               = 15;
int IP_CONST_DAMAGEBONUS_6                  = 16;
int IP_CONST_DAMAGEBONUS_7                  = 17;
int IP_CONST_DAMAGEBONUS_8                  = 18;
int IP_CONST_DAMAGEBONUS_9                  = 19;
int IP_CONST_DAMAGEBONUS_10                 = 20;*/
int tc_EnchantmentPowerToDamageBonus(int iPower) {

  switch(iPower) {
    case 1: return IP_CONST_DAMAGEBONUS_1;
    case 2: return IP_CONST_DAMAGEBONUS_1;
    case 3: return IP_CONST_DAMAGEBONUS_2;
    case 4: return IP_CONST_DAMAGEBONUS_1d4;
    case 5: return IP_CONST_DAMAGEBONUS_3;
    case 6: return IP_CONST_DAMAGEBONUS_1d6;
    case 7: return IP_CONST_DAMAGEBONUS_1d8;
    case 8: return IP_CONST_DAMAGEBONUS_2d4;
    case 9: return IP_CONST_DAMAGEBONUS_2d6;
    case 10: return IP_CONST_DAMAGEBONUS_2d8;
    //overpowered for loot
    case 11: return IP_CONST_DAMAGEBONUS_2d10;
    case 12: return IP_CONST_DAMAGEBONUS_2d12;
    case 13:
    case 14:
    case 15:
    case 16: return IP_CONST_DAMAGEBONUS_2d12;
  }
  return 0;
}

/*
int IP_CONST_ONHIT_SAVEDC_14                    = 0;
int IP_CONST_ONHIT_SAVEDC_16                    = 1;
int IP_CONST_ONHIT_SAVEDC_18                    = 2;
int IP_CONST_ONHIT_SAVEDC_20                    = 3;
int IP_CONST_ONHIT_SAVEDC_22                    = 4;
int IP_CONST_ONHIT_SAVEDC_24                    = 5;
int IP_CONST_ONHIT_SAVEDC_26                    = 6;*/
int tc_EnchantmentPowerToOnHitDC(int iPower) {

  int iDC = iPower - 5;
  if(iDC > 6) {
    iDC = 6;
  }
  return iDC;
}

int tc_oc_GetWeaponDmgType(int iType) {
  switch(iType) {
    case BASE_ITEM_ARROW:
    case BASE_ITEM_BOLT:
      return IP_CONST_DAMAGETYPE_PIERCING;
    case BASE_ITEM_BULLET:
      return IP_CONST_DAMAGETYPE_BLUDGEONING;
    default: break;
  }

  int iret = StringToInt(Get2DAString("baseitems","WeaponType",iType));
//  SendMessageToPC(GetFirstPC(),"Baseitem "+IntToString(iType)+" ("+Get2DAString("baseitems","label",iType)+") has dmg_type="+IntToString(iret));
  /* 1 = piercing; 2 = bludgeoning; 3 = slashing; 4 = piercing-slashing; 5 = bludgeoning-piercing. */
  switch(iret) {
    case 4:
    case 5:
    case 1: return IP_CONST_DAMAGETYPE_PIERCING;
    case 2: return IP_CONST_DAMAGETYPE_BLUDGEONING;
    case 3: return IP_CONST_DAMAGETYPE_SLASHING;
    default: return -1;
  }

  return -1;
}

int tc_oc_GetIsSlashing(object oItem) {
  int iret = StringToInt(Get2DAString("baseitems","WeaponType",GetBaseItemType(oItem)));

  /* 1 = piercing; 2 = bludgeoning; 3 = slashing; 4 = piercing-slashing; 5 = bludgeoning-piercing. */
  switch(iret) {
    case 1:
    case 4:
    case 3: return TRUE;
    default: return FALSE;
  }
  return FALSE;

}

/*
int IP_CONST_REDUCEDWEIGHT_80_PERCENT                   = 1;
int IP_CONST_REDUCEDWEIGHT_60_PERCENT                   = 2;
int IP_CONST_REDUCEDWEIGHT_40_PERCENT                   = 3;
int IP_CONST_REDUCEDWEIGHT_20_PERCENT                   = 4;
int IP_CONST_REDUCEDWEIGHT_10_PERCENT                   = 5;
*/
int tc_EnchantmentPowerToweightReduction(int iPower) {

  int iRed = iPower;
  if(iRed > 5)
    return 5;

  if(iRed < 1)
    return 1;

  return iRed;
}

int tc_CanHaveEnhancenmentBonus(object oItem) {

   switch(GetBaseItemType(oItem)) {
    case BASE_ITEM_ARROW:
    case BASE_ITEM_BOLT:
    case BASE_ITEM_BULLET:
    case BASE_ITEM_GLOVES:
      return FALSE;
    default: break;
  }

  return TRUE;
}

