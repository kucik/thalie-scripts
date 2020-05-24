//::///////////////////////////////////////////////
//:: Bigby's Interposing Hand
//:: [x0_s0_bigby1]
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Grants -10 to hit to target for 1 round / level
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:
#include "nw_i0_spells"

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration,FALSE);
    int nMetaMagic = GetMetaMagicFeat();


    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,
                                              SPELL_BIGBYS_INTERPOSING_HAND,
                                              TRUE));
        //Check for metamagic extend
        if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
        {
             nDuration = nDuration * 2;
        }
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            if (!MySavingThrow(SAVING_THROW_REFLEX,oTarget,GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF),SAVING_THROW_TYPE_SPELL) )
            {
                effect eAC1 = EffectAttackDecrease(5);
                effect eVis = EffectVisualEffect(VFX_DUR_BIGBYS_INTERPOSING_HAND);
                effect eLink = EffectLinkEffects(eAC1, eVis);


                //Apply the TO HIT PENALTIES bonuses and the VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                    eLink,
                                    oTarget,
                                    RoundsToSeconds(nDuration));
            }
        }
    }
}

