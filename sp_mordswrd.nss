//::///////////////////////////////////////////////
//:: Mordenkainen's Sword
//:: NW_S0_MordSwrd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a Helmed Horror to battle for the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwnx_funcs"
void __boostSummon() {
    // Boost summon
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    SendMessageToPC(OBJECT_SELF,"Summon name is"+GetName(oSummon));
    int iBonus = 0;
    if (GetHasFeat(FEAT_SPELL_FOCUS_TRANSMUTATION))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_TRANSMUTATION))
    {
        iBonus +=2;
    }
    if (GetHasFeat(FEAT_EPIC_SPELL_FOCUS_TRANSMUTATION))
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nDuration,FALSE);
    effect eSummon = EffectSummonCreature("NW_S_HelmHorr");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    DelayCommand(0.2,__boostSummon());
}

