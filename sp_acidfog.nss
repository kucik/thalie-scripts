//::///////////////////////////////////////////////
//:: Acid Fog
//:: sp_AcidFog.nss
//:://////////////////////////////////////////////
/*
    sp_acidfog.nss
    Vsechny potvory v oblasti pusobeni jsou zranovany za 1k6
    kyseliny za 4 urovne sesilatele a jejich rychlost pohybu
    je polovicni.
    Jedna se o Area effect - ten je resen pomoci specialni
    skriptu pro OnEnter, OnExit a OnHeartBeat.
    Konkretne: nw_s0_acidfoga,nw_s0_acidfogb,nw_s0_acidfogc
    Nelze v AOE skriptu zjistit caster lvl.
*/
//:://////////////////////////////////////////////



#include "x2_inc_spellhook"

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


    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID,"sp_acidfoga","sp_acidfogc","sp_acidfog");
    location lTarget = GetSpellTargetLocation();
    int nDuration = GetCasterLevel(OBJECT_SELF) / 2;
    int nMetaMagic = GetMetaMagicFeat();
    effect eImpact = EffectVisualEffect(257);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
