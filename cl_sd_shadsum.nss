//::///////////////////////////////////////////////
//:: Summon Shadow
//:: X0_S2_ShadSum.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PRESTIGE CLASS VERSION
    Spell powerful ally from the shadow plane to
    battle for the wizard
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(27);
    effect eSummon;

    if (GetHasFeat(1002,OBJECT_SELF))
    {
        eSummon = EffectSummonCreature("sd_summon4",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >=10)
    {
        eSummon = EffectSummonCreature("sd_summon3",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >=7)
    {
        eSummon = EffectSummonCreature("sd_summon2",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        eSummon = EffectSummonCreature("sd_summon1",VFX_FNF_SUMMON_UNDEAD);
    }


    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(24));
}
