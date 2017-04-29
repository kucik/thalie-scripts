
#include "x0_i0_spells"

#include "sh_classes_const"

void main()
{
   object oPC = OBJECT_SELF;
   if (!GetHasFeat(1647, OBJECT_SELF))
   {
        SendMessageToPC(OBJECT_SELF,"Jiz nemas zadne finty.");
   }
   else
   {

    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eHaste = EffectHaste();
    effect eACdec = EffectACDecrease(3);
    effect eABinc = EffectAttackIncrease(1);
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);
    eLink = EffectLinkEffects(eLink, eACdec);
    eLink = EffectLinkEffects(eLink, eABinc);
    int iDuration = GetLevelByClass(CLASS_TYPE_SERMIR)+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
    // Apply effects to the currently selected target.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    DecrementRemainingFeatUses(OBJECT_SELF, 1647);
    }
}

