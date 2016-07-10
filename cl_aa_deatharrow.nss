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
    int iDex = GetAbilityModifier(ABILITY_DEXTERITY);
    object oTarget = GetSpellTargetObject();
    int iDC = 15 + iCasterLvl/2 + iDex;
    if (GetHasFeat(FEAT_EPICGENERAL_VYLEPSENY_SIP_SMRTI_1,OBJECT_SELF) == TRUE)
    {
        iDC += 2;
    }
        if (GetHasFeat(FEAT_EPICGENERAL_VYLEPSENY_SIP_SMRTI_2,OBJECT_SELF) == TRUE)
    {
        iDC += 2;
    }
        if (GetHasFeat(FEAT_EPICGENERAL_VYLEPSENY_SIP_SMRTI_3,OBJECT_SELF) == TRUE)
    {
        iDC += 2;
    }
        if (GetHasFeat(FEAT_EPICGENERAL_VYLEPSENY_SIP_SMRTI_4,OBJECT_SELF) == TRUE)
    {
        iDC += 2;
    }
        if (GetHasFeat(FEAT_EPICGENERAL_VYLEPSENY_SIP_SMRTI_5,OBJECT_SELF) == TRUE)
    {
        iDC += 2;
    }
    if (GetIsObjectValid(oTarget) == TRUE)
    {
        int nTouch = TouchAttackRanged(oTarget, TRUE);
        if (nTouch > 0)
        {
            int nDamage = ArcaneArcherDamageDoneByBow((nTouch ==2));
            if (nDamage > 0)
            {
                effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
                effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);


                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));


                if (MySavingThrow(SAVING_THROW_FORT, oTarget, iDC) == 0)
                {
                    effect eDeath = EffectDeath();
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                }
            }
        }
    }
}

