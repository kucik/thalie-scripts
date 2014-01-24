//::///////////////////////////////////////////////
//:: Ki sila
//:: cl_sa_kisila
//:: //:://////////////////////////////////////////////
/*
Prida 2x bonus ze sily jako damage po dobu x kol, kde x je pocet urovni samuraje.


*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 3.10.2012
//:://////////////////////////////////////////////


#include "sh_classes_inc"



void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_SAMURAJ);
    int iStr = GetAbilityModifier(ABILITY_STRENGTH) ;
    int bonus = 2 * iStr;
    effect eLink = EffectDamageIncrease(bonus);
    eLink = ExtraordinaryEffect(eLink);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF,RoundsToSeconds(nLevel+iStr));
}
