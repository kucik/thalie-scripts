//::///////////////////////////////////////////////
//:: cl_aa_deatharrow
//:://////////////////////////////////////////////
/*
   Smrtici sip. Uprava TO proti zakladnimu nwn
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_itemprop"

void main()
{
    int nBonus = ArcaneArcherCalculateBonus();
    int iCasterLvl = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER);
    object oTarget = GetSpellTargetObject();
    int iAbilityBonus;
    if (GetLevelByClass(CLASS_TYPE_WIZARD))
    {
        iAbilityBonus = GetAbilityModifier(ABILITY_INTELLIGENCE);
    }
    else
    {
        iAbilityBonus = GetAbilityModifier(ABILITY_CHARISMA);
    }
    int iDC = 10 + iCasterLvl + iAbilityBonus;

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        int nTouch = TouchAttackRanged(oTarget, TRUE);
        if (nTouch > 0)
        {
            int nDamage = ArcaneArcherDamageDoneByBow((nTouch ==2));
            if (nDamage > 0)
            {
                effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_TEN);
                effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);


                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));


                if (MySavingThrow(SAVING_THROW_FORT, oTarget, iDC,SAVING_THROW_TYPE_DEATH) == 0)
                {
                    effect eDeath = EffectDeath();
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                }
            }
        }
    }
}

