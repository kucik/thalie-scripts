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



void ApplyExorcistBonuses(object oPC)
{
    int iLevel = GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
    if (iLevel >= 5)
    {
        int iBonus = 2* (iLevel/5);
        effect eMind = EffectSavingThrowIncrease(SAVING_THROW_WILL,iBonus,SAVING_THROW_TYPE_MIND_SPELLS);
        eMind = SupernaturalEffect(eMind);
        SetEffectSpellId(eMind,EFFECT_EXORCISTA_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMind,oPC);
    }
    if (iLevel >= 10)
    {
        effect eDom = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
        effect eSup = SupernaturalEffect(eDom);
        SetEffectSpellId(eSup,EFFECT_EXORCISTA_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSup,oPC);
    }
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
        if ((iEffect== EFFECT_BRUTALNI_VRH) || (iEffect==EFFECT_SPRAVEDLIVY_UDER) || (iEffect==EFFECT_EXOR_DAMAGE_DIVINE) || (iEffect==EFFECT_TWOHANDED_2AB) || (iEffect==EFFECT_PRESNY_BOD))
        {
            RemoveEffect(oPC,eLoop);
        }
        eLoop = GetNextEffect(oPC);
    }
    if (iEquip)
    {
        object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int iItemTypeM = GetBaseItemType(oItem);
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
         int iLevel = GetLevelByClass(CLASS_TYPE_EXORCISTA,oPC);
         if (iWis > iLevel) iWis = iLevel;
         int iDamage = GetDamageBonusByValue(iWis);
         effect ef = EffectDamageIncrease(iDamage,DAMAGE_TYPE_DIVINE);
         effect eLink = SupernaturalEffect(ef);
         SetEffectSpellId(eLink,EFFECT_EXOR_DAMAGE_DIVINE);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

        }
        if (GetIsObjectValid(oItem))
        {
            if (GetIsTwoHandedWeapon(oPC, iItemTypeM))
            {
                effect ef = EffectAttackIncrease(2);
                effect eLink = SupernaturalEffect(ef);
                SetEffectSpellId(eLink,EFFECT_TWOHANDED_2AB);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);

            }
            int iBaseItem = GetBaseItemType(oItem);
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
}

void CastBlast(object oPC, object oTarget)
{
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH1,oPC)==FALSE) return;
    object oSlotOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if (GetIsObjectValid(oSlotOffHand)==FALSE) return;
    string sOffHandTag = GetTag(oSlotOffHand);
    if (sOffHandTag!="sys_orb1") return;

    int iCasterLevel = GetLevelByClass(44,oPC) ;//vazac
    int iDice = 1+(iCasterLevel-1)/2;

    //Hlavni kod
    int iCharismaMod = GetAbilityModifier(ABILITY_CHARISMA,oPC);
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH2,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH3,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    int iDamage = d4(iDice)+iCharismaMod;
    if (GetHasFeat(FEAT_VAZAC_KRITICKY_VYBUCH,oPC)==TRUE)
    {
        if (d10() == 5)
        {
            iDamage = 2*iDamage;
        }
    }
    effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_MAGICAL);
    AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));

    //Konec hlavniho kodu
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
    DeleteLocalString(oPC,"OZNACEN"); //odstraneni znacky assassina
    DeleteLocalInt(oPC,"UderDoTepny"); //zruseni ucinku krvaceni
    DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK");
    DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK_TARGET");
    SetLocalInt(oPC,"BARBARIAN_RAGE",0);
    object oSoul = GetSoulStone(oPC);
    DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");
    OnLvlupClassSystem(oPC);
 }

