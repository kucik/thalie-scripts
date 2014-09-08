//::///////////////////////////////////////////////
//:: cl_cern_desch
//:://////////////////////////////////////////////
/*
  Cernokneznik - desive chyceni
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
//#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect ef = EffectAttackDecrease(3);
    effect eMovement = EffectMovementSpeedDecrease(30);
    effect eLink = EffectLinkEffects(ef,eMovement);
    int iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
    int nCasterLevel = GetLevelByClass(44,OBJECT_SELF); //CLASS_TYPE_CERNOKNEZNIK
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        // Make SR Check
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            // Make Will save vs Mind-Affecting
            if (!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                //Apply impact and linked effect
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}
