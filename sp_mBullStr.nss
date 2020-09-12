//::///////////////////////////////////////////////
//:: Mass Bull Strength
//:: sp_mBullStr.nss
//:://////////////////////////////////////////////
/*
    Grants the caster and up to 1 target per 5
    levels an ability boost (DEX). Added metamagic
    for the empowered spell.
*/
//:://////////////////////////////////////////////
//:: Created By: P.A.
//:: Created On: March 04, 2014
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "nwnx_structs"
#include "sh_deity_inc"

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
    object oTarget = GetSpellTargetObject();
    effect eStr;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nTargets = nCasterLvl / 5;
    int nMetaMagic = GetMetaMagicFeat();
    int nModify = d4()+1;
    float fDuration = TurnsToSeconds(nCasterLvl);
    float fNormalizedCasterDuration;
    float fDelay;
    float fRadius = YardsToMeters((25 + 5*nCasterLvl / 2.0)); // radius, in meters, i.e. (25 ft. + 5 ft./2 levels)

    //Enter Metamagic conditions
    if ((nMetaMagic == METAMAGIC_EMPOWER))
    {
        nModify = nModify+nModify/2;
    }
    if ((nMetaMagic == METAMAGIC_MAXIMIZE))
    {
        nModify = 5;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDuration = fDuration * 2.0; //Duration is +100%
    }
    eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nModify);
    SetEffectSpellId(eStr,SPELL_BULLS_STRENGTH);
    eLink = EffectLinkEffects(eStr, eDur);
    SetEffectSpellId(eLink,SPELL_BULLS_STRENGTH);

    //Get first target in spell area
    location lLoc = GetLocation(OBJECT_SELF);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc, FALSE);
    while(GetIsObjectValid(oTarget) && nTargets != 0)
    {
        if(GetIsFriend(oTarget) && OBJECT_SELF != oTarget)
        {
            // SendMessageToPC( OBJECT_SELF, ("target =" + IntToString(nTargets)+ "")); // debug msg
            fDelay = GetRandomDelay();
            fNormalizedCasterDuration = fDuration * GetThalieCaster(OBJECT_SELF,oTarget,nCasterLvl) / nCasterLvl; // spell duration normalized by NT caster level of the target
            DelayCommand(fDelay,SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BULLS_STRENGTH, FALSE)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget)); // apply visual effect of the casted spell
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fNormalizedCasterDuration)); // apply spell effects
            nTargets--;
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc, FALSE);
    }
    DelayCommand(0.1,SignalEvent(oTarget, EventSpellCastAt(oTarget, SPELL_BULLS_STRENGTH, FALSE)));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
}
