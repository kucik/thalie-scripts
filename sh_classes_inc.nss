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

int ModifyHealForPalemaster(object oPaleMaster,int iHealValue)
{
    float fPercentLoose = 25.0;                  //Zakladni ztrata 25%
    //Za kazde epicke kouzlo zvysit o 10%

    //
    if (fPercentLoose >  100.0)   fPercentLoose =  100.0;
    SendMessageToPC(oPaleMaster,"Ucinek leceni snizen o "+IntToString(FloatToInt(fPercentLoose)) +"%.");
    return FloatToInt(iHealValue * (100.0- fPercentLoose)/100.0);
}

void ApplyExorcistBonuses(object oPC)
{
    int iLevel = GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
    if (GetHasFeat(FEAT_EXORCISTA_POZEHNANE_VIDENI,oPC))
    {
        effect eUlt = EffectUltravision();
        effect eSee = EffectSeeInvisible();
        effect eLink = EffectLinkEffects(eUlt,eSee);
        eLink = SupernaturalEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_EXORCISTA_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }
    //domeny
    if (GetHasDomain(oPC,DOMAIN_SEN))
    {
        effect eLink = EffectImmunity(IMMUNITY_TYPE_FEAR);
        eLink = SupernaturalEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_EXORCISTA_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }
    if (GetHasDomain(oPC,DOMAIN_PULCIK))
    {
        effect eLink = EffectRegenerate(2,6.0);
        eLink = SupernaturalEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_EXORCISTA_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
    }
}

void ApplyRedDragonBonuses(object oPC)
{
    int iRDDLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE_NEW,oPC);
    if (iRDDLevel<=0) return;

    int iReductionBonus;
    int iStr = 0;
    int iCon = 0;
    int iInt = 0;
    int iCha = 0;

    if (iRDDLevel ==20)
    {
        iReductionBonus = 25;
    }
    else if (iRDDLevel >= 15)
    {
        iReductionBonus = 20;
    }
    else if (iRDDLevel >=10)
    {
        iReductionBonus = 15;
     }
    else if (iRDDLevel >= 5)
    {
        iReductionBonus = 10;
    }
    else
    {
        iReductionBonus = 5;
    }
    //Vlastnosti
    if (iRDDLevel>=2)
    {
        iStr+=2;
    }
    if (iRDDLevel>=4)
    {
        iStr+=2;
    }
    if (iRDDLevel>=7)
    {
        iCon+=2;
    }
    if (iRDDLevel>=9)
    {
        iInt+=2;
    }
    if (iRDDLevel>=10)
    {
        iStr+=4;
        iCha+=2;
    }
    effect ef =  EffectDamageReduction(iReductionBonus,DAMAGE_POWER_PLUS_FIVE);
    ef = SupernaturalEffect(ef);
    SetEffectSpellId(ef,EFFECT_RED_DRAGON);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);

    if (iStr>=0)
    {
        ef =  EffectAbilityIncrease(ABILITY_STRENGTH,iStr);
        ef = SupernaturalEffect(ef);
        SetEffectSpellId(ef,EFFECT_RED_DRAGON);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);
    }
    if (iCon>=0)
    {
        ef =  EffectAbilityIncrease(ABILITY_CONSTITUTION,iCon);
        ef = SupernaturalEffect(ef);
        SetEffectSpellId(ef,EFFECT_RED_DRAGON);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);
    }
    if (iInt>=0)
    {
        ef =  EffectAbilityIncrease(ABILITY_INTELLIGENCE,iInt);
        ef = SupernaturalEffect(ef);
        SetEffectSpellId(ef,EFFECT_RED_DRAGON);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);
    }
    if (iCha>=0)
    {
        ef =  EffectAbilityIncrease(ABILITY_CHARISMA,iCha);
        ef = SupernaturalEffect(ef);
        SetEffectSpellId(ef,EFFECT_RED_DRAGON);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);
    }
    if (iRDDLevel>=9)
    {
        SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,oPC);
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


void RefreshOnEquipSpecialBonuses(object oPC,int iEquip)
{
    int iSTR = GetAbilityModifier(ABILITY_STRENGTH,oPC) ;
    int iEffect;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop))
    {
        iEffect = GetEffectSpellId(eLoop);
        if ((iEffect==EFFECT_EXOR_DAMAGE_DIVINE) || (iEffect==EFFECT_TWOHANDED_2AB) || (iEffect==EFFECT_PRESNY_BOD))
        {
            RemoveEffect(oPC,eLoop);
        }
        eLoop = GetNextEffect(oPC);
    }
    if (iEquip)
    {
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int iBaseItem = GetBaseItemType(oItem);
        /*Exorcistuv dmg divine*/
        if (GetHasFeat(FEAT_EXORCISTA_ZHOUBA_ZLA,oPC))
        {
         //Zakazane zbrane - luk, prak, vrhaci sekera, shuriken, vrhaci sipka
         if (
              (iBaseItem != BASE_ITEM_LONGBOW) &&
              (iBaseItem != BASE_ITEM_SHORTBOW) &&
              (iBaseItem != BASE_ITEM_SHURIKEN) &&
              (iBaseItem != BASE_ITEM_DART) &&
              (iBaseItem != BASE_ITEM_THROWINGAXE))
         {
             int iWis = GetAbilityModifier(ABILITY_WISDOM,oPC);
             int iLevel = GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
             if (iWis > iLevel) iWis = iLevel;
             int iDamage = GetDamageBonusByValue(iWis);
             effect ef = EffectDamageIncrease(iDamage,DAMAGE_TYPE_DIVINE);
             effect eLink = SupernaturalEffect(ef);
             SetEffectSpellId(eLink,EFFECT_EXOR_DAMAGE_DIVINE);
             ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
         }

        }
        if (GetIsObjectValid(oItem))
        {
            if (GetIsTwoHandedWeapon(oPC, iBaseItem))
            {
                effect ef = EffectAttackIncrease(2);
                effect eLink = SupernaturalEffect(ef);
                SetEffectSpellId(eLink,EFFECT_TWOHANDED_2AB);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

            }

            if (
              (iBaseItem == BASE_ITEM_LONGSWORD) ||
              (iBaseItem == BASE_ITEM_SHORTSWORD) ||
              (iBaseItem == BASE_ITEM_RAPIER) ||
              (iBaseItem == BASE_ITEM_DAGGER))
            {
                int iCasterLevel = GetLevelByClass(CLASS_TYPE_SERMIR,oPC);
                effect ef = EffectDamageIncrease(iCasterLevel/5 +1,DAMAGE_TYPE_PIERCING);
                effect eLink = SupernaturalEffect(ef);
                SetEffectSpellId(eLink,EFFECT_PRESNY_BOD);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
            }
        }



    }
}

//Nastavi promenne na postavu tak aby bylo mozne brat prestizni povolani
void ApplyClassConditions(object oPC)
{
    //kontrola rasy u AA
    int iRace = GetRacialType(oPC);
    if (((iRace == RACIAL_TYPE_HALFELF) &&  Subraces_GetCharacterSubrace(oPC)==NT2_SUBRACE_HALFELF)   ||
       (iRace == RACIAL_TYPE_ELF))
    {
        SetLocalInt(oPC,"X1_AllowArcher",1);
    }
    //kontrola pro SD
    if (
    (GetHasFeat(FEAT_DODGE,oPC))   &&
    (GetHasFeat(FEAT_MOBILITY,oPC))   &&
    (GetSkillRank(SKILL_HIDE,oPC,TRUE)>=10) &&
    (GetSkillRank(SKILL_MOVE_SILENTLY,oPC,TRUE)>=8) &&
    (GetSkillRank(SKILL_TUMBLE,oPC,TRUE)>=5)
    )
    {
        SetLocalInt(oPC,"X1_AllowShadow",1);
    }
    else if (GetHasDomain(oPC,DOMAIN_TEMNOTA))
    {
        SetLocalInt(oPC,"X1_AllowShadow",1);
    }
    else
    {
        SetLocalInt(oPC,"X1_AllowShadow",0);
    }
    SetLocalInt(oPC,"X2_AllowPixie",1);      //Nesmi pixie
    if (Subraces_GetCharacterSubrace(oPC)==NT2_SUBRACE_GNOME_PIXIE)
    {
        if (GetLevelByClass(CLASS_TYPE_PIXIE,oPC)>0)
        {
            SetLocalInt(oPC,"AllowBase",0);          //Muze zakladni classy
            SetLocalInt(oPC,"X2_AllowPixie",1);      //Nesmi pixie
        }
        else
        {
            SetLocalInt(oPC,"AllowBase",1);          //Nesmi zakladni classy
            SetLocalInt(oPC,"X2_AllowPixie",0);      //Mussi pixie
        }
    }
}





///***------------------------------------------------------------------------------------------------------------------
/*
Globalni metody pro zakladni eventy
*/



void OnEnterFirstLocation(object oPC)
{

}

void OnEnterArea(object oPC,object oArea)
{


}




void OnLvlupClassSystem(object oPC)
{
   //volani kuze postavy musi byt v kratke chvili jen jednou jinak hrozi jeji duplikovani
   object oDuse = GetSoulStone(oPC);
   object oPCSkin = GetPCSkin(oPC);
   ApplyClassConditions(oPC);
   //vymazani bonusu
   RemoveClassItemPropertyAndEffects(oPC,oPCSkin);
   //  puvodni
   ApplyExorcistBonuses(oPC);
   // nove
   AddSkillIPBonuses(oPC,oPCSkin);
   ApplyAB_AC_DMGBonus(oPC,oPCSkin);
   RefreshBonusACNaturalBase(oPC,oPCSkin);
   ApplyBonusSaves(oPC,oPCSkin);
   ApplyRegeneration(oPC,oPCSkin);
   ApplySpeed(oPC,oPCSkin);
   ApplyDamageReduction(oPC,oPCSkin);
   ApplyRedDragonBonuses(oPC);
   // nastaveni poctu featu na den
   RestoreFeatUses(oPC);
}

void OnRestClassSystem(object oPC)
{
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
}

void OnEnterClassSystem(object oPC)
{
    //ReequipSkin(oPC);
    ApplyClassConditions(oPC);
    SetLocalInt(oPC,"BARBARIAN_RAGE",0);
    SetLocalInt(oPC,"BREATH",0);
    object oSoul = GetSoulStone(oPC);
    DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");
    OnLvlupClassSystem(oPC);
 }

