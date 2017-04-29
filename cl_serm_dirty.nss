//::///////////////////////////////////////////////
//:: Blindness and Deafness
//:: [NW_S0_BlindDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Causes the target creature to make a Fort
//:: save or be blinded and deafened.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ku_boss_inc"

void main()
{
   object oPC = OBJECT_SELF;
   if (!GetHasFeat(1647, OBJECT_SELF))
   {
        SendMessageToPC(OBJECT_SELF,"Jiz nemas zadne finty.");
   }
   else
   {
        //Declare major varibles
        object oTarget = GetSpellTargetObject();
        int iDC = 10 + (GetHitDice(oPC)/2)+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        int iDuration = 2;
        if (GetHasFeat(1649,oPC) == TRUE)
        {
            iDC += 2;
            iDuration += 1;
        }
        if (GetHasFeat(1650,oPC) == TRUE)
        {
            iDC += 2;
            iDuration += 1;
        }
        if (GetHasFeat(1651,oPC) == TRUE)
        {
            iDC += 2;
            iDuration += 1;
        }

        effect eBlind =  EffectBlindness();
        effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink = EffectLinkEffects(eBlind, eDur);

        //Fire cast spell at event
        SignalEvent(oTarget, EventSpellCastAt(oPC, 978));
        if (!/*Reflex Save*/ MySavingThrow(SAVING_THROW_REFLEX, oTarget, iDC))
        {
                //Apply visual and effects
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        DecrementRemainingFeatUses(OBJECT_SELF, 1647);
    }
}
