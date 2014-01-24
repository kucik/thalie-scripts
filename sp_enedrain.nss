//::///////////////////////////////////////////////
//:: Energy Drain
//:: NW_S0_EneDrain.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target loses 2d4 levels.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"

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
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDrain = d6(2);
    //Enter Metamagic conditions
    int iCasterLvl = GetThalieCaster(OBJECT_SELF,oTarget,GetCasterLevel(OBJECT_SELF),FALSE);
    effect eDrain = EffectNegativeLevel(nDrain);
    eDrain = SupernaturalEffect(eDrain);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_DRAIN));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NEGATIVE))
            {
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                effect eBad = GetFirstEffect(oTarget);
                //Search for negative effects
                while(GetIsEffectValid(eBad))
                {
                    if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                        GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                        GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
                        GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
                        GetEffectType(eBad) == EFFECT_TYPE_POISON ||
                        GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                        GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
                        GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
                        GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
                        GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
                        GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
                        GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
                        GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                        GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
                        GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
                    {
                      RemoveEffect(oTarget, eBad);
                    }
                    eBad = GetNextEffect(oTarget);
                }
                //Apply the VFX impact and effects
                int nHeal = 10*iCasterLvl;
                if (nHeal > 300 )
                {
                    nHeal = 300;
                }

                    effect eHeal = EffectHeal(nHeal);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));
                effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
            }





        }
    }
}

