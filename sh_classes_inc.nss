 //::///////////////////////////////////////////////
//:: UPRAVY POVOLANI
//:: sh_classes_inc
//:: //:://////////////////////////////////////////////
/*
   Bonusy na ktere se nevztahuji kategorie


*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:
//:://////////////////////////////////////////////
/*
Pridavam hracum kuzi s tagem th_pl_skin


*/






// Vraci o kolik se zvednou staty pri barbarove rage
int GetBarbarianAbilityBonus(object oPC);

// * Hub function for the epic barbarian feats that upgrade rage. Call from
// * the end of the barbarian rage spellscript
void CheckAndApplyEpicRageFeats(int nRounds);





//------- Includy
//pomocne funkce
#include "ku_skin_inc"
#include "sh_classes_inc_e"
#include "nwnx_funcs"
#include "nwnx_structs"
//vypocet poctu pouziti schopnosti
#include "sh_feat_uses"
//konstanty
#include "sh_classes_const"

//bonusy dle kategorii
#include "sh_class_cat"


//bonusy dle kategorii
#include "sei_subraceslst"







//Zvetsi barbarovy staty
void IncreaseBarbarStats(object oPC,int iAbility)
{
    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;

          int level = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
          SetLocalInt(oSaveItem,AKTIVNI_RAGE,1);
          int base_str = GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
          SetLocalInt(oSaveItem,ULOZENI_SILA_BARBAR,base_str);
          int base_con = GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE);
          SetLocalInt(oSaveItem,ULOZENI_ODOLNOST_BARBAR,base_con);
          ModifyAbilityScore(oPC,ABILITY_STRENGTH,iAbility );
          ModifyAbilityScore(oPC,ABILITY_CONSTITUTION,iAbility);
         // SetLocalInt(oSaveItem,ULOZENI_DOCASNE_ZIVOTY_BARBAR,iAbility*level);
          ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(iAbility*level),oPC);



 }


 //Snizi barbarovy staty
void DecreaseBarbarStats(object oPC)
{
    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;

    if (GetLocalInt(oSaveItem,AKTIVNI_RAGE) == 1)
    {
          int base_str = GetLocalInt(oSaveItem,ULOZENI_SILA_BARBAR);
          int base_con = GetLocalInt(oSaveItem,ULOZENI_ODOLNOST_BARBAR);
          if (base_str != 0) ModifyAbilityScore(oPC,ABILITY_STRENGTH,base_str-GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE));

          if (base_con != 0) ModifyAbilityScore(oPC,ABILITY_CONSTITUTION,base_con-GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE));

          SetLocalInt(oSaveItem,AKTIVNI_RAGE,0);
          SetLocalInt(oSaveItem,ULOZENI_ODOLNOST_BARBAR,0);
          SetLocalInt(oSaveItem,ULOZENI_SILA_BARBAR,0);
          //int damage = GetLocalInt(oSaveItem,ULOZENI_DOCASNE_ZIVOTY_BARBAR);
          //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage),oPC);

    }
 }
//Zvetsi TRPASLICIHO OBRANCE
void IncreaseDefenderStats(object oPC,int iAbility_str, int iAbility_con)
{
    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;

    if (GetLocalInt(oSaveItem,AKTIVNI_POSTOJ_OBRANCE) == 0)
    {
          int level = GetLevelByPosition(1,oPC)+GetLevelByPosition(2,oPC)+GetLevelByPosition(3,oPC);
          SetLocalInt(oSaveItem,AKTIVNI_POSTOJ_OBRANCE,1);
          int base_str = GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
          SetLocalInt(oSaveItem,ULOZENI_SILA_OBRANCE,base_str);
          int base_con = GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE);

          SetLocalInt(oSaveItem,ULOZENI_ODOLNOST_OBRANCE,base_con);
          ModifyAbilityScore(oPC,ABILITY_STRENGTH,iAbility_str );
          ModifyAbilityScore(oPC,ABILITY_CONSTITUTION,iAbility_con);
          //SetLocalInt(oSaveItem,ULOZENI_DOCASNE_ZIVOTY_OBRANCE,iAbility_con*level);
          //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(iAbility_con*level),oPC);


    }
 }


 //Snizi staty TRPASLICIHO OBRANCE
void DecreaseDefenderStats(object oPC)
{
    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;

    if (GetLocalInt(oSaveItem,AKTIVNI_POSTOJ_OBRANCE) == 1)
    {
          int base_str = GetLocalInt(oSaveItem,ULOZENI_SILA_OBRANCE);
          int base_con = GetLocalInt(oSaveItem,ULOZENI_ODOLNOST_OBRANCE);

            if (base_str != 0) ModifyAbilityScore(oPC,ABILITY_STRENGTH,base_str-GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE));

          if (base_con != 0) ModifyAbilityScore(oPC,ABILITY_CONSTITUTION,base_con-GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE));


          SetLocalInt(oSaveItem,AKTIVNI_POSTOJ_OBRANCE,0);
          SetLocalInt(oSaveItem,ULOZENI_ODOLNOST_OBRANCE,0);
          SetLocalInt(oSaveItem,ULOZENI_SILA_OBRANCE,0);
          //int damage = GetLocalInt(oSaveItem,ULOZENI_DOCASNE_ZIVOTY_OBRANCE);
          //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage),oPC);


    }
 }

// aplikuje imunitu barbara
void ApplyBarbarianDamageReduction(object oPC)
{
    if (GetHasFeat(FEAT_SNIZENI_ZRANENI_BARBAR,oPC) == TRUE)
    {
        int iBonus = 0;
        if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_3,oPC) == TRUE)
        {
            iBonus = 30;
        }
        else if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_2,oPC) == TRUE)
        {
            iBonus = 20;
        }
        else if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_1,oPC) == TRUE)
        {
            iBonus = 10;
        }
        int iLvL = GetLevelByClass (CLASS_TYPE_BARBARIAN,oPC)+1;

                if (iLvL > 20)
                   {
                    iLvL = 20;
                   }


        //pridani imunuty na tupe
        effect ef1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,iLvL+iBonus);
         //pridani imunuty na bodne
        effect ef2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,iLvL+iBonus);
         //pridani imunuty na tupe
        effect ef3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,iLvL+iBonus);
        effect eLink = EffectLinkEffects(ef1,ef2);
               eLink =  EffectLinkEffects(eLink,ef3);
               eLink = SupernaturalEffect(eLink);

        SetEffectSpellId(eLink,EFFECT_BARBAR_SNIZENI_ZRANENI);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }
}
/*
Shodi Kensaiovi Itemy pokud si oblece zbroj, stit nebo helmu
*/


/*
Nastavi SD Zrak stinu
*/
void ApplyShadowDancerZrak(object oPC)
{
    //odstraneni efektu
    if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) >= 1)
    {
        effect eLink = EffectUltravision();
        eLink = SupernaturalEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_SD_ZRAK);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }

}


void ApplyNewMonkPerfectSelf(object oPC, object oPCSkin)
{
    //odstraneni efektu
    if (GetLevelByClass(CLASS_TYPE_MONK,oPC) >= 19)
    {

        int iEnch;
        // IMUNITA NA MIND SPELLY
        itemproperty ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
        SetItemPropertySpellId(ip,IP_NEWPERFECTSELF);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        //POHLCENI


            if (GetHasFeat(FEAT_NEWPERFECTSELF5,oPC))
            {
             iEnch =IP_CONST_DAMAGEREDUCTION_5;
            }

            else if (GetHasFeat(FEAT_NEWPERFECTSELF4,oPC))
            {
             iEnch =IP_CONST_DAMAGEREDUCTION_4;
            }

            else if (GetHasFeat(FEAT_NEWPERFECTSELF3,oPC))
            {
             iEnch =IP_CONST_DAMAGEREDUCTION_3;
            }

            else if (GetHasFeat(FEAT_NEWPERFECTSELF2,oPC))
            {
             iEnch =IP_CONST_DAMAGEREDUCTION_2;
            }
            else
            {
             iEnch =IP_CONST_DAMAGEREDUCTION_1;
            }

        itemproperty ip1 = ItemPropertyDamageReduction(iEnch,IP_CONST_DAMAGESOAK_20_HP);
        SetItemPropertySpellId(ip1,IP_NEWPERFECTSELF);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip1,oPCSkin,99999.0);




    }

}
int GetIsPCValid(object oPC)
{
    int iSkill = GetPCSkillPoints(oPC);
    int iRace = GetRacialType(oPC);
    if (iSkill != (8+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)+(iRace == RACIAL_TYPE_HUMAN))*4)
    {
        return FALSE;
    }
    if (GetClassByPosition(1,oPC)!=CLASS_TYPE_ROGUE)
    {
        return FALSE;
    }
    if ((GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM,oPC)) ||
    (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY,oPC)) ||
    (GetHasFeat(FEAT_SHIELD_PROFICIENCY,oPC)) ||
    (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MARTIAL,oPC))
    )
    {
        return FALSE;
    }
    return TRUE;
}




/*
Pokud je to prvni lvl odstrani featy zlodeje a nastavi spravne parametry postave
*/
void RepairObcanThalie(object oPC)
{
   object oSaveItem = GetSoulStone(oPC);

   if (GetLocalInt(oSaveItem,OBCAN_THALIE) == 0)
   {

       RemoveKnownFeat(oPC,FEAT_SNEAK_ATTACK);
       RemoveKnownFeat(oPC,FEAT_WEAPON_PROFICIENCY_ROGUE);
       RemoveKnownFeat(oPC,FEAT_ARMOR_PROFICIENCY_LIGHT);
       SetLocalInt(oSaveItem,OBCAN_THALIE,1);
   }

}
/*Prida zbran onhit property - zbran thalie*/
void AddZbranThalie(object oPC,object oItem)
{


        //zhozeni stitu
        int iType =GetBaseItemType(oItem);
        int iWeaponType = StringToInt(Get2DAString("baseitems","WeaponType",iType));
        if(iWeaponType > 0) {

            itemproperty ipLoop = GetFirstItemProperty(oItem);
            while (GetIsItemPropertyValid(ipLoop))
            {
                if (GetItemPropertyType(ipLoop)== ITEM_PROPERTY_ONHITCASTSPELL)
                {
                    RemoveItemProperty(oItem,ipLoop);
                }
                ipLoop = GetNextItemProperty(oItem);
            }

            itemproperty ipZbranThalie = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_THALIJSKA_ZBRAN,10);
            SetItemPropertySpellId(ipZbranThalie,IP_ZBRAN_THALIE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipZbranThalie,oItem);
        }
}
/*Odstrani zbran onhit property - zbran thalie - pri unequipu*/
void RemoveZbranThalie(object oPC,object oItem)
{



            itemproperty ipLoop = GetFirstItemProperty(oItem);
            while (GetIsItemPropertyValid(ipLoop))
            {
                if (GetItemPropertyType(ipLoop)== ITEM_PROPERTY_ONHITCASTSPELL)
                {
                    RemoveItemProperty(oItem,ipLoop);
                }
                ipLoop = GetNextItemProperty(oItem);
            }



}
void SetRangerNaturalSkills (object oPC,object oArea)
{
    int iRangerLevel = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
    if (iRangerLevel >= 0)
    {
        int iEffect;
        effect eLoop = GetFirstEffect(oPC);
        while (GetIsEffectValid(eLoop))
        {
            iEffect = GetEffectSpellId(eLoop);
            if (iEffect== EFFECT_RANGER_NATURAL_SKILLS)
            {
                RemoveEffect(oPC,eLoop);
            }
            eLoop = GetNextEffect(oPC);
        }
        if (GetIsAreaNatural(oArea))
        {
            int iBonus = (((iRangerLevel - 14)/5)+1)*2;
            effect ef1 = EffectSkillIncrease(SKILL_MOVE_SILENTLY,iBonus);
            effect ef2 = EffectSkillIncrease(SKILL_HIDE,iBonus);
            effect eLink = EffectLinkEffects(ef1,ef2) ;
            eLink = SupernaturalEffect(eLink);
            SetEffectSpellId(eLink,EFFECT_RANGER_NATURAL_SKILLS);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
        }



    }



}

void RefreshOnEquipSpecialBonuses(object oPC,int iEquip)
{
    int iSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC) ;
    int iEffect;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop))
    {
        iEffect = GetEffectSpellId(eLoop);
        if ((iEffect== EFFECT_BRUTALNI_VRH) || (iEffect==EFFECT_SPRAVEDLIVY_UDER) || (iEffect==EFFECT_EXOR_DAMAGE_DIVINE))
        {
            RemoveEffect(oPC,eLoop);
        }
        eLoop = GetNextEffect(oPC);
    }
    if (iEquip)
    {
        int iItemTypeM = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC));
        if ((GetHasFeat(FEAT_EPICGENERAL_BRUTALNI_VRH,oPC) == TRUE) && ((iItemTypeM == BASE_ITEM_DART)||(iItemTypeM == BASE_ITEM_THROWINGAXE)||(iItemTypeM == BASE_ITEM_SHURIKEN) ))
        {

            effect eLink = EffectAttackIncrease(iSTR);
            eLink = SupernaturalEffect(eLink);
            SetEffectSpellId(eLink,EFFECT_BRUTALNI_VRH);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
        }
        if ((GetHasFeat(EFFECT_SPRAVEDLIVY_UDER,oPC) == TRUE) && (iItemTypeM == BASE_ITEM_INVALID) )
        {

            effect eLink = EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_DIVINE);
            eLink = VersusAlignmentEffect(eLink,ALIGNMENT_CHAOTIC);
            eLink = SupernaturalEffect(eLink);
            SetEffectSpellId(eLink,EFFECT_SPRAVEDLIVY_UDER);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
        }
            /*Exorcistuv dmg divine*/
        if (GetHasFeat(FEAT_EXORCISTA_ZHOUBA_ZLA,oPC))
        {
         int iWis = GetAbilityModifier(ABILITY_WISDOM,oPC);
         int iDamage = GetDamageBonusByValue(iWis);
         effect ef = EffectDamageIncrease(iDamage,DAMAGE_TYPE_DIVINE);
         effect eEvil = VersusAlignmentEffect(ef,ALIGNMENT_ALL,ALIGNMENT_EVIL);
         effect eLink = EffectLinkEffects(ef, eEvil);
         eLink = SupernaturalEffect(eLink);
         SetEffectSpellId(eLink,EFFECT_EXOR_DAMAGE_DIVINE);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

        }
        
               
    }
}

void ApplyFeats(object oPC)
{
    int iSubrace = Subraces_GetCharacterSubrace(oPC);
    // Let
    if ((iSubrace == SUBRACE_ELF_WINGED) ||
    (iSubrace == SUBRACE_HALFDRAGON_BLACK) ||
    (iSubrace == SUBRACE_HALFDRAGON_BLUE) ||
    (iSubrace == SUBRACE_HALFDRAGON_GREEN) ||
    (iSubrace == SUBRACE_HALFDRAGON_RED) ||
    (iSubrace == SUBRACE_HALFDRAGON_WHITE)||
    (iSubrace == SUBRACE_HUMAN_AASIMAR) ||
    (iSubrace == SUBRACE_HUMAN_TIEFLING))
    {
        RemoveKnownFeat(oPC,FEAT_SUBRACE_LET);
        if (GetHitDice(oPC)>= 21)
        {
            AddKnownFeat(oPC,FEAT_SUBRACE_LET,21);
        }
    }
    // elf
    if (GetHasFeat(FEAT_SKILL_AFFINITY_LISTEN,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_LISTEN);
    }
    if (GetHasFeat(FEAT_SKILL_AFFINITY_SEARCH,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_SEARCH);
    }
    if (GetHasFeat(FEAT_SKILL_AFFINITY_SPOT,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_SPOT);
    }
    if (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ELF,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_WEAPON_PROFICIENCY_ELF);
    }
    if ((GetHasFeat(FEAT_IMMUNITY_TO_SLEEP,oPC)) && ((iSubrace == SUBRACE_ELF_DROW) ||
    (iSubrace == SUBRACE_ELF_OBSIDIAN_DROW)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_IMMUNITY_TO_SLEEP);
    }
    // trpaslik
    if (GetHasFeat(FEAT_STONECUNNING,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_STONECUNNING);
    }
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_POISONS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_HARDINESS_VERSUS_POISONS);
    }
    if (GetHasFeat(FEAT_SKILL_AFFINITY_LORE,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_LORE);
    }
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_GIANTS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_BATTLE_TRAINING_VERSUS_GIANTS);
    }
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_GOBLINS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_BATTLE_TRAINING_VERSUS_GOBLINS);
    }
        if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_ORCS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_BATTLE_TRAINING_VERSUS_ORCS);
    }
    // pulcik
    if (GetHasFeat(FEAT_SKILL_AFFINITY_MOVE_SILENTLY,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_MOVE_SILENTLY);
    }
    if ((GetHasFeat(FEAT_LUCKY,oPC)) && ((iSubrace == SUBRACE_HALFLING_KOBOLD)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_LUCKY);
    }
    if ((GetHasFeat(FEAT_FEARLESS,oPC)) && ((iSubrace == SUBRACE_HALFLING_KOBOLD)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_FEARLESS);
    }
    if ((GetHasFeat(FEAT_GOOD_AIM,oPC)) && ((iSubrace == SUBRACE_HALFLING_KOBOLD)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_GOOD_AIM);
    }
    // gnom
    if (GetHasFeat(FEAT_BATTLE_TRAINING_VERSUS_REPTILIANS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_BATTLE_TRAINING_VERSUS_REPTILIANS);
    }
    if (GetHasFeat(FEAT_SKILL_AFFINITY_CONCENTRATION,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_SKILL_AFFINITY_CONCENTRATION);
    }
    if ((GetHasFeat(FEAT_HARDINESS_VERSUS_ILLUSIONS,oPC)) && ((iSubrace == SUBRACE_GNOME_GOBLIN_DEEP) ||
    (iSubrace == SUBRACE_GNOME_PIXIE)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_HARDINESS_VERSUS_ILLUSIONS);
    }
    if ((GetHasFeat(FEAT_SPELL_FOCUS_ILLUSION,oPC)) && ((iSubrace == SUBRACE_GNOME_GOBLIN_DEEP) ||
    (iSubrace == SUBRACE_GNOME_PIXIE)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_SPELL_FOCUS_ILLUSION);
    }
    // pulelf
    if (GetHasFeat(FEAT_HARDINESS_VERSUS_ENCHANTMENTS,oPC))
    {
        RemoveKnownFeat(oPC,FEAT_HARDINESS_VERSUS_ENCHANTMENTS);
    }
    if ((GetHasFeat(FEAT_IMMUNITY_TO_SLEEP,oPC)) && ((iSubrace == SUBRACE_HALFDRAGON_BLACK) ||
    (iSubrace == SUBRACE_HALFDRAGON_BLUE) ||
    (iSubrace == SUBRACE_HALFDRAGON_GREEN) ||
    (iSubrace == SUBRACE_HALFDRAGON_RED) ||
    (iSubrace == SUBRACE_HALFDRAGON_WHITE) ||
    (iSubrace == SUBRACE_ILLITHID)
    ))
    {
        RemoveKnownFeat(oPC,FEAT_IMMUNITY_TO_SLEEP);
    }
    if ((GetHasFeat(FEAT_KEEN_SENSE,oPC) == FALSE) && ((iSubrace == SUBRACE_HALFELF)))
    {
        AddKnownFeat(oPC,FEAT_KEEN_SENSE);
    }
    // General feats for all
    if (!GetHasFeat(FEAT_GENERAL_SEBRAT, oPC))
        AddKnownFeat(oPC, FEAT_GENERAL_SEBRAT);
    if (!GetHasFeat(FEAT_GENERAL_POUZIT, oPC))
        AddKnownFeat(oPC, FEAT_GENERAL_POUZIT);
    if (!GetHasFeat(FEAT_GENERAL_TARGET, oPC))
        AddKnownFeat(oPC, FEAT_GENERAL_TARGET);
    if (!GetHasFeat(FEAT_HORSE_MENU, oPC))
        AddKnownFeat(oPC, FEAT_HORSE_MENU);
}


//Odstrani efekty postoje trpasliciho obrance
void DD_RemoveStance(object oPC,object oSoulStone)
{
    effect eLoop=GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop))
    {
        if (GetEffectSpellId(eLoop)==EFFECT_TRPASLICI_OBRANCE_POSTOJ)
        {
            RemoveEffect(oPC, eLoop);
        }
        eLoop=GetNextEffect(oPC);

    }
    itemproperty ipLoop=GetFirstItemProperty(oSoulStone);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if ((GetItemPropertySpellId(ipLoop)==IP_DD_STANCE) || (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_WEIGHT_INCREASE))
        {

            RemoveItemProperty(oSoulStone, ipLoop);
        }
        ipLoop=GetNextItemProperty(oSoulStone);

    }
    DecreaseDefenderStats(oPC);
    SendMessageToPC(oPC,"Obrany postoj deaktivovan!");
}

//Nastavi promenne na postavu tak aby bylo mozne brat prestizni povolani
void ApplyClassConditions(object oPC)
{
    //kontrola rasy u AA
    int iRace = GetRacialType(oPC);
    if (((iRace == RACIAL_TYPE_HALFELF) &&  Subraces_GetCharacterSubrace(oPC)==SUBRACE_HALFELF)   ||
       (iRace == RACIAL_TYPE_ELF))
       {
            SetLocalInt(oPC,"X1_AllowArcher",1);
       }

}
//Odstrani featy - pro rizeni specialnich schopnosti na konkretnich lvlech
void RemoveClassFeats(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_DRUID,oPC) >=8)
    {
        RemoveKnownFeat(oPC,FEAT_DRUID_SPECIALIZACE_VYBER);
    }
}


//------------------------------------------------------------------------------
// GZ, 2003-07-09
// Hub function for the epic barbarian feats that upgrade rage. Call from
// the end of the barbarian rage spellscript
//------------------------------------------------------------------------------
void CheckAndApplyEpicRageFeats(int nRounds)
{

	effect eAOE;
    if ((GetHasFeat(989, OBJECT_SELF)) && (GetHasFeat(988, OBJECT_SELF)))
    {
     eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"cl_barb_terrage", "cl_barb_thunrage","****");
     eAOE = ExtraordinaryEffect(eAOE);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,OBJECT_SELF,RoundsToSeconds(nRounds));
    }

    else if (GetHasFeat(989, OBJECT_SELF))
    {
     eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"cl_barb_terrage", "****","****");
     eAOE = ExtraordinaryEffect(eAOE);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,OBJECT_SELF,RoundsToSeconds(nRounds));
    }

    else if (GetHasFeat(988, OBJECT_SELF))
    {
     eAOE = EffectAreaOfEffect(AOE_MOB_FEAR,"****", "cl_barb_thunrage","****");
     eAOE = ExtraordinaryEffect(eAOE);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAOE,OBJECT_SELF,RoundsToSeconds(nRounds));
    }
	
	
	
}



///***------------------------------------------------------------------------------------------------------------------
/*
Globalni metody pro zakladni eventy
*/



void OnEnterFirstLocation(object oPC)
{
  //RepairObcanThalie(oPC);
}

void OnEnterArea(object oPC,object oArea)
{
   SetRangerNaturalSkills (oPC,oArea);

}




void OnLvlupClassSystem(object oPC)
{
   //volani kuze postavy musi byt v kratke chvili jen jednou jinak hrozi jeji duplikovani
   object oDuse = GetSoulStone(oPC);
   object oPCSkin = GetPCSkin(oPC);
   //vymazani bonusu
   RemoveClassItemPropertyAndEffects(oPC,oPCSkin);
   RemoveClassFeats(oPC);
   //  puvodni
   ApplyBarbarianDamageReduction(oPC);  //effekt
   ApplyShadowDancerZrak(oPC);//effekt
   ApplyNewMonkPerfectSelf(oPC,oPCSkin);
   // nove
   AddSkillIPBonuses(oPC,oPCSkin);
   ApplyAB_AC_DMGBonus(oPC,oPCSkin);
   RefreshBonusACNaturalBase(oPC,oPCSkin);
   ApplyBonusSaves(oPC,oPCSkin);
   ApplyRegeneration(oPC,oPCSkin);
   ApplyConcealment(oPC,oPCSkin);
   ApplySpeed(oPC,oPCSkin);
   ApplyDamageReduction(oPC,oPCSkin);
   ApplySpellResistance(oPC,oPCSkin);
   ApplyFeats(oPC);
   // nastaveni poctu featu na den
   RestoreFeatUses(oPC);



}

void OnRestClassSystem(object oPC)
{
   DecreaseBarbarStats(oPC);
   DecreaseDefenderStats(oPC);
   RestoreFeatUses(oPC);
   object oSoul = GetSoulStone(oPC);
   SetLocalInt(oSoul,"RACIAL_ABILITY",1);
   DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK");
   DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");

}

void OnEquipClassSystem(object oPC, object oItem)
{
  object oDuse = GetSoulStone(oPC);
   object oPCSkin = GetPCSkin(oPC);

 AddZbranThalie(oPC,oItem);
 RefreshBonusACNaturalBase(oPC,oPCSkin);
 RefreshOnEquipSpecialBonuses(oPC,1);
}

void OnUnEquipClassSystem(object oPC,object oItem)
{
    object oDuse = GetSoulStone(oPC);
    object oPCSkin = GetPCSkin(oPC);


    RemoveZbranThalie(oPC,oItem);
    RefreshBonusACNaturalBase(oPC,oPCSkin);
    RefreshOnEquipSpecialBonuses(oPC,0);

}

void OnDeathClassSystem(object oPC)
{
  DeleteLocalInt(oPC,"UderDoTepny"); //zruseni ucinku krvaceni
  DeleteLocalString(oPC,"OZNACEN"); //odstraneni znacky assassina
  DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK");
  DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK_TARGET");
  DecreaseBarbarStats(oPC);
  DecreaseDefenderStats(oPC);
}

void OnEnterClassSystem(object oPC)
{
    //ReequipSkin(oPC);
    ApplyClassConditions(oPC);
    ApplyFeats(oPC);
    DeleteLocalString(oPC,"OZNACEN"); //odstraneni znacky assassina
    DeleteLocalInt(oPC,"UderDoTepny"); //zruseni ucinku krvaceni
    DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK");
    DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK_TARGET");
    object oSoul = GetSoulStone(oPC);
    DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");
    DecreaseBarbarStats(oPC);
    DecreaseDefenderStats(oPC);
    OnLvlupClassSystem(oPC);

 }

