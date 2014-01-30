//::///////////////////////////////////////////////
//:: cl_cern_nemr
//:://////////////////////////////////////////////
/*
  Cernokneznik - nemrtvy spolecnik
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////


#include "X0_I0_SPELLS"
void main()
{



    //Declare major variables

    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF);
    int iDamageReductionSoak = DAMAGE_POWER_PLUS_ONE;
    int iSword = 0;
    int iDuration = 24;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    if (iCasterLevel <= 5)
    {
        //Tyrant Fog Zombie
        eSummon = EffectSummonCreature("NW_S_ZOMBTYRANT",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_TWO;
    }
    else if ((iCasterLevel >= 6) && (iCasterLevel <= 9))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("NW_S_SKELWARR",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_THREE;
    }
    else
    {
        //Skeleton Chieftain
        eSummon = EffectSummonCreature("NW_S_SKELCHIEF",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_FOUR;
        iSword = 1;

    }
    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
/*    effect eSoak =EffectDamageReduction(15,iDamageReductionSoak);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSoak,GetAssociate(ASSOCIATE_TYPE_SUMMONED)));
    if (iSword)
    {
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_NEGATIVE),GetAssociate(ASSOCIATE_TYPE_SUMMONED)));
    }*/
}


