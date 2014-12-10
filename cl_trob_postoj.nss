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
void OdebraniEfektu(object oPC)
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
    DecreaseDefenderStats(oPC);
//    SetMovementRate(oPC, MOVEMENT_RATE_NORMAL);
//    SetMovementRate(oPC, MOVEMENT_RATE_NORMAL);
    SendMessageToPC(oPC,"Obrany postoj deaktivovan!");
}


void __activateStand(object oPC) {

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
        effect ef3 = EffectMovementSpeedDecrease(99);
        effect eLink = EffectLinkEffects(ef1,ef2);
        effect eHP;
        eLink = EffectLinkEffects(eLink,ef3);
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
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    object oPC = OBJECT_SELF;
    if (GetLocalInt(oSaveItem,AKTIVNI_POSTOJ_OBRANCE) == 0)
    {

        //Search for and remove freemove
    effect eLook = GetFirstEffect(oPC);
    while(GetIsEffectValid(eLook))
    {
        if(GetEffectSpellId(eLook) == SPELL_FREEDOM_OF_MOVEMENT )
        {

              RemoveEffect(oPC, eLook);
        }
        eLook = GetNextEffect(oPC);
    }

        //odebrani efektu
        DelayCommand(0.2,__activateStand(oPC));



    }
    else
    {
        //odebrani efektu
        DelayCommand(1.0,OdebraniEfektu(oPC));
    }


}
