//::///////////////////////////////////////////////
//:: Cat's Grace
//:: NW_S0_CatGrace
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// The transmuted creature becomes more graceful,
// agile, and coordinated. The spell grants an
// enhancement  bonus to Dexterity of 1d4+1
// points, adding the usual benefits to AC,
// Reflex saves, Dexterity-based skills, etc.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Oct 18, 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: Last Updated On: April 5th, 2001


#include "x2_inc_spellhook"
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
    effect eDex;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    nCasterLvl = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLvl);
    int nModify = d4()+1;
    float fDuration = TurnsToSeconds(nCasterLvl);
    int nMetaMagic = GetMetaMagicFeat();
    //Signal spell cast at event to fire on the target.
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CATS_GRACE, FALSE));
    //Enter Metamagic conditions
    if ((nMetaMagic == METAMAGIC_EMPOWER) || (GetThalieClericDeity(OBJECT_SELF)==DEITY_GORDUL))
    {
        nModify = nModify+nModify/2;
    }
    if ((nMetaMagic == METAMAGIC_MAXIMIZE))
    {
        nModify = 5;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDuration = fDuration * 2.0;    //Duration is +100%
    }
    //Create the Ability Bonus effect with the correct modifier
    eDex = EffectAbilityIncrease(ABILITY_DEXTERITY,nModify);
    effect eLink = EffectLinkEffects(eDex, eDur);

    //Apply visual and bonus effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
