#include "x2_inc_spellhook"
//#include "sh_classes_const"
#include "nwnx_funcs"
#include "me_soul_inc"

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
    int nDuration = 24;
    effect eSummon = EffectSummonCreature("dom_chaos9");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    DelayCommand(0.2,__boostSummon(FEAT_SPELL_FOCUS_CONJURATION,FEAT_GREATER_SPELL_FOCUS_CONJURATION,FEAT_EPIC_SPELL_FOCUS_CONJURATION));
}
