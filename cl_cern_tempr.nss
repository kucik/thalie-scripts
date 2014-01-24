//::///////////////////////////////////////////////
//:: cl_cern_tempr
//:://////////////////////////////////////////////
/*
   Cernokneznik - temna predtucha
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    int iDuration = 25;
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    int iLimit = iCasterLevel * 10;
    effect eStone = EffectDamageReduction(10, DAMAGE_POWER_PLUS_SIX, iLimit);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    //Link the visual and the damage reduction effect
    effect eLink = EffectLinkEffects(eStone, eVis);
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(iDuration));
}
