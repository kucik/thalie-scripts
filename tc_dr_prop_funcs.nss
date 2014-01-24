int ku_dr_AddItemProperty_AC(object oItem, int iPower);
int ku_dr_AddItemProperty_SkillBonus(object oItem, int iSkill, int iPower);
int ku_dr_AddItemProperty_Light(object oItem, int iPower, int iColor);
int ku_dr_AddBonusLevelSpell(object oItem, int iClass, int iPower);
int ku_dr_AddDamageBonus(object oItem, int iDmgType, int iPower);

int tc_dr_StaffAddPropertyForStone(object oItem, int iStone, int iPower, int bAllowOverPOwer = FALSE);

int tc_dr_StaffAddPropertyForStone(object oItem, int iStone, int iPower, int bAllowOverPOwer = FALSE) {

  if(iStone <= 0)
    return FALSE;

  if(iPower <=0)
    return FALSE;

  if( (bAllowOverPOwer == FALSE) && (iPower > 10) ) {
    iPower = 10;
  }

  int iEnhance;

  switch(iStone) {
    // Nefrit
    case 1 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_WHITE);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_PARRY,iPower);
    // Malachit
    case 2 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_BLUE);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_LORE,iPower);
    // Ohnivy achat
    case 3 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_RED);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_HEAL,iPower);
    // Aventurin
    case 4 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_DIM,IP_CONST_LIGHTCOLOR_GREEN);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_CONCENTRATION,iPower);
    // Fenalop
    case 5 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_WHITE);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_SEARCH,iPower);
    // Ametyst
    case 6 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_BLUE);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_ANIMAL_EMPATHY,iPower);
    // Zivec
    case 7 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_RED);
      return ku_dr_AddItemProperty_SkillBonus(oItem,SKILL_SPELLCRAFT,iPower);
    // Granat
    case 8 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_LOW,IP_CONST_LIGHTCOLOR_GREEN);
      return ku_dr_AddItemProperty_AC(oItem,iPower);
    // Alexandrit
    case 9 :
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_WHITE);
      return ku_dr_AddBonusLevelSpell(oItem,IP_CONST_CLASS_BARD,iPower);
    // Topaz
    case 10:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_BLUE);
      return ku_dr_AddBonusLevelSpell(oItem,IP_CONST_CLASS_DRUID,iPower);
    // Safir
    case 11:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_RED);
      return ku_dr_AddBonusLevelSpell(oItem,IP_CONST_CLASS_CLERIC,iPower);
    // Ohnivy Opal
    case 12:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_NORMAL,IP_CONST_LIGHTCOLOR_GREEN);
      return ku_dr_AddBonusLevelSpell(oItem,IP_CONST_CLASS_WIZARD,iPower);
    // Diamant
    case 13:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_WHITE);
      return ku_dr_AddBonusLevelSpell(oItem,IP_CONST_CLASS_SORCERER,iPower);
    // Rubin
    case 14:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED);
      return ku_dr_AddDamageBonus(oItem,IP_CONST_DAMAGETYPE_MAGICAL,iPower);
    // Smaragd
    case 15:
      ku_dr_AddItemProperty_Light(oItem,IP_CONST_LIGHTBRIGHTNESS_BRIGHT,IP_CONST_LIGHTCOLOR_RED);
      iEnhance = (iPower) /2;
      if(iEnhance <=0) {
        return FALSE;
      }
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonus(iEnhance),oItem);
      return TRUE;
  }

  return FALSE;
}


/* AC BONUS */
int ku_dr_AddItemProperty_AC(object oItem, int iPower) {

  itemproperty ip;
  iPower = iPower/2;
  if(iPower <= 0) {
    return FALSE;
  }

  ip = ItemPropertyACBonus(iPower);
  AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
  return TRUE;
}

/* skills */
int ku_dr_AddItemProperty_SkillBonus(object oItem, int iSkill, int iPower) {

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
/*
int IP_CONST_LIGHTBRIGHTNESS_DIM                = 1;
int IP_CONST_LIGHTBRIGHTNESS_LOW                = 2;
int IP_CONST_LIGHTBRIGHTNESS_NORMAL             = 3;
int IP_CONST_LIGHTBRIGHTNESS_BRIGHT             = 4;
int IP_CONST_LIGHTCOLOR_BLUE                    = 0;
int IP_CONST_LIGHTCOLOR_YELLOW                  = 1;
int IP_CONST_LIGHTCOLOR_PURPLE                  = 2;
int IP_CONST_LIGHTCOLOR_RED                     = 3;
int IP_CONST_LIGHTCOLOR_GREEN                   = 4;
int IP_CONST_LIGHTCOLOR_ORANGE                  = 5;
int IP_CONST_LIGHTCOLOR_WHITE                   = 6;
*/
int ku_dr_AddItemProperty_Light(object oItem, int iPower, int iColor) {

  itemproperty ip = ItemPropertyLight(iPower,iColor);
  AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem);
  return TRUE;
}

int ku_dr_AddBonusLevelSpell(object oItem, int iClass, int iPower) {

 if(iPower > 10) {
   iPower = 10;
 }

 // Bard has only levels 1-6
 if(iClass == IP_CONST_CLASS_BARD) {
   iPower = iPower - 3;
 }

 if(iPower < 1) {
   return FALSE;
 }


 int i;
 for(i=0;i<3;i++) {
   iPower--;
   if(iPower >= 0) {
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(iClass,iPower),oItem);
   }
 }

 return TRUE;
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
int tc_dr_StaffPowerToDamageBonus(int iPower) {

  switch(iPower) {
    case 1: return 0;
    case 2: return IP_CONST_DAMAGEBONUS_1;
    case 3: return IP_CONST_DAMAGEBONUS_1;
    case 4: return IP_CONST_DAMAGEBONUS_2;
    case 5: return IP_CONST_DAMAGEBONUS_2;
    case 6: return IP_CONST_DAMAGEBONUS_3;
    case 7: return IP_CONST_DAMAGEBONUS_1d4;
    case 8: return IP_CONST_DAMAGEBONUS_1d6;
    case 9: return IP_CONST_DAMAGEBONUS_1d8;
    case 10: return IP_CONST_DAMAGEBONUS_1d10;
    //overpowered for loot
    case 11: return IP_CONST_DAMAGEBONUS_1d12;
    case 12:
    case 13:
    case 14:
    case 15:
    case 16: return IP_CONST_DAMAGEBONUS_2d6;
  }
  return 0;
}

int ku_dr_AddDamageBonus(object oItem, int iDmgType, int iPower) {

   int iBonus = tc_dr_StaffPowerToDamageBonus(iPower);
   if(iBonus > 0) {
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(iDmgType,iBonus),oItem);
      return TRUE;
   }
   return FALSE;
}



