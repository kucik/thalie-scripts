//::///////////////////////////////////////////////
//:: Acid Fog: Heartbeat
//:: NW_S0_AcidFogC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    nw_s0_acidfog.nss
    Vsechny potvory v oblasti pusobeni jsou zranovany za 1k6
    kyseliny za 4 urovne sesilatele a jejich rychlost pohybu
    je polovicni.
    Jedna se o Area effect - ten je resen pomoci specialni
    skriptu pro OnEnter, OnExit a OnHeartBeat.
    Konkretne: nw_s0_acidfoga,nw_s0_acidfogb,nw_s0_acidfogc
    Nelze v AOE skriptu zjistit caster lvl.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "sh_spells_inc"

void main()
{

    //Declare major variables

    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = d6(Random(9)+2);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    object oTarget;
    float fDelay;

        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = nDamage*5/2;//Damage is at max
        }
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
        }

   //--------------------------------------------------------------------------
    // GZ 2003-Oct-15
    // When the caster is no longer there, all functions calling
    // GetAreaOfEffectCreator will fail. Its better to remove the barrier then
    //--------------------------------------------------------------------------
    if (!GetIsObjectValid(GetAreaOfEffectCreator()))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }



    //Start cycling through the AOE Object for viable targets including doors and placable objects.
    oTarget = GetFirstInPersistentObject(OBJECT_SELF);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(oTarget), SAVING_THROW_TYPE_ACID, GetAreaOfEffectCreator(), fDelay))
            {
                 nDamage = d6();
            }
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            fDelay = GetRandomDelay(0.4, 1.2);
            //Fire cast spell at event for the affected target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_ACID_FOG));
            //Spell resistance check
            if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay))
            {
               //Apply damage and visuals
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target.
        oTarget = GetNextInPersistentObject(OBJECT_SELF);
    }
}
