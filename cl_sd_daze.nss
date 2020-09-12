//::///////////////////////////////////////////////
//:: cl_sd_daze
//:://////////////////////////////////////////////
/*
   Stinove omameni SD.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "ku_boss_inc"

void main()
{
    int lvlSD = GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    int dex = GetAbilityModifier(ABILITY_DEXTERITY);
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDaze = EffectDazed();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    int nDuration = 5;
    int iDC = 10 + lvlSD + dex;



    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 475));
    //check meta magic for extend
     if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
       //Make SR check
       if (!MyResistSpell(OBJECT_SELF, oTarget))
       {
            //Make Will Save to negate effect
            if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget,iDC , SAVING_THROW_TYPE_MIND_SPELLS))
            {
                nDuration = ReduceShortSpellDurationForBoss_int(oTarget, nDuration, nDuration);
                //Apply VFX Impact and daze effect
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }
    }
}


