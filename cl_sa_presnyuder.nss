//::///////////////////////////////////////////////
//:: Presny uder
//:: cl_sa_presnyuder
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 3.10.2012
//:://////////////////////////////////////////////


#include "sh_classes_inc"



void main()
{

    //Declare major variables
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);


    // * determine the damage bonus to apply
    effect eAttack = EffectAttackIncrease(20);


    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = eAttack;
    eLink = EffectLinkEffects(eLink, eDur);


    oTarget = OBJECT_SELF;

    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 9.0);


}
