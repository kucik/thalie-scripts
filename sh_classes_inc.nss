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

#include "sh_deity_inc"


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

}


void RepairDeities(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)  //zkontroluj domeny
    {
        int iDeity = GetThalieDeity(oPC);
        int iDomain1 = GetClericDomain(oPC,1);
        int iDomain2 = GetClericDomain(oPC,2);
        if (!GetIsDeityAndDomainsValid(iDeity, iDomain1,iDomain2))
        {
            SetDomainsByDeity(oPC,iDeity);
        }
    }
}

void ApplyLilithDmgShield(object oPC)
{
    if (GetThalieClericDeity(OBJECT_SELF)==DEITY_LILITH)
    {
        int iDamage = GetLevelByClass(CLASS_TYPE_CLERIC,oPC) /2;
        if (iDamage = 0) iDamage=1;
        effect ef1 =EffectDamageShield(iDamage,DAMAGE_BONUS_1,DAMAGE_TYPE_FIRE);
        SetEffectSpellId(ef1,EFFECT_LILITH_PASSIVE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef1,oPC);
    }
}

void CastBlast(object oPC)
{
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH1,oPC)==FALSE) return;
    if (GetLocalInt(oPC,ULOZENI_VAZAC_TAJEMNY_VYBUCH)==FALSE) return;
    object oSlotOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    if (GetIsObjectValid(oSlotOffHand)==FALSE) return;
    string sOffHandTag = GetTag(oSlotOffHand);
    if (sOffHandTag!="sys_orb1") return;

    int iCasterLevel = GetLevelByClass(44,OBJECT_SELF) ;//vazac
    int iDice = 1+(iCasterLevel-1)/2;

    object oTarget = GetNearestCreature(CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,oPC,1,CREATURE_TYPE_RACIAL_TYPE,REPUTATION_TYPE_ENEMY);
    if (GetDistanceBetween(oPC,oTarget) > 20.0) return;
    //Hlavni kod
    int iCharismaMod = GetAbilityModifier(ABILITY_CHARISMA,oPC);
    int iTargetSpellResistance = GetSpellResistance(oTarget);
    int iSRMod = 0;
    if (iTargetSpellResistance>10)
    {
        iSRMod = (iTargetSpellResistance-10)*2;
        if (iSRMod > 100 )
        {
           iSRMod = 100;
        }
    }
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH2,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    if (GetHasFeat(FEAT_VAZAC_TAJEMNY_VYBUCH3,oPC)==TRUE)
    {
        iDice = iDice +5;
    }
    int iDamage = 0;
    if (GetHasFeat(FEAT_VAZAC_OHNIVY_VYBUCH,oPC)==TRUE)
    {
        iDamage = d10(iDice)+iCharismaMod;
    }
    else
    {
        iDamage = d4(iDice)+iCharismaMod;
    }
    iDamage = FloatToInt(  IntToFloat(iDamage) * (100.0- IntToFloat(iSRMod) )/100.0);
    if (iDamage == 0) return;
    if (GetHasFeat(FEAT_VAZAC_OHNIVY_VYBUCH,oPC)==TRUE)
    {
        effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    }
    else
    {
        effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_MAGICAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
    }
    //Konec hlavniho kodu
    effect eRay = EffectBeam(VFX_BEAM_BLACK, oPC, BODY_NODE_CHEST);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);



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
   ApplyLilithDmgShield(oPC);
   // nastaveni poctu featu na den
   RestoreFeatUses(oPC);
   RepairDeities(oPC);

}

void OnRestClassSystem(object oPC)
{
   RestoreFeatUses(oPC);
   object oSoul = GetSoulStone(oPC);
   SetLocalInt(oSoul,"RACIAL_ABILITY",1);
   DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK");
   DeleteLocalInt(oSoul,"KURTIZANA_KZEMI");

}

void OnHBClassSystem(object oPC)
{
    CastBlast(oPC);
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
    RepairDeities(oPC);
 }

