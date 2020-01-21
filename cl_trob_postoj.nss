 //::///////////////////////////////////////////////
//:: Vlastni postoj trpasliciho obrance
//:: cl_trob_postoj
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 27.5.2011
//:://////////////////////////////////////////////
/*


*/


#include "sh_classes_inc"
void __activateStand(object oPC,object oSoulStone)
{
       int iAB = 1;
       int iDMG =1;
       int iSaves = 2;
       int iFort = 2;
       int iDodgeAC = 4;

        int iHPbonus = 2 * GetHitDice(oPC);
        // vytvoreni efektu savu a dodge ac
        effect ef1 = EffectSavingThrowIncrease(SAVING_THROW_ALL,iSaves);
        effect ef2 = EffectSavingThrowIncrease(SAVING_THROW_FORT,iFort);
        effect ef3 = EffectACIncrease(iDodgeAC);
        effect ef4 = EffectAttackIncrease(iAB);
        effect ef5 =EffectDamageIncrease(DAMAGE_BONUS_1,DAMAGE_TYPE_BASE_WEAPON);
        effect ef6 = EffectTemporaryHitpoints(iHPbonus);
        effect eLink = EffectLinkEffects(ef1,ef2);
        eLink = EffectLinkEffects(eLink,ef3);
        eLink = EffectLinkEffects(eLink,ef4);
        eLink = EffectLinkEffects(eLink,ef5);
        eLink = EffectLinkEffects(eLink,ef6);
        eLink = ExtraordinaryEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_TRPASLICI_OBRANCE_POSTOJ);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink,oPC,9999.0);
        IncrementRemainingFeatUses(OBJECT_SELF,FEAT_POSTOJ_TRPASLICI_OBRANCE1);
        SendMessageToPC(oPC,"Obrany postoj aktivovan!");
        SetLocalInt(oSoulStone,"STANCE",1);
        itemproperty ip = ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_100_000_LBS);
        SetItemPropertySpellId(ip,IP_DD_STANCE);
        AddItemProperty(DURATION_TYPE_PERMANENT,ip,oSoulStone);
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
    SendMessageToPC(oPC,"Obrany postoj deaktivovan!");
    SetLocalInt(oSoulStone,"STANCE",0);
    itemproperty ipLoop=GetFirstItemProperty(oSoulStone);
    while (GetIsItemPropertyValid(ipLoop))
    {
        if ((GetItemPropertySpellId(ipLoop)==IP_DD_STANCE) || (GetItemPropertyType(ipLoop)==ITEM_PROPERTY_WEIGHT_INCREASE))
        {

            RemoveItemProperty(oSoulStone, ipLoop);
        }
        ipLoop=GetNextItemProperty(oSoulStone);

    }
}

void main()
{
    object oSoulStone = GetSoulStone(OBJECT_SELF);
    object oPC = OBJECT_SELF;
    if (GetLocalInt(oSoulStone,"STANCE") == 0)
    {
        if (GetActionMode(oPC,ACTION_MODE_EXPERTISE))
        {
            SetActionMode(oPC,ACTION_MODE_EXPERTISE,FALSE);
        }
        else if (GetActionMode(oPC,ACTION_MODE_IMPROVED_EXPERTISE))
        {
            SetActionMode(oPC,ACTION_MODE_IMPROVED_EXPERTISE,FALSE);
        }
        else if (GetActionMode(oPC,ACTION_MODE_IMPROVED_POWER_ATTACK))
        {
            SetActionMode(oPC,ACTION_MODE_IMPROVED_POWER_ATTACK,FALSE);
        }
        else if (GetActionMode(oPC,ACTION_MODE_POWER_ATTACK))
        {
            SetActionMode(oPC,ACTION_MODE_POWER_ATTACK,FALSE);
        }
        //aktivace efektu

        DelayCommand(0.2,__activateStand(oPC,oSoulStone));
    }
    else
    {
        //odebrani efektu
        DelayCommand(1.0,DD_RemoveStance(oPC,oSoulStone));
    }
}
