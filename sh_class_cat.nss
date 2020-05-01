 //::///////////////////////////////////////////////
//:: UPRAVY POVOLANI
//:: sh_classes_cat
//:: //:://////////////////////////////////////////////
/*
BONUSY PRO POSTAVY SPECIFICKE PODLE KATEGORII
- SKILLY-> IP
- AB,AC DODGE,DMG  - EFFECT



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:
//:://////////////////////////////////////////////
//pomocne funkce
#include "ku_skin_inc"
#include "sh_classes_inc_e"
#include "nwnx_funcs"
#include "nwnx_structs"
#include "subraces"
#include "sh_deity_inc"
#include "sh_effects_const"
//Subraces_GetCharacterSubrace

/*
Aplikace IP s body do skillu, pokud  je hodnota iValue vetsi nez 0
*/
void ApplySkillIP(object oPCSkin,int iSkill, int iValue)
{

    if (iValue > 0)
    {
        itemproperty ip =   ItemPropertySkillBonus(iSkill,iValue);
        SetItemPropertySpellId(ip,IP_SKILL_BONUS);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
}

/*
Odstrani vsechny efekty z postavz a item property z kuze(ktere patri k povolanim)
*/
void RemoveClassItemPropertyAndEffects(object oPC, object oPCSkin)
{
      //efekty
      int iEffect;
      effect eLoop = GetFirstEffect(oPC);
      while (GetIsEffectValid(eLoop))
      {
        iEffect = GetEffectSpellId(eLoop);
        if (
        (iEffect== EFFECT_AB_AC_DMG)
        || (iEffect == EFFECT_CONCEALMENT )
        || (iEffect == EFFECT_SPEED)
        || (iEffect == EFFECT_DAMAGE_REDUCTION)
        || (iEffect == EFFECT_EXORCISTA_PASSIVE)
        || (iEffect == EFFECT_LILITH_PASSIVE)
        )
        {
            RemoveEffect(oPC,eLoop);
        }
        eLoop = GetNextEffect(oPC);
     }



     int iIP;
     itemproperty ipLoop = GetFirstItemProperty(oPCSkin);
     while (GetIsItemPropertyValid(ipLoop))
     {
        iIP = GetItemPropertySpellId(ipLoop);
        if(
        (iIP == IP_SKILL_BONUS)
        || (iIP== IP_SAVE)
        || (iIP== IP_REGENERATION)
        || (iIP== IP_DAMAGE_REDUCTION)
        )
        {
            RemoveItemProperty(oPCSkin,ipLoop);
        }
        ipLoop = GetNextItemProperty(oPCSkin);
     }

}

int __FEAT_GENERAL_OBRANA_SE_DVEMA_ZBRANEMA(object oPC) {
  int iBonus = 1;
  int iCreatureSize = GetCreatureSize(oPC);

  if (GetHasFeat(FEAT_GENERAL_LEPSI_OBRANA_SE_DVEMA_ZBRANEMA,oPC) == TRUE)
    iBonus = 3;
  if (GetHasFeat(FEAT_EPICGENERAL_EPICKA_OBRANA_DVEMA_ZBRANEMA,oPC) == TRUE)
    iBonus = 5;

  object oMainWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  // Check main weapon validity
  if(!GetIsObjectValid(oMainWeapon))
    return 0;

  // Check if it is weapon
  int iMainWeaponType = GetBaseItemType(oMainWeapon);
  if(Get2DAString("baseitems","StorePanel",iMainWeaponType) != "1")
    return 0;

  // Check for ranged weapons
  if(StringToInt(Get2DAString("baseitems","RangedWeapon",iMainWeaponType)) > 0)
    return 0;

  // Two handed weapons
  int iWeaponSize = StringToInt(Get2DAString("baseitems","WeaponSize",iMainWeaponType));
  if(iCreatureSize + 1 == iWeaponSize) {
    return iBonus;
  }

  // Two weapons - check offhand.
  object oOffWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
  if(!GetIsObjectValid(oOffWeapon))
    return 0;

  int iOffWeapon = GetBaseItemType(oOffWeapon);
  // Check for ranged weapons
  if(StringToInt(Get2DAString("baseitems","RangedWeapon",iOffWeapon)) > 0)
    return 0;

  // Check if it is weapon
  if(Get2DAString("baseitems","StorePanel",iOffWeapon) == "1")
    return iBonus;

  return 0;
}

/*
Prida bonusy do AC - natural base - pres nwnx
*/
void RefreshBonusACNaturalBase(object oPC, object oPCSkin)
{
    int iBonus = 0;
    int iItemTypeRightMain,iItemTypeLeftOff,iWeaponBonus;

    object oItem;

    if (GetHasFeat(FEAT_SERMIR_CHYTRA_OBRANA,oPC)==TRUE)
    {
       if (
      ((GetBaseItemType(oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)) == BASE_ITEM_ARMOR ) && (GetArmorAC(oItem) > 0) )||
      (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)) == BASE_ITEM_TOWERSHIELD )    ||
      (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)) == BASE_ITEM_LARGESHIELD )
      )
      {
            ;
      }
      else
      {
          int iBonusINT =  GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
          int iMaxLvl = GetLevelByClass(CLASS_TYPE_SERMIR,oPC);
          if (iBonusINT > iMaxLvl)
          {
            iBonusINT = iMaxLvl;
          }
          iBonus += iBonusINT;
      }
    }

    if (GetHasFeat(FEAT_GENERAL_OBRANA_SE_DVEMA_ZBRANEMA,oPC) == TRUE)
    {
       iBonus += __FEAT_GENERAL_OBRANA_SE_DVEMA_ZBRANEMA(oPC);
    }
    SetACNaturalBase(oPC,iBonus);
}


/*
Prida bonusy do zachranych hodu
*/
void ApplyBonusSaves(object oPC, object oPCSkin)
{
      int iReflex = 0;
      int iWill = 0;
      int iPoison = 0;
      int iFear = 0;
      int iDeath = 0;

         /*GENERAL FEAT - bullheaded*/
         if (GetHasFeat(FEAT_BLOODED,oPC) == TRUE)
         {
              iWill += 1;
         }
         /*GENERAL FEAT - snake blood*/
         if (GetHasFeat(FEAT_BLOODED,oPC) == TRUE)
         {
              iReflex += 1;
              iPoison +=2;
         }
         /*Rasa ork*/
         if (GetRacialType(oPC)==RACIAL_TYPE_HALFORC)
         {
            iFear+=4;
         }
         /*GENERAL FEAT - bullheaded*/
         if (GetHasFeat(FEAT_BULLHEADED,oPC) == TRUE)
         {
               iReflex +=1;
         }
         /*GENERAL FEAT - hadi krev*/
         if (GetHasFeat(FEAT_SNAKEBLOOD,oPC) == TRUE)
         {
               iReflex +=1;
               iPoison +=2;
         }
         /*GENERAL FEAT - strong soul*/
         if (GetHasFeat(FEAT_STRONGSOUL,oPC) == TRUE)
         {
               iDeath +=1;
         }

       // pridani bonusu
        if (iReflex > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrow(SAVING_THROW_REFLEX,iReflex);
            SetItemPropertySpellId(ip,IP_SAVE);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        }
        if (iPoison > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,iPoison);
            SetItemPropertySpellId(ip,IP_SAVE);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        }
        if (iWill > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrow(SAVING_THROW_WILL,iWill);
            SetItemPropertySpellId(ip,IP_SAVE);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        }
        if (iFear > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FEAR,iFear);
            SetItemPropertySpellId(ip,IP_SAVE);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        }
        if (iDeath > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,iFear);
            SetItemPropertySpellId(ip,IP_SAVE);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        }


}

/*
Nastavi Bonus AC dodge,AB a DMG   ->     JAKO EFEKTY NA POSTAVU
*/
void ApplyAB_AC_DMGBonus(object oPC, object oPCSkin)
{
    //odstraneni efektu
    int iAB = 0;
    int iACdodge = 0;
    int iACarmor = 0;
    int iACshield = 0;
    int iACdeflection= 0;
    int iACnatural = 0;
    int iDMG= 0;
    /*Bonus vojevudce pdk - znalost boje*/
    if (GetHasFeat(1283,oPC) == TRUE)
    {
           int iLvl = GetLevelByClass(41,oPC);
           iDMG +=(iLvl-5)/5+1;
           iAB +=(iLvl-5)/5+1;
           iACnatural +=(iLvl-5)/5+1;
    }
     //nahozeni bonusu
    if (iAB > 0)
    {
        effect ef = EffectAttackIncrease(iAB);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

    if (iACnatural > 0)
    {
        effect ef = EffectACIncrease(iACnatural,AC_NATURAL_BONUS);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }


    if (iDMG > 0)
    {

        effect ef = EffectDamageIncrease(GetDamageBonusByValue(iDMG),DAMAGE_TYPE_SLASHING);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }



    /*feat - svaty uder*/
    if (GetHasFeat(FEAT_EPICGENERAL_SVATY_UDER,oPC))
    {
       effect ef = EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_POSITIVE);
       effect eLink = SupernaturalEffect(ef);
       SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }
    /*feat - bezbozny uder*/
    if (GetHasFeat(FEAT_EPICGENERAL_BEZBOZNY_UDER,oPC))
    {
       effect ef = EffectDamageIncrease(DAMAGE_BONUS_1d6,DAMAGE_TYPE_NEGATIVE);
       effect eLink = SupernaturalEffect(ef);
       SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }

}
/*
Pridava, vsechny bonusy do skillu
*/
void AddSkillIPBonuses(object oPC, object oPCSkin)
{
    // Deklarace bonusu do skillu
    int iAnimalEmpathy = 0;
    int iAppraise = 0;
    int iBluff = 0;
    int iConcetration = 0;
    int iDisableTrap = 0;
    int iDiscipline = 0;
    int iHeal = 0;
    int iHide = 0;
    int iIntimidate= 0;
    int iListen = 0;
    int iLore = 0;
    int iMoveSilently = 0;
    int iOpenLock = 0;
    int iParry= 0;
    int iPerform = 0;
    int iPersuade= 0;
    int iPickPocket = 0;
    int iRide = 0;
    int iSearch = 0;
    int iSetTrap = 0;
    int iSpellcraft = 0;
    int iSpot = 0;
    int iTaunt = 0;
    int iTumble = 0;
    int iUseMagicDevice = 0;

    //uprava bonusu na zaklade featu
        /*Vojevudcuv bonus - Mastered discipline*/ //+1 on level 3 and each 3 levels +1
         if (GetHasFeat(1284,oPC) == TRUE)  //FEAT_PDK_MASTERED_DISCIPLINE
         {
                int iLvL = GetLevelByClass(41,oPC);
                iDiscipline +=(iLvL/3);
         }

         /*Exorcistova znalost magie*/
         if (GetHasFeat(FEAT_EXORCISTA_ZNALOST_MAGIE,oPC) == TRUE)
         {
                iSpellcraft +=GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);

         }
         /*CERNOKNEZNIK osaleni predmetu*/
         if (GetHasFeat(FEAT_CERNOKNEZNI_OSALENI_PREDMETU,oPC) == TRUE)
         {
                iSpellcraft +=4;

         }
         /*Cernokneznik - mlznz ukryt*/
         if (GetHasFeat(FEAT_CERNOKNEZNIK_INVOKACE1_MLZNY_UKRYT,oPC) == TRUE)
         {
               iHide +=4;
               iMoveSilently+= 4;
         }

        /*Cernokneznik -nadpozemsky sepot*/
         if (GetHasFeat(FEAT_CERNOKNEZNIK_INVOKACE1_NADPOZEMSKY_SEPOT,oPC) == TRUE)
         {
               iLore +=6;
               iSpellcraft+= 6;
         }

        /*GENERAL FEAT - ALERTNESS*/
         if (GetHasFeat(FEAT_ALERTNESS,oPC) == TRUE)
         {
               iSpot +=2;
               iListen+= 2;
         }

        /*GENERAL FEAT - Artist*/
         if (GetHasFeat(FEAT_ARTIST,oPC) == TRUE)
         {
               iSpot +=2;
               iPerform+= 2;
               iPersuade += 2;
         }

        /*GENERAL FEAT - blooded*/
         if (GetHasFeat(FEAT_BLOODED,oPC) == TRUE)
         {
               iSpot +=6;
         }

         /*GENERAL FEAT - bullheaded*/
         if (GetHasFeat(FEAT_BULLHEADED,oPC) == TRUE)
         {
               iTaunt +=2;
         }

         /*GENERAL FEAT - vlada magu*/
         if (GetHasFeat(FEAT_COURTLY_MAGOCRACY,oPC) == TRUE)
         {
               iLore +=2;
               iSpellcraft += 2;
         }
         /*GENERAL FEAT - SILVER PALM*/
         if (GetHasFeat(FEAT_SILVER_PALM,oPC) == TRUE)
         {
               iAppraise +=2;
               iPersuade +=2;
         }
        /*GENERAL FEAT - stealthy*/
         if (GetHasFeat(FEAT_STEALTHY,oPC) == TRUE)
         {
               iMoveSilently +=2;
               iHide +=2;

         }
         /*GENERAL FEAT - thug*/
         if (GetHasFeat(FEAT_THUG,oPC) == TRUE)
         {
               iPersuade +=2;
         }

         /*GENERAL FEAT - epic reputation*/
         if (GetHasFeat(FEAT_EPIC_REPUTATION,oPC) == TRUE)
         {
               iBluff +=4;
               iIntimidate +=4;
               iPersuade +=4;
               iTaunt +=4;
         }
///////////////////////////Subrasy///////////////////////////////////////
        int iSubrace = Subraces_GetCharacterSubrace(oPC);
        switch (iSubrace)
        {

             case NT2_SUBRACE_ORC_NONE:
                iIntimidate+=2;
                iTaunt+=2;
            break;

        }


///////////////////////////Subrasy - konec///////////////////////////////
    // aplikovani bonusu
    ApplySkillIP(oPCSkin,SKILL_ANIMAL_EMPATHY,iAnimalEmpathy);
    ApplySkillIP(oPCSkin,SKILL_APPRAISE,iAppraise);
    ApplySkillIP(oPCSkin,SKILL_BLUFF,iBluff);
    ApplySkillIP(oPCSkin,SKILL_CONCENTRATION,iConcetration);
    ApplySkillIP(oPCSkin,SKILL_DISABLE_TRAP,iDisableTrap);
    ApplySkillIP(oPCSkin,SKILL_DISCIPLINE,iDiscipline);
    ApplySkillIP(oPCSkin,SKILL_HEAL,iHeal);
    ApplySkillIP(oPCSkin,SKILL_HIDE,iHide);
    ApplySkillIP(oPCSkin,SKILL_INTIMIDATE,iIntimidate);
    ApplySkillIP(oPCSkin,SKILL_LISTEN,iListen);
    ApplySkillIP(oPCSkin,SKILL_LORE,iLore);
    ApplySkillIP(oPCSkin,SKILL_MOVE_SILENTLY,iMoveSilently);
    ApplySkillIP(oPCSkin,SKILL_OPEN_LOCK,iOpenLock);
    ApplySkillIP(oPCSkin,SKILL_PARRY,iParry);
    ApplySkillIP(oPCSkin,SKILL_PERFORM,iPerform);
    ApplySkillIP(oPCSkin,SKILL_PERSUADE,iPersuade);
    ApplySkillIP(oPCSkin,SKILL_PICK_POCKET,iPickPocket);
    ApplySkillIP(oPCSkin,SKILL_RIDE,iRide);
    ApplySkillIP(oPCSkin,SKILL_SEARCH,iSearch);
    ApplySkillIP(oPCSkin,SKILL_SET_TRAP,iSetTrap);
    ApplySkillIP(oPCSkin,SKILL_SPELLCRAFT,iSpellcraft);
    ApplySkillIP(oPCSkin,SKILL_SPOT,iSpot);
    ApplySkillIP(oPCSkin,SKILL_TAUNT,iTaunt);
    ApplySkillIP(oPCSkin,SKILL_TUMBLE,iTumble);
    ApplySkillIP(oPCSkin,SKILL_USE_MAGIC_DEVICE,iUseMagicDevice);

}
/*Bonusy do dmg redukci a zranitelnost*/
void ApplyDamageReduction(object oPC, object oPCSkin)
{
    int iHD = GetHitDice(oPC);
    int iDamageReductionFire = 0;
    int iDamageReductionCold = 0;
    int iDamageReductionAcid = 0;
    int iDamageReductionElec = 0;

    int iVulnerabilityFire = 0;
    int iVulnerabilityCold = 0;
    int iVulnerabilityAcid = 0;
    int iVulnerabilityElec = 0;

    int iImmunityFire = 0;
    int iImmunityCold = 0;
    int iImmunityAcid = 0;
    int iImmunityElec = 0;

    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    switch (iSubrace)
    {
        case NT2_SUBRACE_HUMAN_AASIMAR:
        if (iDamageReductionCold < 5) iDamageReductionCold = 5;
        if (iDamageReductionElec < 5) iDamageReductionElec = 5;
        if (iDamageReductionAcid < 5) iDamageReductionAcid = 5;
        break;

        case NT2_SUBRACE_HUMAN_TIEFLING:
        if (iDamageReductionFire < 5) iDamageReductionFire = 5;
        if (iDamageReductionAcid < 5) iDamageReductionAcid = 5;
        if (iDamageReductionElec < 5) iDamageReductionElec = 5;
        
        break;

        case NT2_SUBRACE_HALFDRAGON_BLACK:
        iImmunityAcid += 50;
        break;

        case NT2_SUBRACE_HALFDRAGON_BLUE:
        iImmunityElec += 50;
        break;

        case NT2_SUBRACE_HALFDRAGON_GREEN:
        iImmunityAcid += 50;
        break;

        case NT2_SUBRACE_HALFDRAGON_RED:
        iImmunityFire += 50;
        break;

        case NT2_SUBRACE_HALFDRAGON_WHITE:
        iImmunityCold += 50;
        break;

    }
    itemproperty ip;
    effect ef,eSup;
    //pohlceni
    if (iDamageReductionFire >0)
    {
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,GetIPDamageReductionHPResistConstant(iDamageReductionFire));
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iDamageReductionCold >0)
    {
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,GetIPDamageReductionHPResistConstant(iDamageReductionCold));
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iDamageReductionAcid >0)
    {
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,GetIPDamageReductionHPResistConstant(iDamageReductionAcid));
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iDamageReductionElec >0)
    {
        ip = ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,GetIPDamageReductionHPResistConstant(iDamageReductionElec));
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    //zranitelnost
    if (iVulnerabilityFire >0)
    {
        ef =  EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,iVulnerabilityFire);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iVulnerabilityCold >0)
    {
        ef =  EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD,iVulnerabilityCold);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iVulnerabilityAcid >0)
    {
        ef =  EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID,iVulnerabilityAcid);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iVulnerabilityElec >0)
    {
        ef =  EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL,iVulnerabilityElec);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    //immunita
    if (iImmunityFire >0)
    {
        ef =  EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,iImmunityFire);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iImmunityCold >0)
    {
        ef =  EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,iImmunityCold);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iImmunityAcid >0)
    {
        ef =  EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,iImmunityAcid);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
    if (iImmunityElec >0)
    {
        ef =  EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,iImmunityElec);
        eSup = SupernaturalEffect(ef);
        SetEffectSpellId(eSup,EFFECT_DAMAGE_REDUCTION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSup,oPC);
    }
}

/*Bonusy do regenerace*/
void ApplyRegeneration(object oPC, object oPCSkin)
{

    int iRegeneration = 0;
    int iDDRegen = 0;
    /*CERNOKNEZNIK Dábelská prunost*/
    if (GetHasFeat(FEAT_CERNOKNEZNI_DABELSKA_PRUZNOST,oPC) == TRUE)
    {
         iRegeneration += (GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,oPC)-8)/5+1;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_1,oPC) == TRUE)
    {
         iDDRegen = 5;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_2,oPC) == TRUE)
    {
         iDDRegen = 10;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_3,oPC) == TRUE)
    {
         iDDRegen = 20;
    }
    itemproperty eRegen;
    if (iRegeneration >0)
    {
        eRegen = ItemPropertyRegeneration(iRegeneration);
        SetItemPropertySpellId(eRegen,IP_REGENERATION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,eRegen,oPCSkin,43200.0);

    }
    if (iDDRegen >0)
    {
        eRegen = ItemPropertyRegeneration(iDDRegen);
        SetItemPropertySpellId(eRegen,IP_REGENERATION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,eRegen,oPCSkin,43200.0);

    }
}


void ApplyConcealment(object oPC, object oPCSkin)
{

    int iConcealment = 0;
    /*CERNOKNEZNIK  mlznz ukryt*/
    if (GetHasFeat(FEAT_CERNOKNEZNIK_INVOKACE1_MLZNY_UKRYT,oPC) == TRUE)
    {
        iConcealment+= 20;
    }
    if (iConcealment >0)
    {
        effect ef =  EffectConcealment(iConcealment,MISS_CHANCE_TYPE_VS_RANGED);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId (eLink,EFFECT_CONCEALMENT);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }
}
/*Rychlost*/
void ApplySpeed(object oPC, object oPCSkin)
{

    int iSpeed = 0;
    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    if (iSubrace == NT2_SUBRACE_ELF_WINGED)
    {
       iSpeed+= 20;
    }

    if (iSpeed >0)
    {
        effect ef =  EffectMovementSpeedIncrease(iSpeed);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId (eLink,EFFECT_SPEED);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }
}


