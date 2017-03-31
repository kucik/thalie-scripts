#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ku_boss_inc"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //Declare major variables
    object oTarget;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nDuration,FALSE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eConfuse = EffectConfused();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fDelay;
    //Link duration VFX and confusion effects
    effect eLink = EffectLinkEffects(eMind, eConfuse);
    eLink = EffectLinkEffects(eLink, eDur);
    int iBonusDC = 0;
    int iAligment ;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    //Search through target area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
           iBonusDC = 0;
           iAligment = GetAlignmentLawChaos(oTarget);
           if (iAligment== ALIGNMENT_LAWFUL)
           {
                iBonusDC = -4;
           }
           if (iAligment== ALIGNMENT_CHAOTIC)
           {
                iBonusDC = 4;
           }

           //Fire cast spell at event for the specified target
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
           fDelay = GetRandomDelay();
           //Make Will Save
           if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF)+iBonusDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
           {
                   //Apply linked effect and VFX Impact
                   nDuration = GetScaledDuration(GetCasterLevel(OBJECT_SELF), oTarget);
                   nDuration = ReduceShortSpellDurationForBoss_int(oTarget, nDuration, GetCasterLevel(OBJECT_SELF));
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}

