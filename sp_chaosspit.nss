//::///////////////////////////////////////////////
//:: Slaad Chaos Spittle
//:: x2_s1_chaosspit
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creature must make a ranged touch attack to hit
    the intended target.

    Damage is 20d4 for black slaad, 10d4 for white
    slaad and hd/2 d4 for any other creature this
    spell  is assigned to

    A shifter will do his shifter level /3 d6
    points of damage

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: Sept 08  , 2003
//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nHD = GetHitDice(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_S);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    nCasterLvl = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nCasterLvl,FALSE);
    effect eBolt;
    int nMetaMagic = GetMetaMagicFeat();
    int nCount = nCasterLvl/2;
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        int nDamage = d4(nCount);
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = 4 * nCount;//Damage is at max
        }
        else if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.

        //Make a ranged touch attack
        int nTouch = TouchAttackRanged(oTarget);
        if(nTouch > 0)
        {
            if(nTouch == 2)
            {
                nDamage *= 2;
            }
            //Set damage effect
            eBolt = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eBolt, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
            }
        }
    }
}
