/**************
*** tc_zl_funcs.nss ****
********************/

/**************************************
 ***** Kucik make properties on item *****
 ***** These functions are used only to generate loot item ****
 *******************************************/
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
int ku_zl_AddItemProperty_ElementReduction(object oItem, int iPower, int iElement) {

  iPower = (iPower/2) - 1; //max 20 (=4)

  //  + 5 resistance on amulets
  if( GetBaseItemType(oItem) == BASE_ITEM_AMULET) {
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
int ku_zl_AddItemProperty_AC(object oItem, int iPower) {

  if( GetBaseItemType(oItem) == BASE_ITEM_AMULET) {
    iPower++;
  }

  itemproperty ip;

  ip = ItemPropertyACBonus(iPower/2);
  AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
  return TRUE;
}

int ku_zl_AddItemProperty_AbilityBonus(object oItem, int iPower, int iAbility) {

 if( GetBaseItemType(oItem) == BASE_ITEM_AMULET) {
    iPower++;
  }

 iPower =  iPower / 2;
 if(iPower > 0) {
   itemproperty ip = ItemPropertyAbilityBonus(iAbility,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

/* Savy */

int ku_zl_AddItemProperty_SaveUni(object oItem, int iPower) {

 iPower =  (iPower / 2) - 2;
 if( GetBaseItemType(oItem) == BASE_ITEM_RING) {
    iPower--;
  }
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_zl_AddItemProperty_Save(object oItem, int iPower, int iSaveType) {

 if( GetBaseItemType(oItem) == BASE_ITEM_AMULET) {
    iPower++;
  }

 iPower =  (iPower / 2);
 if(iPower > 0) {
   itemproperty ip = ItemPropertyBonusSavingThrow(iSaveType,iPower);
   AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
   return TRUE;
 }
 return FALSE;
}

int ku_zl_AddItemProperty_SaveSpecific(object oItem, int iPower, int iSaveType) {

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

int ku_zl_AddPropertiesForStone(object oItem, int iPower, int iStone) {

  int iBaseItem = GetBaseItemType(oItem);

  switch(iStone) {
    case 1: return ku_zl_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_COLD);
    case 2: return ku_zl_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_ELECTRICAL);
    case 3: return ku_zl_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_FIRE);
    case 4: return ku_zl_AddItemProperty_ElementReduction(oItem,iPower,IP_CONST_DAMAGETYPE_ACID);

    case 5: return ku_zl_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_REFLEX);
    case 6: return ku_zl_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_WILL);
    case 7: return ku_zl_AddItemProperty_Save(oItem,iPower,IP_CONST_SAVEBASETYPE_FORTITUDE);

    case 8: return ku_zl_AddItemProperty_AC(oItem,iPower);

    case 9: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_CHARISMA);
    case 10: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_WISDOM);
    case 11: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_INTELLIGENCE);
    case 12: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_DEXTERITY);
    case 13: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_STRENGTH);
    case 14: return ku_zl_AddItemProperty_AbilityBonus(oItem,iPower,ABILITY_CONSTITUTION);
    case 15: return ku_zl_AddItemProperty_SaveUni(oItem,iPower);
 }
    return -1;

}

/*******************
**** END KUCIK *******
**********************/

