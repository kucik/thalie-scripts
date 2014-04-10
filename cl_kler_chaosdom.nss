/*
Summons the 'fiendish' servant for the player.
This is a modified version of x0_s2_fiend.nss

At Level 5 the Cleric gets a Succubus
At Level 9 the Cleric will get a Vrock
Will remain for one hour per level of cleric
*/

void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
    effect eSummon;
    float fDelay = 3.0;
    int nDuration = nLevel;

    if (nLevel < 7)
    {
        eSummon = EffectSummonCreature("NW_S_SUCCUBUS",VFX_FNF_SUMMON_GATE, fDelay);
    }
    else if (nLevel < 15 )
    {
        eSummon = EffectSummonCreature("NW_S_VROCK", VFX_FNF_SUMMON_GATE, fDelay);
    }
    else
    {
       if (GetHasFeat(1003,OBJECT_SELF)) // epic fiend feat
       {
           eSummon = EffectSummonCreature("x2_s_vrock", VFX_FNF_SUMMON_GATE, fDelay);
       }
       else
       {
        eSummon = EffectSummonCreature("NW_S_VROCK", VFX_FNF_SUMMON_GATE, fDelay);
       }
    }
    
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}
