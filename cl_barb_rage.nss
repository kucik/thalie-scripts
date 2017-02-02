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

    object oSaveItem;
    if(GetIsPC(OBJECT_SELF) && !GetIsDMPossessed(OBJECT_SELF) )
      oSaveItem = GetSoulStone(OBJECT_SELF);
    else
      oSaveItem = OBJECT_SELF;

    if (GetLocalInt(oSaveItem,AKTIVNI_RAGE) == 0)
    {
        //Declare major variables
        object oPC =    OBJECT_SELF;
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int iAbility = GetBarbarianAbilityBonus(OBJECT_SELF);
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);

         // trvani
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + iAbility;
        if (GetHasFeat(FEAT_GENERAL_DLOUHA_ZURIVOST_1,oPC) == TRUE)
        {
            nCon +=5;
        }
        if (GetHasFeat(FEAT_GENERAL_DLOUHA_ZURIVOST_2,oPC) == TRUE)
        {
            nCon +=5;
        }
        if (GetHasFeat(FEAT_GENERAL_DLOUHA_ZURIVOST_3,oPC) == TRUE)
        {
            nCon +=5;
        }
        if (GetHasFeat(FEAT_GENERAL_DLOUHA_ZURIVOST_4,oPC) == TRUE)
        {
            nCon +=5;
        }
        if (GetHasFeat(FEAT_GENERAL_DLOUHA_ZURIVOST_5,oPC) == TRUE)
        {
            nCon +=5;
        }


        effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL,iAbility/2);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eAC,eSave);
        if (GetHasFeat(FEAT_EPICGENERAL_CHAOTICKA_ZURIVOST,oPC) == TRUE)
        {
            effect efDamage = EffectDamageIncrease(DAMAGE_BONUS_2d6);
            effect efChaotic = VersusAlignmentEffect(efDamage,ALIGNMENT_LAWFUL);
            eLink = EffectLinkEffects(eLink, efChaotic);
        }
        eLink = EffectLinkEffects(eLink, eDur);
        // kontrola na neoblomnou vuli
        if (GetHasFeat(FEAT_NEOBLOMNA_VULE,OBJECT_SELF) == TRUE)
        {
            effect eWill =EffectSavingThrowIncrease (SAVING_THROW_WILL,4,SAVING_THROW_TYPE_SPELL);
            eLink = EffectLinkEffects(eLink, eWill);
        }
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));

        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE); //Change to the Rage VFX
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
        //Zvetseni statu - Shaman88
        IncreaseBarbarStats(OBJECT_SELF,iAbility);
        // 2003-07-08, Georg: Rage Epic Feat Handling
        CheckAndApplyEpicRageFeats(nCon);


        DelayCommand(RoundsToSeconds(nCon),DecreaseBarbarStats(OBJECT_SELF));

        }
        else
        {
            DecreaseBarbarStats(OBJECT_SELF);
        }
}





