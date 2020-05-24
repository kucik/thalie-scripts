//::///////////////////////////////////////////////
//:: Create Undead
//:: NW_S0_CrUndead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spell summons a Ghoul, Shadow, Ghast, Wight or
    Wraith
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwnx_funcs"

void __boostSummon() {
    // Boost summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    SendMessageToPC(OBJECT_SELF,"Summon name is"+GetName(oSummon));
    int iBonus = 0;
    if (GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_NECROMANCY))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY))
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
    int nDuration = nCasterLevel;
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Set the summoned undead to the appropriate template based on the caster level
    if (nCasterLevel <= 11)
    {
        eSummon = EffectSummonCreature("x2_s_mummy",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 12) && (nCasterLevel <= 13))
    {
        eSummon = EffectSummonCreature("x2_s_mummy_9",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 14) && (nCasterLevel <= 15))
    {
        eSummon = EffectSummonCreature("nw_s_mumfight",VFX_FNF_SUMMON_UNDEAD); // change later
    }
    else if ((nCasterLevel >= 16))
    {
        eSummon = EffectSummonCreature("nw_s_mumcleric",VFX_FNF_SUMMON_UNDEAD);
    }

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    DelayCommand(0.2,__boostSummon());
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
}

