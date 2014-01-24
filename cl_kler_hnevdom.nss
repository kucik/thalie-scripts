//::///////////////////////////////////////////////
//:: Barbarian Rage
//:: sh_barb_rage
//:: //:://////////////////////////////////////////////
/*



*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 14.5.2011
//:://////////////////////////////////////////////


//include pro schopnosti terryfing rage a thundering rage
#include "x2_i0_spells"
//include pro barbarovy funkce
#include "sh_classes_inc"






void main()
{

        //Declare major variables
        object oPC =    OBJECT_SELF;
        int iCon = GetAbilityModifier(ABILITY_CONSTITUTION);
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        int nCasterLvl = GetLevelByClass(CLASS_TYPE_BARBARIAN)+GetLevelByClass(CLASS_TYPE_CLERIC);
        nCasterLvl = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nCasterLvl);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        eDur = ExtraordinaryEffect(eDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eAB = EffectAttackIncrease(2);
        eAB = ExtraordinaryEffect(eAB);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eDMG = EffectDamageIncrease(2,DAMAGE_TYPE_SLASHING);
        eDMG = ExtraordinaryEffect(eDMG);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDMG, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eSaveWill = EffectSavingThrowIncrease(SAVING_THROW_WILL,2);
        eSaveWill = ExtraordinaryEffect(eSaveWill);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveWill, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eSaveFort = EffectSavingThrowIncrease(SAVING_THROW_FORT,2);
        eSaveFort = ExtraordinaryEffect(eSaveFort);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaveFort, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eHP = EffectTemporaryHitpoints(80);
        eHP = ExtraordinaryEffect(eHP);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eAC =  EffectACDecrease(2);
        eAC = ExtraordinaryEffect(eAC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, RoundsToSeconds(nCasterLvl+iCon));
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;


}





