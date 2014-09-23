//::///////////////////////////////////////////////
//:: Wall of Fire: Heartbeat
//:: nw_s0_wallfirec.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Person within the AoE take up to lvl*d6 fire damage
    per round (up to 15d6). If target fails reflex throw
    it is knocked down for one round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:: Last updated by P.A., March 14, 2014
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDebug;
    effect eDam;
    object oTarget;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Capture the first target object in the shape.

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

    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Declare the spell shape, size and the location.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WALL_OF_FIRE));
            //Make SR check, and appropriate saving throw(s).
            if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget))
            {
                //Roll damage.
            nDamage = d6(15);
            //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = 90;//Damage is at max
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                }
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_TYPE_FIRE);
            if (GetIsPC( oTarget ) ) // DEBUG
            {  // DEBUG 
                SendMessageToPC(oTarget, "DEBUG 1: dmg=" + IntToString(nDamage));  // DEBUG 
            }    // DEBUG
            // if target fails reflex save - knock it down
            nDebug = MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_TYPE_FIRE);
            if (GetIsPC( oTarget ) ) // DEBUG
            { // DEBUG
                SendMessageToPC(oTarget, "DEBUG 2: knock-test result = " + IntToString(nDebug)); // DEBUG
            }     // DEBUG          
            //if (!MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_REFLEX) )
            if (nDebug == 0 )
            { // target fails in reflex save - knock it down
                effect eKnockDown = EffectKnockdown();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oTarget,RoundsToSeconds(1));
            }
            // apply damage
            if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 1.0);
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
