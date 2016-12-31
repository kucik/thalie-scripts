//::///////////////////////////////////////////////
//:: Ochrana pred zlem
//:: cl_exor_och_zlo
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 7.10.2012
//:://////////////////////////////////////////////

#include "sh_classes_inc"

void main()
{





    //Declare major variables
    int nAlign = ALIGNMENT_EVIL;
    object oTarget = GetSpellTargetObject();
    int nDuration = 10+GetLevelByClass(CLASS_TYPE_EXORCISTA)+GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eAC = EffectACIncrease(2, AC_DEFLECTION_BONUS);
    eAC = VersusAlignmentEffect(eAC,ALIGNMENT_ALL, nAlign);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlign);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    eImmune = VersusAlignmentEffect(eImmune,ALIGNMENT_ALL, nAlign);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MINOR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);



    //Apply the VFX impact and effects
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PROTECTION_FROM_EVIL, FALSE));
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

