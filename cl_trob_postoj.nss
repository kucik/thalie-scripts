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
void __activateStand(object oPC,object oSoulStone) {

                // zjisteni velikosti bonusu
        int lvl = GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER, oPC);
        int bonus_str = 2, bonus_con = 4, bonus_save = 2, bonus_dodge = 4;
        if (lvl >= 10)
        {
           bonus_str = 2;
           bonus_con =  6;
           bonus_save = 3;
           bonus_dodge =6;
        }
        if (lvl >= 20)
        {
           bonus_str = 4;
           bonus_con =  8;
           bonus_save = 4;
           bonus_dodge =8;
        }
        if (lvl >= 25)
        {
           bonus_str = 4;
           bonus_con =  10;
           bonus_save = 4;
           bonus_dodge =10;
        }
        if (lvl == 30)
        {
           bonus_str = 6;
           bonus_con =  12;
           bonus_save = 5;
           bonus_dodge =12;

        }

        int iHPbonus = bonus_con/2 * GetHitDice(oPC) - 1;
        // vytvoreni efektu savu a dodge ac
        effect ef1 = EffectSavingThrowIncrease(SAVING_THROW_ALL,bonus_save);
        effect ef2 = EffectACIncrease(bonus_dodge);
        effect eLink = EffectLinkEffects(ef1,ef2);
        effect eHP;
        //eLink = EffectLinkEffects(eLink,ef3);
        itemproperty ip = ItemPropertyWeightIncrease(IP_CONST_WEIGHTINCREASE_100_000_LBS);
        SetItemPropertySpellId(ip,IP_DD_STANCE);
        AddItemProperty(DURATION_TYPE_PERMANENT,ip,oSoulStone);


        if(iHPbonus > 0) {
          eHP = EffectTemporaryHitpoints(iHPbonus);
          SetEffectSpellId(eHP,EFFECT_TRPASLICI_OBRANCE_POSTOJ);
          ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHP,oPC);
        }
        eLink = ExtraordinaryEffect(eLink);
        SetEffectSpellId(eLink,EFFECT_TRPASLICI_OBRANCE_POSTOJ);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink,oPC);
        IncreaseDefenderStats(oPC,bonus_str,bonus_con);
        IncrementRemainingFeatUses(OBJECT_SELF,FEAT_POSTOJ_TRPASLICI_OBRANCE1);
//        SetMovementRate(oPC, MOVEMENT_RATE_IMMOBILE);
        SendMessageToPC(oPC,"Obrany postoj aktivovan!");
}

void main()
{
    object oSoulStone = GetSoulStone(OBJECT_SELF);
    object oPC = OBJECT_SELF;
    if (GetLocalInt(oSoulStone,AKTIVNI_POSTOJ_OBRANCE) == 0)
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
