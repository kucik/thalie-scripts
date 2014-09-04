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
          object oSaveItem = GetSoulStone(oPC);
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
    object oSaveItem = GetSoulStone(oPC);

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
    object oSaveItem = GetSoulStone(oPC);

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
    object oSaveItem = GetSoulStone(oPC);

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
        int bonus = 0;
        if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_1,oPC) == TRUE)
        {
            bonus = 5;
        }
        if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_2,oPC) == TRUE)
        {
            bonus = 10;
        }
        if (GetHasFeat(FEAT_EPICKE_SNIZENI_ZRANENI_BARBAR_3,oPC) == TRUE)
        {
            bonus = 15;
        }
        int lvl = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC);
        //pridani imunuty na tupe
        effect ef1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,lvl+bonus);
         //pridani imunuty na bodne
        effect ef2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,lvl+bonus);
         //pridani imunuty na tupe
        effect ef3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,lvl+bonus);
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


void ApplyKensaiLimitation(object oPC,object oItem)
{
    return;
    int sundani =FALSE;
    if (GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC) > 0)
    {
        //zhozeni stitu
        if ((GetBaseItemType(oItem) == BASE_ITEM_TOWERSHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_LARGESHIELD) || (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD))
        {
            sundani = TRUE;
        }

        //zhozeni zbroje
        if (GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
        {
             if (GetArcaneSpellFailure(oPC)>0)sundani = TRUE;
        }

        //samotne zhozeni
        if (sundani == TRUE)
        {
            AssignCommand(oPC,ActionUnequipItem(oItem));
         }
    }
}

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
    if (GetHasFeat(FEAT_NEWPERFECTSELF,oPC) == TRUE)
    {

        int lvl = GetLevelByClass(CLASS_TYPE_MONK,oPC);
        int iBonus = ((lvl-19) /10)+1;
        int iEnch;
        // IMUNITA NA MIND SPELLY
        itemproperty ip = ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS);
        SetItemPropertySpellId(ip,IP_NEWPERFECTSELF);
        AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oPCSkin,99999.0);
        //POHLCENI
        switch (iBonus)
        {
            case 1:
            iEnch =IP_CONST_DAMAGEREDUCTION_1;
            break;
            case 2:
            iEnch =IP_CONST_DAMAGEREDUCTION_2;
            break;
            case 3:
            iEnch =IP_CONST_DAMAGEREDUCTION_3;
            break;
            default:
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
        if (
        (iType == BASE_ITEM_BASTARDSWORD) || (iType == BASE_ITEM_BATTLEAXE) || (iType == BASE_ITEM_DAGGER)
        || (iType == BASE_ITEM_DART)|| (iType == BASE_ITEM_DIREMACE)|| (iType == BASE_ITEM_DOUBLEAXE)
        || (iType == BASE_ITEM_DWARVENWARAXE)|| (iType == BASE_ITEM_GREATAXE)|| (iType == BASE_ITEM_GREATSWORD)
        || (iType == BASE_ITEM_HALBERD)|| (iType == BASE_ITEM_HANDAXE)|| (iType == BASE_ITEM_HEAVYCROSSBOW)
        || (iType == BASE_ITEM_HEAVYFLAIL)|| (iType == BASE_ITEM_KAMA)|| (iType == BASE_ITEM_KATANA)
        || (iType == BASE_ITEM_KUKRI)|| (iType == BASE_ITEM_LIGHTCROSSBOW)|| (iType == BASE_ITEM_LIGHTFLAIL)
        || (iType == BASE_ITEM_LIGHTHAMMER)|| (iType == BASE_ITEM_LIGHTMACE)|| (iType == BASE_ITEM_LONGBOW)
        || (iType == BASE_ITEM_LONGSWORD)|| (iType == BASE_ITEM_MAGICSTAFF)|| (iType == BASE_ITEM_MORNINGSTAR)
        || (iType == BASE_ITEM_QUARTERSTAFF)|| (iType == BASE_ITEM_RAPIER)|| (iType == BASE_ITEM_SCIMITAR)
        || (iType == BASE_ITEM_SCYTHE)|| (iType == BASE_ITEM_SHORTBOW)|| (iType == BASE_ITEM_SHORTSPEAR)
        || (iType == BASE_ITEM_SHORTSWORD)|| (iType == BASE_ITEM_SHURIKEN)|| (iType == BASE_ITEM_SICKLE)
        || (iType == BASE_ITEM_SLING)|| (iType == BASE_ITEM_THROWINGAXE)|| (iType == BASE_ITEM_TRIDENT)
        || (iType == BASE_ITEM_TWOBLADEDSWORD) || (iType == BASE_ITEM_WARHAMMER) || (iType == BASE_ITEM_WHIP)
        || (iType == 202)// Social_Beermug
        || (iType ==203)// Short Spear
          || (iType ==300)// Trident 1h
          || (iType ==301)// Heavypick
          || (iType ==302)// Lightpick
          || (iType ==303)// Sai (vidlicka)
          || (iType ==304)// Nunchaku
          || (iType ==305)// Falchion
          || (iType ==308)// Sap (Pytlik)
          || (iType ==309)// Daggerassassin
          || (iType ==310)// Katar
          || (iType ==317)// Heavy mace
          || (iType ==318)// Maul
          || (iType ==319)// Mercurial_longsword
          || (iType ==320)// Mercurial_greatsword
          || (iType ==321)// Scimitar double
          || (iType ==322)// Goad (halapartma)
          || (iType ==323)// Windfirewheel
          || (iType ==324)// MauDoubleSword
        )
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
        if (iEffect== EFFECT_BRUTALNI_VRH || iEffect==EFFECT_SPRAVEDLIVY_UDER)
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

 ApplyKensaiLimitation( oPC,oItem);
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

