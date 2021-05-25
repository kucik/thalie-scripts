//::///////////////////////////////////////////////
//:: Lesser Planar Binding
//:: NW_S0_LsPlanar.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an outsider dependant on alignment, or
    holds an outsider if the creature fails a save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001

#include "x2_inc_spellhook"
#include "ku_boss_inc"
#include "nwnx_funcs"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    nCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nCasterLevel,FALSE);
    int nDuration = GetCasterLevel(OBJECT_SELF)/2;
    effect eSummon;
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);

    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    if(nDuration == 0)
    {
        nDuration = 1;
    }

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to see if the target is valid
    if (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_PLANAR_BINDING));
            //Check to make sure the target is an outsider
            if(nRacial == RACIAL_TYPE_OUTSIDER)
            {
                //Make a will save
                if(!WillSave(oTarget, GetSpellSaveDC()))
                {
                    // Boss reduction
                    nDuration = ReduceShortSpellDurationForBoss_int(oTarget, nDuration, nDuration);
                    //Apply the linked effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
    }
    else
    {
        //Get the alignment of the caster
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            //Set the summon effect based on alignment
            case ALIGNMENT_EVIL:
                {
                    eSummon = EffectSummonCreature("NW_S_IMP",VFX_FNF_SUMMON_GATE , fDelay);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                }
            break;
            case ALIGNMENT_GOOD:
                {
                    eSummon = EffectSummonCreature("NW_S_CLANTERN", 219 ,fDelay);
                    //eGate = EffectVisualEffect(219);
                }
            break;
            case ALIGNMENT_NEUTRAL:
                {
                    eSummon = EffectSummonCreature("NW_S_SLAADRED", VFX_FNF_SUMMON_MONSTER_3);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3, ,1.0);
                }
            break;
        }
        //Apply the summon effect and the VFX impact
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
        DelayCommand(0.2,__boostSummon(FEAT_SPELL_FOCUS_CONJURATION,FEAT_GREATER_SPELL_FOCUS_CONJURATION,FEAT_EPIC_SPELL_FOCUS_CONJURATION));
    }
}

