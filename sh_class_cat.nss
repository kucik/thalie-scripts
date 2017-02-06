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
void SetFavoredEnemyDamage(object oPC, int iLevel)
{

    effect eApply;
    int iBonus = GetFavoredDamageByRangerLevel(iLevel);
    int iBonus1 = 0;
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_1,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_2,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_3,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_4,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_5,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_6,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_7,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_8,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_9,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    if (GetHasFeat(FEAT_EPICGENERAL_ZLEPSENY_UHLAVNI_NEPRITEL_10,oPC) == TRUE)
    {
        iBonus1 += 2;
    }
    effect eLink =  EffectDamageIncrease(GetDamageBonusByValue(iBonus),DAMAGE_TYPE_PIERCING);

    if (iBonus1 > 0)
    {
        effect ef1 =   EffectDamageIncrease(GetDamageBonusByValue(iBonus1),DAMAGE_TYPE_SLASHING);
        eLink = EffectLinkEffects(eLink,ef1);
    }

    if (GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_ABERRATION);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_ANIMAL);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_BEAST,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_BEAST);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_CONSTRUCT);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_DRAGON);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_DWARF,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_DWARF);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_ELEMENTAL);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_ELF,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_ELF);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_FEY,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_FEY);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_GIANT,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_GIANT);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_GNOME,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_GNOME);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HUMANOID_GOBLINOID);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HALFELF);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HALFLING);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HALFORC);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HUMAN);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_MAGICAL_BEAST);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HUMANOID_MONSTROUS);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_ORC,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HUMANOID_ORC);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_OUTSIDER);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_HUMANOID_REPTILIAN);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_SHAPECHANGER);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_UNDEAD);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }
        if (GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN,oPC))
    {
       eApply = VersusRacialTypeEffect(eLink,RACIAL_TYPE_VERMIN);
       eApply = SupernaturalEffect(eApply);
       SetEffectSpellId(eApply,EFFECT_AB_AC_DMG);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eApply,oPC);
    }


}

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
        || (iEffect == EFFECT_BARBAR_SNIZENI_ZRANENI)
        || (iEffect == EFFECT_SD_ZRAK)
        || (iEffect == EFFECT_SD_RYCHLOST)
        || (iEffect == EFFECT_CONCEALMENT )
        || (iEffect == EFFECT_BRUTALNI_VRH )
        || (iEffect == EFFECT_SPEED)
        || (iEffect == EFFECT_SPELL_RESISTANCE)
        || (iEffect == EFFECT_DAMAGE_REDUCTION)
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
        || (iIP== IP_NEWPERFECTSELF)
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
    /*
    Prida shinobi bonus do ac z aktualni moudrosti.
    Melo by volat pri onequipu, onunequipu a po kouzleni
    */
    if (GetHasFeat(FEAT_SHINOBI_OBRANA,oPC)==TRUE)
    {

      if (
      ((GetBaseItemType(oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)) == BASE_ITEM_ARMOR ) && (GetItemACBase (oItem) > 0 ) )||
//      (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)) == BASE_ITEM_TOWERSHIELD )    ||
      (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)) == BASE_ITEM_SMALLSHIELD )     ||
      (GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC)) == BASE_ITEM_LARGESHIELD )

      )
      {
            ;
      }
      else
      {
          iBonus += GetAbilityModifier(ABILITY_WISDOM,oPC);
      }
    }
    if (GetHasFeat(FEAT_SERMIR_CHYTRA_OBRANA,oPC)==TRUE)
    {
       if (
      ((GetBaseItemType(oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)) == BASE_ITEM_ARMOR ) && (GetItemACBase (oItem) > 0) )||
      //((GetBaseItemType(oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC))  == BASE_ITEM_HELMET) && ( GetLocalInt(oItem,"ku_kapuce")!=1))     ||
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
    // Dokonaly kryt - AC
    if (GetHasFeat(FEAT_FIGHTER_DOKOLANY_KRYT1,oPC) == TRUE)
    {
        iBonus +=1;
    }
    if (GetHasFeat(FEAT_FIGHTER_DOKOLANY_KRYT2,oPC) == TRUE)
    {
        iBonus +=1;
    }
    if (GetHasFeat(FEAT_FIGHTER_DOKOLANY_KRYT3,oPC) == TRUE)
    {
        iBonus +=1;
    }
    if (GetHasFeat(FEAT_FIGHTER_DOKOLANY_KRYT4,oPC) == TRUE)
    {
        iBonus +=1;
    }
    if (GetHasFeat(FEAT_FIGHTER_DOKOLANY_KRYT5,oPC) == TRUE)
    {
        iBonus +=1;
    }

    if (GetHasFeat(FEAT_GENERAL_OBRANA_SE_DVEMA_ZBRANEMA,oPC) == TRUE)
    {
       iBonus += __FEAT_GENERAL_OBRANA_SE_DVEMA_ZBRANEMA(oPC);
    }
    iItemTypeLeftOff = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC));
    if ((GetHasFeat(FEAT_KURTIZANA_POBLOUZNENI,oPC) == TRUE) && (iItemTypeLeftOff == 314) )  //FASHION ACC...
    {
        int iCasterLevelKurtizana = GetLevelByClass(CLASS_TYPE_KURTIZANA);
        iBonus += (iCasterLevelKurtizana -23)/3+1;
    }




    SetACNaturalBase(oPC,iBonus);
}


/*
Prida bonusy do zachranych hodu
*/
void ApplyBonusSaves(object oPC, object oPCSkin)
{
      int iReflex = 0;
      int iFort = 0;
      int iWill = 0;
      int iPoison = 0;
      int iFear = 0;
      int iDeath = 0;
      //bonus do savu od boziho bojovnika
      if (GetHasFeat(FEAT_TORM_ODRIKANI,oPC) == TRUE)
      {
        int lvl = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC);
        int iBonus = lvl /3;
        iReflex +=iBonus;
        iWill += iBonus;
        iFort += iBonus;
       }
       // rogue - dite stesteny
       if (GetHasFeat(FEAT_ROGUE_DITE_STESTENY1,oPC) == TRUE)
        {
            iReflex +=1;
            iWill += 1;
            iFort += 1;

        }
        if (GetHasFeat(FEAT_ROGUE_DITE_STESTENY2,oPC) == TRUE)
        {
            iReflex +=1;
            iWill += 1;
            iFort += 1;
        }
        if (GetHasFeat(FEAT_ROGUE_DITE_STESTENY3,oPC) == TRUE)
        {
            iReflex +=1;
            iWill += 1;
            iFort += 1;
        }
        if (GetHasFeat(FEAT_ROGUE_DITE_STESTENY4,oPC) == TRUE)
        {
            iReflex +=1;
            iWill += 1;
            iFort += 1;
        }
        if (GetHasFeat(FEAT_ROGUE_DITE_STESTENY5,oPC) == TRUE)
        {
            iReflex +=1;
            iWill += 1;
            iFort += 1;
        }
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
        if (iFort > 0)
        {
            itemproperty ip = ItemPropertyBonusSavingThrow(SAVING_THROW_FORT,iFort);
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
    /*Bonus trpasliciho obrance*/
    if (GetHasFeat(FEAT_BONUS_AC_TRPASLICI_OBRANCE,oPC)== TRUE)
    {
           int lvl = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC);
           iACnatural += (lvl+ 1) / 4;

    }

        //bojova zkusenost - ab a dmg
        if (GetHasFeat(FEAT_FIGHTER_BOJOVA_ZKUSENOST1,oPC) == TRUE)
        {
            iAB +=1;
            iDMG+=1;
        }
        if (GetHasFeat(FEAT_FIGHTER_BOJOVA_ZKUSENOST2,oPC) == TRUE)
        {
             iAB +=1;
            iDMG+=1;
        }
        if (GetHasFeat(FEAT_FIGHTER_BOJOVA_ZKUSENOST3,oPC) == TRUE)
        {
             iAB +=1;
            iDMG+=1;
        }
        if (GetHasFeat(FEAT_FIGHTER_BOJOVA_ZKUSENOST4,oPC) == TRUE)
        {
             iAB +=1;
            iDMG+=1;
        }
        if (GetHasFeat(FEAT_FIGHTER_BOJOVA_ZKUSENOST5,oPC) == TRUE)
        {
             iAB +=1;
            iDMG+=1;
        }
        //tvrdy zasah - dmg
        if (GetHasFeat(FEAT_FIGHTER_TVRDY_ZASAH1,oPC) == TRUE)
        {
            iDMG +=2;
        }
        if (GetHasFeat(FEAT_FIGHTER_TVRDY_ZASAH2,oPC) == TRUE)
        {
            iDMG +=2;
        }
        if (GetHasFeat(FEAT_FIGHTER_TVRDY_ZASAH3,oPC) == TRUE)
        {
            iDMG +=2;
        }
        if (GetHasFeat(FEAT_FIGHTER_TVRDY_ZASAH4,oPC) == TRUE)
        {
            iDMG +=2;
        }
        if (GetHasFeat(FEAT_FIGHTER_TVRDY_ZASAH5,oPC) == TRUE)
        {
            iDMG +=2;
        }

    //shinobi bonus do dodge AC
    if (GetHasFeat(FEAT_SHINOBI_BONUS_AC,oPC) == TRUE)
    {

        iACshield+= GetLevelByClass(CLASS_TYPE_SHINOBI,oPC) /5;
    }
    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    if (iSubrace == SUBRACE_ILLITHID)
    {
        iACdodge+=2;
    }

    //nahozeni bonusu
    if (iAB > 0)
    {
        effect ef = EffectAttackIncrease(iAB);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

    if (iACdodge > 0)
    {
        effect ef = EffectACIncrease(iACdodge);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

    if (iACarmor > 0)
    {
        effect ef = EffectACIncrease(iACarmor,AC_ARMOUR_ENCHANTMENT_BONUS);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

    if (iACshield > 0)
    {
        effect ef = EffectACIncrease(iACshield,AC_SHIELD_ENCHANTMENT_BONUS);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId(eLink,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

    if (iACdeflection > 0)
    {
        effect ef = EffectACIncrease(iACdeflection,AC_DEFLECTION_BONUS);
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

    /* Favored Enemy*/
    int iRangerLevel = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
    if (iRangerLevel >= 0)
    {
        SetFavoredEnemyDamage(oPC,iRangerLevel);
    }
    // trpaslici bonusy
    effect eDwarfAB,eDwarfAC;
    switch(iSubrace)
    {
        case SUBRACE_DWARF_SHIELD:
        eDwarfAC = EffectACIncrease(4);
        eDwarfAC = VersusRacialTypeEffect(eDwarfAC,RACIAL_TYPE_HUMANOID_ORC);
        eDwarfAC = SupernaturalEffect(eDwarfAC);
        SetEffectSpellId(eDwarfAC,EFFECT_AB_AC_DMG);
        eDwarfAB = EffectAttackIncrease(1);
        eDwarfAB = VersusRacialTypeEffect(eDwarfAB,RACIAL_TYPE_HUMANOID_ORC);
        eDwarfAB = SupernaturalEffect(eDwarfAB);
        SetEffectSpellId(eDwarfAB,EFFECT_AB_AC_DMG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAC,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAB,oPC);
        break;

        case SUBRACE_DWARF_MOUNTAIN:
        eDwarfAC = EffectACIncrease(4);
        eDwarfAC = VersusRacialTypeEffect(eDwarfAC,RACIAL_TYPE_GIANT);
        eDwarfAC = SupernaturalEffect(eDwarfAC);
        SetEffectSpellId(eDwarfAC,EFFECT_AB_AC_DMG);
        eDwarfAB = EffectAttackIncrease(1);
        eDwarfAB = VersusRacialTypeEffect(eDwarfAB,RACIAL_TYPE_GIANT);
        eDwarfAB = SupernaturalEffect(eDwarfAB);
        SetEffectSpellId(eDwarfAB,EFFECT_AB_AC_DMG);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAC,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAB,oPC);
        break;

        case SUBRACE_DWARF_GOLD:
        eDwarfAC = EffectACIncrease(4);
        eDwarfAC = VersusRacialTypeEffect(eDwarfAC,RACIAL_TYPE_ELEMENTAL);
        eDwarfAC = SupernaturalEffect(eDwarfAC);
        SetEffectSpellId(eDwarfAC,EFFECT_AB_AC_DMG);
        eDwarfAB = EffectAttackIncrease(1);
        eDwarfAB = VersusRacialTypeEffect(eDwarfAB,RACIAL_TYPE_ELEMENTAL);
        eDwarfAB = SupernaturalEffect(eDwarfAB);
        SetEffectSpellId(eDwarfAB,EFFECT_AB_AC_DMG);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAC,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAB,oPC);
        break;

        case SUBRACE_DWARF_DUERGAR:
        case SUBRACE_DWARF_DUERGAR_BRONZED:
        eDwarfAC = EffectACIncrease(4);
        eDwarfAC = VersusRacialTypeEffect(eDwarfAC,RACIAL_TYPE_OUTSIDER);
        eDwarfAC = SupernaturalEffect(eDwarfAC);
        SetEffectSpellId(eDwarfAC,EFFECT_AB_AC_DMG);
        eDwarfAB = EffectAttackIncrease(1);
        eDwarfAB = VersusRacialTypeEffect(eDwarfAB,RACIAL_TYPE_OUTSIDER);
        eDwarfAB = SupernaturalEffect(eDwarfAB);
        SetEffectSpellId(eDwarfAB,EFFECT_AB_AC_DMG);;

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAC,oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDwarfAB,oPC);
        break;

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

        /*Zlodejuv bonus - nenapadnost*/
         if (GetHasFeat(FEAT_ROGUE_KAPSAR1,oPC) == TRUE)
         {
                iPickPocket +=2;
         }
         if (GetHasFeat(FEAT_ROGUE_KAPSAR2,oPC) == TRUE)
         {
                iPickPocket +=2;
         }
         if (GetHasFeat(FEAT_ROGUE_KAPSAR3,oPC) == TRUE)
         {
                iPickPocket +=2;
         }
         if (GetHasFeat(FEAT_ROGUE_KAPSAR4,oPC) == TRUE)
         {
                iPickPocket +=2;
         }
         if (GetHasFeat(FEAT_ROGUE_KAPSAR5,oPC) == TRUE)
         {
                iPickPocket +=2;
         }
        /*Zlodejuv bonus - nenapadnost*/
         if (GetHasFeat(FEAT_ROGUE_NENAPADNOST1,oPC) == TRUE)
         {
                iHide +=2;
                iMoveSilently+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_NENAPADNOST2,oPC) == TRUE)
         {
                iHide +=2;
                iMoveSilently+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_NENAPADNOST3,oPC) == TRUE)
         {
                iHide +=2;
                iMoveSilently+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_NENAPADNOST4,oPC) == TRUE)
         {
                iHide +=2;
                iMoveSilently+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_NENAPADNOST5,oPC) == TRUE)
         {
                iHide +=2;
                iMoveSilently+= 2;
         }
        /*Zlodejuv bonus - bystrost */
        if (GetHasFeat(FEAT_ROGUE_BYSTROST1,oPC) == TRUE)
         {
                iSearch +=2;
                iSpot+= 2;
                iListen+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_BYSTROST2,oPC) == TRUE)
         {
                iSearch +=2;
                iSpot+= 2;
                iListen+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_BYSTROST3,oPC) == TRUE)
         {
                iSearch +=2;
                iSpot+= 2;
                iListen+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_BYSTROST4,oPC) == TRUE)
         {
                iSearch +=2;
                iSpot+= 2;
                iListen+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_BYSTROST5,oPC) == TRUE)
         {
                iSearch +=2;
                iSpot+= 2;
                iListen+= 2;
         }
         /*Zlodejuv bonus - sikovnost*/
         if (GetHasFeat(FEAT_ROGUE_SIKOVNOST1,oPC) == TRUE)
         {
                iDisableTrap +=2;
                iOpenLock+= 2;
                iSetTrap+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SIKOVNOST2,oPC) == TRUE)
         {
                iDisableTrap +=2;
                iOpenLock+= 2;
                iSetTrap+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SIKOVNOST3,oPC) == TRUE)
         {
                iDisableTrap +=2;
                iOpenLock+= 2;
                iSetTrap+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SIKOVNOST4,oPC) == TRUE)
         {
                iDisableTrap +=2;
                iOpenLock+= 2;
                iSetTrap+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SIKOVNOST5,oPC) == TRUE)
         {
                iDisableTrap +=2;
                iOpenLock+= 2;
                iSetTrap+= 2;
         }
         /*Zlodejuv bonus - svetak*/
         if (GetHasFeat(FEAT_ROGUE_SVETAK1,oPC) == TRUE)
         {
                iPersuade +=2;
                iIntimidate+= 2;
                iAppraise+= 2;
                iTaunt+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SVETAK2,oPC) == TRUE)
         {
                iPersuade +=2;
                iIntimidate+= 2;
                iAppraise+= 2;
                iTaunt+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SVETAK3,oPC) == TRUE)
         {
                iPersuade +=2;
                iIntimidate+= 2;
                iAppraise+= 2;
                iTaunt+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SVETAK4,oPC) == TRUE)
         {
                iPersuade +=2;
                iIntimidate+= 2;
                iAppraise+= 2;
                iTaunt+= 2;
         }
         if (GetHasFeat(FEAT_ROGUE_SVETAK5,oPC) == TRUE)
         {
                iPersuade +=2;
                iIntimidate+= 2;
                iAppraise+= 2;
                iTaunt+= 2;
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
            case SUBRACE_HUMAN_CITY:

            break;

            case SUBRACE_HUMAN_AASIMAR:
                iAppraise+=4;
                iPersuade+=4;
                iConcetration+=4;
                iSpot +=4;
            break;

            case SUBRACE_HUMAN_TIEFLING:
                iIntimidate+=4;
                iTaunt+=4;
                iMoveSilently+=4;
                iHide +=4;
            break;

            case SUBRACE_HUMAN_GENASI_WATER:
                iConcetration+=4;
                iSearch+=4;
                iListen+=4;
            break;

            case SUBRACE_HUMAN_GENASI_AIR:
                iConcetration+=4;
                iMoveSilently+=4;
                iHide+=4;
            break;

            case SUBRACE_HUMAN_GENASI_EARTH:
                iConcetration+=4;
                iDiscipline+=4;
                iSpot+=4;
            break;

            case SUBRACE_HUMAN_GENASI_FIRE:
                iConcetration+=4;
                iSpellcraft+=4;
                iLore+=4;
            break;

            case SUBRACE_ELF_WOOD:
                iListen+=2;
                iSearch+=2;
                iMoveSilently+=2;
                iHide +=2;
            break;

            case SUBRACE_ELF_WILD:
                iListen+=2;
                iSearch+=2;
                iAnimalEmpathy+=2;
                iDiscipline +=2;
            break;

            case SUBRACE_ELF_MOON:
                iListen+=2;
                iSearch+=2;
                iConcetration+=2;
                iSpellcraft +=2;
            break;

            case SUBRACE_ELF_SUN:
                iListen+=2;
                iSearch+=2;
                iConcetration+=2;
                iSpellcraft +=2;
            break;

            case SUBRACE_ELF_WINGED:
                iListen+=2;
                iSearch+=2;
                iMoveSilently+=2;
                iHide +=2;
            break;

            case SUBRACE_ELF_EAST:
                iDiscipline+=2;
                iSpot+=2;
                iMoveSilently+=2;
                iHide +=2;
            break;

            case SUBRACE_ELF_DROW:
                iListen+=2;
                iSpot+=2;
                iSearch+=2;
                iSpellcraft +=2;
            break;

            case SUBRACE_ELF_OBSIDIAN_DROW:
                iListen+=2;
                iSpot+=2;
                iSearch+=2;
                iSpellcraft +=2;
            break;

            case SUBRACE_DWARF_SHIELD:
                iDiscipline+=2;
                iSpot+=2;
            break;

            case SUBRACE_DWARF_MOUNTAIN:
                iDiscipline+=2;
                iIntimidate+=2;
            break;

            case SUBRACE_DWARF_GOLD:
                iConcetration+=2;
                iSpellcraft+=2;
            break;

            case SUBRACE_DWARF_DUERGAR:
                iHide+=2;
                iMoveSilently+=2;
            break;

            case SUBRACE_DWARF_DUERGAR_BRONZED:
                iHide+=2;
                iMoveSilently+=2;
                iSpellcraft+=2;
            break;

            case SUBRACE_ORC_CITY:
                iIntimidate+=2;
                iTaunt+=2;
            break;

            case SUBRACE_ORC_NORDIC:
                iIntimidate+=2;
                iTaunt+=2;
            break;

            case SUBRACE_ORC_DEEP:
                iIntimidate+=2;
                iTaunt+=2;
            break;

            case SUBRACE_ORC_HIRAN:
                iIntimidate+=4;
                iTaunt+=4;
                iDiscipline+=4;
            break;

            case SUBRACE_HALFLING_CITY:
                iTaunt+=2;
                iAppraise+=2;
                iConcetration+=2;
            break;

            case SUBRACE_HALFLING_WILD:
                iTaunt+=2;
                iDiscipline+=2;
                iIntimidate+=2;
            break;

            case SUBRACE_HALFLING_DEEP:
                iTaunt+=2;
                iHide+=2;
                iMoveSilently+=2;
            break;

            case SUBRACE_HALFLING_KOBOLD:
                iPerform+=2;
                iHide+=2;
                iMoveSilently+=2;
            break;

            case SUBRACE_GNOME_CITY:
                iConcetration+=2;
                iSpellcraft+=2;
                iLore+=2;
            break;

            case SUBRACE_GNOME_SWIRFNEBLIN:
                iConcetration+=2;
                iSpellcraft+=2;
                iLore+=2;
            break;

            case SUBRACE_GNOME_GOBLIN_DEEP:
                iTaunt+=2;
                iAppraise+=2;
            break;

            case SUBRACE_GNOME_PIXIE:
                iSpellcraft+=4;
                iSpot+=4;
                iHide+=4;
                iMoveSilently+=4;
            break;

            case SUBRACE_HALFELF:
            break;

            case SUBRACE_HALFDRAGON_BLACK:
                iSpot+=4;
                iIntimidate+=4;
            break;

            case SUBRACE_HALFDRAGON_BLUE:
                iSpot+=4;
                iIntimidate+=4;
            break;

            case SUBRACE_HALFDRAGON_GREEN:
                iSpot+=4;
                iIntimidate+=4;
            break;

            case SUBRACE_HALFDRAGON_RED:
                iSpot+=4;
                iIntimidate+=4;
            break;

            case SUBRACE_HALFDRAGON_WHITE:
                iSpot+=4;
                iIntimidate+=4;
            break;

            case SUBRACE_ILLITHID:
                iSpot+=4;
                iConcetration+=4;
                iSpellcraft+=4;
                iLore+=4;
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

    int iImmunityPoison = FALSE;
    int iImmunityParalysis = FALSE;
    int iImmunityDisease = FALSE;
    int iImmunityMind  = FALSE;
    if (GetHasFeat(FEAT_KURTIZANA_IMUNITA_NEMOCI,oPC) == TRUE)
    {
         iImmunityDisease = TRUE;
    }

    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    switch (iSubrace)
    {
        case SUBRACE_HUMAN_DESERT:
        if (iDamageReductionFire < 5) iDamageReductionFire = 5;
        break;

        case SUBRACE_HUMAN_NORDIC:
        if (iDamageReductionCold < 5) iDamageReductionCold = 5;
        break;

        case SUBRACE_HUMAN_AASIMAR:
        if (iDamageReductionCold < 5) iDamageReductionCold = 5;
        if (iDamageReductionElec < 5) iDamageReductionElec = 5;
        iVulnerabilityFire+= 25;
        break;

        case SUBRACE_HUMAN_TIEFLING:
        if (iDamageReductionFire < 5) iDamageReductionFire = 5;
        if (iDamageReductionAcid < 5) iDamageReductionAcid = 5;
        iVulnerabilityCold+= 25;
        break;

        case SUBRACE_DWARF_DUERGAR_BRONZED:
        iImmunityPoison = TRUE;
        iImmunityParalysis = TRUE;
        break;

        case SUBRACE_HALFLING_KOBOLD:
        iImmunityPoison = TRUE;
        iImmunityDisease = TRUE;
        break;

        case SUBRACE_HALFDRAGON_BLACK:
        iImmunityAcid += 20+2*iHD;
        iVulnerabilityCold += 20+2*iHD;
        break;

        case SUBRACE_HALFDRAGON_BLUE:
        iImmunityElec += 20+2*iHD;
        iVulnerabilityAcid += 20+2*iHD;
        break;

        case SUBRACE_HALFDRAGON_GREEN:
        iImmunityAcid += 20+2*iHD;
        iVulnerabilityElec += 20+2*iHD;
        break;

        case SUBRACE_HALFDRAGON_RED:
        iImmunityFire += 20+2*iHD;
        iVulnerabilityCold += 20+2*iHD;
        break;

        case SUBRACE_HALFDRAGON_WHITE:
        iImmunityCold += 20+2*iHD;
        iVulnerabilityFire+= 20+2*iHD;
        break;

        case SUBRACE_ILLITHID:
        iImmunityMind = TRUE;
        break;


    }
    //domeny
    if (GetClericDomain(oPC,1) ==DOMENA_PAVOUCI || GetClericDomain(oPC,2)==DOMENA_PAVOUCI)
    {
        iImmunityPoison = TRUE;
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
    // kompletni imunita
    if (iImmunityPoison)
    {
        ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON);
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iImmunityParalysis)
    {
        ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS);
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iImmunityDisease)
    {
        ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE);
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }
    if (iImmunityMind)
    {
        ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }

    if (GetHasFeat(FEAT_KURTIZANA_JASNE_JAKO_FACKA,oPC) == TRUE)
    {
        ip = ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,IP_CONST_DAMAGESOAK_15_HP);
        SetItemPropertySpellId(ip,IP_DAMAGE_REDUCTION);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
    }



}

void ApplySpellResistance(object oPC, object oPCSkin)
{
    int iSR = 0;
    int iHD = GetHitDice(oPC);
    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    int iBonus = 0;
    if (iSubrace == SUBRACE_ELF_OBSIDIAN_DROW)
    {
       iBonus = iHD /2 +10 ;
       if (iSR < iBonus)
       {
            iSR = iBonus;
       }
    }
    if (iSubrace ==SUBRACE_GNOME_PIXIE)
    {
       iBonus = iHD /2 +10;
       if (iSR < iBonus)
       {
            iSR = iBonus;
       }
    }
    if (iSR >0)
    {
        effect ef =  EffectSpellResistanceIncrease(iSR);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId (eLink,EFFECT_SPELL_RESISTANCE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }

}

/*Bonusy do regenerace*/
void ApplyRegeneration(object oPC, object oPCSkin)
{

    int iRegeneration = 0;
    /*CERNOKNEZNIK Dábelská prunost*/
    if (GetHasFeat(FEAT_CERNOKNEZNI_DABELSKA_PRUZNOST,oPC) == TRUE)
    {
         iRegeneration += (GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,oPC)-8)/5+1;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_1,oPC) == TRUE)
    {
         iRegeneration += 3;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_2,oPC) == TRUE)
    {
         iRegeneration += 3;
    }
    /*Rychle hojeni*/
    if (GetHasFeat(FEAT_EPICGENERAL_RYCHLE_HOJENI_3,oPC) == TRUE)
    {
         iRegeneration += 3;
    }

    if (iRegeneration >0)
    {
        itemproperty eRegen = ItemPropertyRegeneration(iRegeneration);
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
    if (iSubrace == SUBRACE_ELF_WINGED)
    {
       iSpeed+= 20;
    }

    if ((GetLevelByClass(CLASS_TYPE_MONK,oPC))>= 10)
    {
       iSpeed+= 150;
    }

    if (iSpeed >0)
    {
        effect ef =  EffectMovementSpeedIncrease(iSpeed);
        effect eLink = SupernaturalEffect(ef);
        SetEffectSpellId (eLink,EFFECT_SPEED);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

    }
}


