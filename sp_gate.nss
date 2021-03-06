//::///////////////////////////////////////////////
//:: Gate
//:: NW_S0_Gate.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Summons a Balor to fight for the caster.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
void CreateBalor();
#include "x2_inc_spellhook"
#include "ku_boss_inc"
#include "nwnx_funcs"

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
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    nCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,nCasterLevel,FALSE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    object oTarget = GetSpellTargetObject();
    location lSpellTargetLOC;
    int Alignment = GetAlignmentGoodEvil(OBJECT_SELF);

    if (GetIsObjectValid(oTarget))
    {
        if ((GetRacialType((oTarget)) == RACIAL_TYPE_OUTSIDER))
        {
           if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF)))
           {

                            effect eKill = EffectDamage(GetCurrentHitPoints(oTarget));
                            //just to be extra-sure... :)
                            effect eDeath = EffectDeath(FALSE, FALSE);
                            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));


           }

        }

        lSpellTargetLOC = GetLocation(oTarget);
    }
    else
    {
        lSpellTargetLOC = GetSpellTargetLocation();
    }
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Summon the Balor and apply the VFX impact
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());

    if(Alignment == ALIGNMENT_GOOD){
        eSummon = EffectSummonCreature("ry_s_dracspl", VFX_FNF_SUMMON_GATE, 3.0);
        float fSeconds = RoundsToSeconds(nDuration);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));
        DelayCommand(4.2,__boostSummon(FEAT_SPELL_FOCUS_CONJURATION,FEAT_GREATER_SPELL_FOCUS_CONJURATION,FEAT_EPIC_SPELL_FOCUS_CONJURATION));
    }
    else if(Alignment == ALIGNMENT_NEUTRAL){
        eSummon = EffectSummonCreature("ry_s_bslaad", VFX_FNF_SUMMON_GATE, 3.0);
        float fSeconds = RoundsToSeconds(nDuration);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));
        DelayCommand(4.2,__boostSummon(FEAT_SPELL_FOCUS_CONJURATION,FEAT_GREATER_SPELL_FOCUS_CONJURATION,FEAT_EPIC_SPELL_FOCUS_CONJURATION));
    }

    else if(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
       GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL) ||
       GetHasSpellEffect(SPELL_HOLY_AURA))
    {
        eSummon = EffectSummonCreature("NW_S_BALOR",VFX_FNF_SUMMON_GATE,3.0);
        float fSeconds = RoundsToSeconds(nDuration);
        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpellTargetLOC, fSeconds));
        DelayCommand(4.2,__boostSummon(FEAT_SPELL_FOCUS_CONJURATION,FEAT_GREATER_SPELL_FOCUS_CONJURATION,FEAT_EPIC_SPELL_FOCUS_CONJURATION));

    }
    else
    {

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpellTargetLOC);
        DelayCommand(3.0, CreateBalor());
    }
}

void CreateBalor()
{
     CreateObject(OBJECT_TYPE_CREATURE, "NW_S_BALOR_EVIL", GetSpellTargetLocation());
}

