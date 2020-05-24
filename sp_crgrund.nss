//::///////////////////////////////////////////////
//:: Create Greater Undead
//:: NW_S0_CrGrUnd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an undead type pegged to the character's
    level.
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
    int nDuration = nCasterLevel;
    nDuration = 24;
    effect eSummon;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Determine undead to summon based on level
    if (nCasterLevel <= 15)
    {
        eSummon = EffectSummonCreature("NW_S_VAMPIRE",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 16) && (nCasterLevel <= 17))
    {
        eSummon = EffectSummonCreature("NW_S_DOOMKGHT",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 18) && (nCasterLevel <= 19))
    {
        eSummon = EffectSummonCreature("NW_S_LICH",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        eSummon = EffectSummonCreature("NW_S_MUMCLERIC",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply summon effect and VFX impact.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    DelayCommand(0.2,__boostSummon());
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
}

