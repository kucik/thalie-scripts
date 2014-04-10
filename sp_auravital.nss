//::///////////////////////////////////////////////
//:: Aura of Vitality
//:: NW_S0_AuraVital
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within the AOE gain +4 Str, Con, Dex
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
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
    object oTarget;
    int iBonus = 4;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);



    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    int iCasterLvl = GetCasterLevel(OBJECT_SELF);
    int iDurationCasterLvlIncluded; // duration of spell, where the lvl of target is included
    float fDelay;

    int nMetaMagic = GetMetaMagicFeat();
    //Enter Empower Metamagic conditions, exteded metamagic is dealed later
    /*if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2; //Duration is +100%
    }*/
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        iBonus = 6; //Duration is +100%
    }
    // strength of effects are ThalieCaster-independent, define them here
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH,iBonus);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,iBonus);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION,iBonus);

    effect eLink = EffectLinkEffects(eStr, eDex);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetFactionEqual(oTarget) || GetIsReactionTypeFriendly(oTarget))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            // adjust duration of the spell with respect to lvl of a target
            iDurationCasterLvlIncluded = GetThalieCaster(OBJECT_SELF, oTarget, iCasterLvl, TRUE);
            // deal with extended spells
            if (nMetaMagic == METAMAGIC_EXTEND) 
            {
                iDurationCasterLvlIncluded *= 2; //Duration is +100%
            }            
            //Signal the spell cast at event
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AURA_OF_VITALITY, FALSE));
            //Apply effects and VFX to target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(iDurationCasterLvlIncluded)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
