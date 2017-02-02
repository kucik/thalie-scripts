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

//include pro barbarovy funkce
#include "sh_classes_inc"






void main()
{

        //Declare major variables
        object oPC =    OBJECT_SELF;
       PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eAB = EffectAttackIncrease(2);
        effect eDMG = EffectDamageIncrease(DAMAGE_BONUS_2,DAMAGE_TYPE_DIVINE);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL,2);
        effect eAC =  EffectACDecrease(2);
        effect eLink = EffectLinkEffects(eAB, eDMG);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eAC);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX



            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(10));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;


}





