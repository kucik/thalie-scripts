//::///////////////////////////////////////////////
//:: Klerik - domena hnevu
//:: cl_kler_hnevdom
//:: //:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 14.5.2011
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    int iCon = GetAbilityModifier(ABILITY_CONSTITUTION, OBJECT_SELF);
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
    float fDur = iCasterLevel + iCon > 0 ? RoundsToSeconds(iCasterLevel + iCon) : RoundsToSeconds(1);
    
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_WRATH); //Change to the Rage VFX //VFX_IMP_IMPROVE_ABILITY_SCORE
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = ExtraordinaryEffect(eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, fDur);
    
    effect eAB = EffectAttackIncrease(2);
    eAB = ExtraordinaryEffect(eAB);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, fDur);
    
    effect eDMG = EffectDamageIncrease(2, DAMAGE_TYPE_SLASHING);
    eDMG = ExtraordinaryEffect(eDMG);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDMG, OBJECT_SELF, fDur);
    
    effect eSaveWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, 4);
    eSaveWill = ExtraordinaryEffect(eSaveWill);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveWill, OBJECT_SELF, fDur);
    
    effect eSaveFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, 2);
    eSaveFort = ExtraordinaryEffect(eSaveFort);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveFort, OBJECT_SELF, fDur);
    
    effect eHP = EffectTemporaryHitpoints(80);
    eHP = ExtraordinaryEffect(eHP);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, fDur);
    
    effect eAC = EffectACDecrease(2);
    eAC = ExtraordinaryEffect(eAC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, fDur);
    
    PlayVoiceChat(VOICE_CHAT_BATTLECRY1, OBJECT_SELF);
}





