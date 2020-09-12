//::///////////////////////////////////////////////
//:: Planar Ally
//:: X0_S0_Planar.nss
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
//:: Modified from Planar binding
//:: Hold ability removed for cleric version of spell

#include "NW_I0_SPELLS"
#include "nwnx_funcs"


#include "x2_inc_spellhook"

void __boostSummon() {
    // Boost summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    SendMessageToPC(OBJECT_SELF,"Summon name is"+GetName(oSummon));
    int iBonus = 0;
    if (GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_CONJURATION))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION))
    {
        iBonus +=2;
    }
    if (iBonus>0)
    {
        SetAbilityScore(oSummon,ABILITY_DEXTERITY,GetAbilityScore(oSummon,ABILITY_DEXTERITY,TRUE)+iBonus);
        SetAbilityScore(oSummon,ABILITY_STRENGTH,GetAbilityScore(oSummon,ABILITY_STRENGTH,TRUE)+iBonus);
        SetAbilityScore(oSummon,ABILITY_CONSTITUTION,GetAbilityScore(oSummon,ABILITY_CONSTITUTION,TRUE)+iBonus);
    }
}

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
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    nCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nCasterLevel,FALSE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eGate;


    int nRacial = GetRacialType(oTarget);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nDuration == 0)
    {
        nDuration == 1;
    }
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }

    //Set the summon effect based on the alignment of the caster
    float fDelay = 3.0;
    switch (nAlign)
    {
        case ALIGNMENT_EVIL:
            eSummon = EffectSummonCreature("NW_S_SUCCUBUS",VFX_FNF_SUMMON_GATE, fDelay);
            //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
        break;
        case ALIGNMENT_GOOD:
            eSummon = EffectSummonCreature("NW_S_CHOUND", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            //eGate = EffectVisualEffect(219);
        break;
        case ALIGNMENT_NEUTRAL:
            eSummon = EffectSummonCreature("NW_S_SLAADGRN",VFX_FNF_SUMMON_MONSTER_3, 1.0);
            //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
            //fDelay = 1.0;
        break;
    }
    //Apply the summon effect and VFX impact
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    DelayCommand(4.2,__boostSummon());
}

