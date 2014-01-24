/*
 * tc_si_prop_funcs script
 * Functions for addition propertis to items on taylor Thalie craft
 * Created kucik 14. 05. 2010
 *
 * Changelog:
 * 2010. 05. 15 Changed acid on cloths
 *              Added bAllowOverPOwer paramenter for loot and DMs.
 *              Added save vs. negative to Safir
 *              Added save vs. sonic to alexandrit
 *              Fixed skill power
 *              Fixed UMD skill
 *              Fixed bracer AC
 *              Fixed damage reduction
 *
 * 2010. 10. 01 Cloak - changed piercing AC -> complet AC
 *
 *
 */

// This function adds property specified by stone iStone and its power iPower to oItem
// oItem - Item to which have to be property added
// iStone - Stone identification 1 - 15
// iPower - Power of stone 0 - 10 (10 = 200%)
// bAllowOverPOwer - If this is set TRUE, iPower can be more than 10. Do not use this in player craft.
//
// Return: TRUE  - Property succesfully added
//         FALSE - iPower is too low and property is not applied
//         -1    - This iStone cannot be added on this item (for example Granat cannot be on Gloves)
int tc_si_AddPropertyForStone(object oItem, int iStone, int iPower, int bAllowOverPOwer = FALSE);


//////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/* *******************************************************
 *
 *
 * Here define functions to add correct itemproperties
 *
 *
 * ********************************************************
 */


/* skills */

int ku_si_AddItemProperty_SkillBonus(object oItem, int iSkill, int iPower) {

  /* Reduced skills */
  switch(iSkill) {
    case SKILL_HIDE:
    case SKILL_MOVE_SILENTLY:
    case SKILL_SET_TRAP:
    case SKILL_DISABLE_TRAP:
    case SKILL_PICK_POCKET:
    case SKILL_OPEN_LOCK:
    case SKILL_ANIMAL_EMPATHY:

    case SKILL_USE_MAGIC_DEVICE:
      iPower = iPower/2;
      break;
    default:
      iPower = iPower;
      break;
  }

  if(iPower > 0) {
    itemproperty ip = ItemPropertySkillBonus(iSkill,iPower);
    AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);

    /* Add class limitation for UMD */
    if(iSkill == SKILL_USE_MAGIC_DEVICE) {
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLimitUseByClass(IP_CONST_CLASS_BARD),oItem);
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyLimitUseByClass(IP_CONST_CLASS_ROGUE),oItem);
    }
    return TRUE;
  }
  return FALSE;
}

/* Light */
int ku_si_AddItemProperty_Light(object oItem, int iPower, int iColor) {

  itemproperty ip = ItemPropertyLight(iPower,iColor);
  AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
  return TRUE;
}

/* resistances */
/*
int IP_CONST_DAMAGERESIST_5                     = 1;
int IP_CONST_DAMAGERESIST_10                    = 2;
int IP_CONST_DAMAGERESIST_15                    = 3;
int IP_CONST_DAMAGERESIST_20                    = 4;
int IP_CONST_DAMAGERESIST_25                    = 5;
int IP_CONST_DAMAGERESIST_30                    = 6;
int IP_CONST_DAMAGERESIST_35                    = 7;
int IP_CONST_DAMAGERESIST_40                    = 8;
int IP_CONST_DAMAGERESIST_45                    = 9;
int IP_CONST_DAMAGERESIST_50                    = 10;
*/
int ku_si_AddItemProperty_ElementReduction(object oItem, int iPower, int iElement) {

  iPower = (iPower/2) - 1; //max 20 (=4)

  //  + 5 resistance on cloths
  if( GetBaseItemType(oItem) == BASE_ITEM_ARMOR) {
    iPower++;
  }

  if(iPower > 0) {
    itemproperty ip = ItemPropertyDamageResistance(iElement,iPower);
    AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
    return TRUE;
  }
  return FALSE;
}

/* AC BONUS */
int ku_si_AddItemProperty_AC(object oItem, int iPower) {

  itemproperty ip;
  switch(GetBaseItemType(oItem)) {
    case BASE_ITEM_HELMET:
      ip = ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_BLUDGEONING,iPower/2);
      break;
    case BASE_ITEM_BELT:
      ip = ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_SLASHING,iPower/2);
      break;
//  Cloak has no longer only AC vs. piercing but againts everything
//    case BASE_ITEM_CLOAK:
//      ip = ItemPropertyACBonusVsDmgType(IP_CONST_DAMAGETYPE_PIERCING,iPower/2);
//      break;
    case BASE_ITEM_BRACER:
      ip = ItemPropertyACBonus((iPower/2) + 1);
      break;
    default:
      ip = ItemPropertyACBonus(iPower/2);
      break;
  }
  AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
  return TRUE;
}


/* Spell resistance */
/*
int IP_CONST_SPELLRESISTANCEBONUS_10                    = 0;
int IP_CONST_SPELLRESISTANCEBONUS_12                    = 1;
int IP_CONST_SPELLRESISTANCEBONUS_14                    = 2;
int IP_CONST_SPELLRESISTANCEBONUS_16                    = 3;
int IP_CONST_SPELLRESISTANCEBONUS_18                    = 4;
int IP_CONST_SPELLRESISTANCEBONUS_20                    = 5;
int IP_CONST_SPELLRESISTANCEBONUS_22                    = 6;
int IP_CONST_SPELLRESISTANCEBONUS_24                    = 7;
int IP_CONST_SPELLRESISTANCEBONUS_26                    = 8;
int IP_CONST_SPELLRESISTANCEBONUS_28                    = 9;
int IP_CONST_SPELLRESISTANCEBONUS_30                    = 10;
int IP_CONST_SPELLRESISTANCEBONUS_32                    = 11;
*/

int ku_si_AddItemProperty_SR(object oItem, int iPower) {

 iPower = iPower - 3 ;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSpellResistance(iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

/*
 * Damage reducion */
/*
int IP_CONST_DAMAGEREDUCTION_1                  = 0;
int IP_CONST_DAMAGEREDUCTION_2                  = 1;
int IP_CONST_DAMAGEREDUCTION_3                  = 2;
int IP_CONST_DAMAGEREDUCTION_4                  = 3;
int IP_CONST_DAMAGEREDUCTION_5                  = 4;
int IP_CONST_DAMAGEREDUCTION_6                  = 5;
int IP_CONST_DAMAGEREDUCTION_7                  = 6;
int IP_CONST_DAMAGEREDUCTION_8                  = 7;
int IP_CONST_DAMAGEREDUCTION_9                  = 8;
int IP_CONST_DAMAGEREDUCTION_10                 = 9;
int IP_CONST_DAMAGEREDUCTION_11                 = 10;
int IP_CONST_DAMAGEREDUCTION_12                 = 11;
int IP_CONST_DAMAGEREDUCTION_13                 = 12;
int IP_CONST_DAMAGEREDUCTION_14                 = 13;
int IP_CONST_DAMAGEREDUCTION_15                 = 14;
int IP_CONST_DAMAGEREDUCTION_16                 = 15;
int IP_CONST_DAMAGEREDUCTION_17                 = 16;
int IP_CONST_DAMAGEREDUCTION_18                 = 17;
int IP_CONST_DAMAGEREDUCTION_19                 = 18;
int IP_CONST_DAMAGEREDUCTION_20                 = 19;
*/
int ku_si_AddItemProperty_DmgReduction(object oItem, int iPower) {

 switch(GetBaseItemType(oItem)) {
   case BASE_ITEM_HELMET:
   case BASE_ITEM_GLOVES:
   case BASE_ITEM_BRACER:
     iPower = (iPower / 2) - 1;
     if(iPower < 0) {
       iPower = 0;
     }
     break;
   default:
     iPower = iPower - 1 ;
     break;
 }

 itemproperty ip = ItemPropertyDamageReduction(iPower,IP_CONST_DAMAGESOAK_5_HP);
 AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
 return TRUE;
}

int ku_si_AddItemProperty_AttackBonus(object oItem, int iPower) {

 iPower =  iPower / 2;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyAttackBonus(iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_si_AddItemProperty_AbilityBonus(object oItem, int iPower, int iAbility) {

 iPower =  iPower / 2;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyAbilityBonus(iAbility,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_si_AddItemProperty_Regeneration(object oItem, int iPower) {

 iPower =  (iPower / 2) - 1;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyRegeneration(iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

/* Savy */

int ku_si_AddItemProperty_SaveUni(object oItem, int iPower) {

 iPower =  (iPower / 2) - 2;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_si_AddItemProperty_Save(object oItem, int iPower, int iSaveType) {

 iPower =  (iPower / 2);
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSavingThrow(iSaveType,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_si_AddItemProperty_SaveSpecific(object oItem, int iPower, int iSaveType) {

 iPower =  (iPower / 2) + 1;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSavingThrowVsX(iSaveType,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}


///////////////////////////////////////////
/////
///// Tady urcime, co ktery kamen na tom kterem predmetu udela.
/////
///////////////////////////////////////////
//Nefrit +1
int ku_si_AddPropertiesStone_1(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_APPRAISE,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_TUMBLE,iPower);
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_PARRY,iPower);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_PICK_POCKET,iPower);
     //     default:
     // return -1;
  }
      return -1;
}

//Malachit +2
int ku_si_AddPropertiesStone_2(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_BLUFF,iPower);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_LORE,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_SET_TRAP,iPower);
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_BLUE);
     //     default:
     // return -1;
  }
  return -1;
}

//Ohnivy achat +3
int ku_si_AddPropertiesStone_3(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_PERSUADE,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_RED);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_HEAL,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Aventurin +4
int ku_si_AddPropertiesStone_4(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_GREEN);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_CONCENTRATION,iPower);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_DISEASE);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_OPEN_LOCK,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Fenalop +5
int ku_si_AddPropertiesStone_5(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_HIDE,iPower);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_SEARCH,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_DISABLE_TRAP,iPower);
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_MOVE_SILENTLY,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Ametyst +6
int ku_si_AddPropertiesStone_6(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_ACID);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_SPOT,iPower);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_POISON);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_ANIMAL_EMPATHY,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Zivec +7
int ku_si_AddPropertiesStone_7(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_ORANGE);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_SPELLCRAFT,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_DISCIPLINE,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Granat +8 (AC)
int ku_si_AddPropertiesStone_8(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_HELMET:
    case BASE_ITEM_BELT:
//    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_AC(oItem,iPower);
     //     default:
     // return -1;
  }
  return -1;
}


//Alexandrit +9
int ku_si_AddPropertiesStone_9(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_PERFORM,iPower);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_LISTEN,iPower);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_DEATH);
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_CHARISMA);
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_SONIC);
     //     default:
     // return -1;
  }
 return -1;
}

//Topaz +10
int ku_si_AddPropertiesStone_10(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_COLD);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_WISDOM);
//      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_TAUNT,iPower);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_FEAR);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_INTIMIDATE,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//safir +11
int ku_si_AddPropertiesStone_11(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_BELT:
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_SR(oItem,iPower);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_INTELLIGENCE);
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_NEGATIVE);
     //     default:
     // return -1;
  }
  return -1;
}

//Ohnivy opal +12
int ku_si_AddPropertiesStone_12(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_FIRE);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SkillBonus(oItem,SKILL_USE_MAGIC_DEVICE,iPower);
    case BASE_ITEM_BELT:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_DEXTERITY);
     //     default:
     // return -1;
  }
  return -1;
}

//Diamant +13
int ku_si_AddPropertiesStone_13(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_ELECTRICAL);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_SaveSpecific(oItem,iPower,IP_CONST_SAVEVS_MINDAFFECTING);
    case BASE_ITEM_BELT:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_STRENGTH);
     //     default:
     // return -1;
  }
  return -1;
}

//Rubin +14
int ku_si_AddPropertiesStone_14(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_HELMET:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BRACER:
      return ku_si_AddItemProperty_DmgReduction(oItem,iPower);
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_CONSTITUTION);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_Regeneration(oItem,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

//Smaragd +15
int ku_si_AddPropertiesStone_15(object oItem, int iPower) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iBaseItem) {
    case BASE_ITEM_ARMOR:
    case BASE_ITEM_CLOAK:
      return ku_si_AddItemProperty_SaveUni(oItem,iPower);
    case BASE_ITEM_HELMET:
      return ku_si_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_WILL);
    case BASE_ITEM_BELT:
      return ku_si_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_FORTITUDE);
    case BASE_ITEM_BOOTS:
      return ku_si_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_REFLEX);
    case BASE_ITEM_GLOVES:
//    case BASE_ITEM_BRACER: // attack only on gloves
      return ku_si_AddItemProperty_AttackBonus(oItem,iPower);
     //     default:
     // return -1;
  }
  return -1;
}

int tc_si_AddPropertyForStone(object oItem, int iStone, int iPower, int bAllowOverPOwer = FALSE) {

  if(iStone <= 0)
    return FALSE;

  if(iPower <=0)
    return FALSE;

  if( (bAllowOverPOwer == FALSE) && (iPower > 10) ) {
    iPower = 10;
  }

  switch(iStone) {
    case 1 : return ku_si_AddPropertiesStone_1(oItem,iPower);
    case 2 : return ku_si_AddPropertiesStone_2(oItem,iPower);
    case 3 : return ku_si_AddPropertiesStone_3(oItem,iPower);
    case 4 : return ku_si_AddPropertiesStone_4(oItem,iPower);
    case 5 : return ku_si_AddPropertiesStone_5(oItem,iPower);
    case 6 : return ku_si_AddPropertiesStone_6(oItem,iPower);
    case 7 : return ku_si_AddPropertiesStone_7(oItem,iPower);
    case 8 : return ku_si_AddPropertiesStone_8(oItem,iPower);
    case 9 : return ku_si_AddPropertiesStone_9(oItem,iPower);
    case 10: return ku_si_AddPropertiesStone_10(oItem,iPower);
    case 11: return ku_si_AddPropertiesStone_11(oItem,iPower);
    case 12: return ku_si_AddPropertiesStone_12(oItem,iPower);
    case 13: return ku_si_AddPropertiesStone_13(oItem,iPower);
    case 14: return ku_si_AddPropertiesStone_14(oItem,iPower);
    case 15: return ku_si_AddPropertiesStone_15(oItem,iPower);
  }

  return FALSE;
}




