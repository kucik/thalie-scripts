//::///////////////////////////////////////////////
//:: Animate Dead
//:: NW_S0_AnimDead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a powerful skeleton or zombie depending
    on caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////

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
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int iDamageReductionSoak = DAMAGE_POWER_PLUS_ONE;
    int iSword = 0;
    nDuration = 24;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }
    //Summon the appropriate creature based on the summoner level
    if (nCasterLevel <= 5)
    {
        //Tyrant Fog Zombie
        eSummon = EffectSummonCreature("NW_S_ZOMBTYRANT",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_TWO;
    }
    else if ((nCasterLevel >= 6) && (nCasterLevel <= 9))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("NW_S_SKELWARR",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_THREE;
    }
    else
    {
        //Skeleton Chieftain
        eSummon = EffectSummonCreature("NW_S_SKELCHIEF",VFX_FNF_SUMMON_UNDEAD);
        iDamageReductionSoak = DAMAGE_POWER_PLUS_FOUR;
        iSword = 1;

    }
    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    effect eSoak =EffectDamageReduction(15,iDamageReductionSoak);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSoak,GetAssociate(ASSOCIATE_TYPE_SUMMONED)));
    if (iSword)
    {
        DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_NEGATIVE),GetAssociate(ASSOCIATE_TYPE_SUMMONED)));
    }
}


