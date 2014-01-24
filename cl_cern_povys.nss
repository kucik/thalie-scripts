//::///////////////////////////////////////////////
//:: cl_cern_povys
//:://////////////////////////////////////////////
/*
  Cernokneznik - Podle vysmeknuti
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
    effect eIm = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
    effect eLink = EffectLinkEffects(eIm, eDur);
    //Apply visual and bonus effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(1));

}

