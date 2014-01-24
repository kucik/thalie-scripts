//::///////////////////////////////////////////////
//:: Feeblemind
//:: [NW_S0_FeebMind.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Target must make a Will save or take ability
//:: damage to Intelligence equaling 1d4 per 4 levels.
//:: Duration of 1 rounds per 2 levels.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 2, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"
#include "sh_deity_inc"
void RunImpact(object oTarget, int iDec,int iAct,int iMax)
{
   effect ef1 = EffectAbilityDecrease(ABILITY_CHARISMA,iDec);
   effect ef2 =EffectAbilityDecrease(ABILITY_INTELLIGENCE,iDec);
   effect ef3 =EffectAbilityDecrease(ABILITY_WISDOM,iDec);
   effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
   effect eLink = EffectLinkEffects(ef1,ef2);
   eLink = EffectLinkEffects(eLink,ef3);
   if(iAct ==iMax)
   {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,TurnsToSeconds(iMax/2));

        return;
   }

   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(2));
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
   DelayCommand(6.0,RunImpact(oTarget,iDec+2,iAct+1,iMax));
}

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration,FALSE)/2;
    if (GetClericDomain(OBJECT_SELF,1) ==DOMENA_VEDENI || GetClericDomain(OBJECT_SELF,2)==DOMENA_VEDENI)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eRay = EffectBeam(VFX_BEAM_MIND, OBJECT_SELF, BODY_NODE_HAND);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FEEBLEMIND));
        //Make SR check
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Make an will save

            int nWillResult =  WillSave(oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS);
            if (nWillResult == 0)
            {

                  //Set the ability damage



                  //Apply the VFX impact and ability damage effect.
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration));
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.0);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                  RunImpact(oTarget,2,1,nDuration);
            }
            else
            // * target was immune
            if (nWillResult == 2)
            {
                SpeakStringByStrRef(40105, TALKVOLUME_WHISPER);
            }
        }
    }
}
