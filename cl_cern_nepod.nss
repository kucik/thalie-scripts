//::///////////////////////////////////////////////
//:: cl_cern_nepod
//:://////////////////////////////////////////////
/*
  Cernokneznik - Nepoddajnost
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_classes_inc"

void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eHP = EffectTemporaryHitpoints(iCasterLevel);
    effect eLink = EffectLinkEffects(eHP, eDur);
    if (GetCurrentHitPoints() <= GetMaxHitPoints()+iCasterLevel)
    {
        //Apply visual and bonus effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(24));
    }
}

