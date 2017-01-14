//::///////////////////////////////////////////////
//:: Divine Shield
//:: x0_s2_divshield.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Up to [turn undead] times per day the character may add his Charisma bonus to his armor
    class for a number of rounds equal to the Charisma bonus.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13, 2002
//:://////////////////////////////////////////////
#include "x0_i0_spells"

void main()
{

   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(40550);
   }
   else
   if(GetHasFeatEffect(413) == FALSE)
   {
        //Declare major variables
        object oTarget = GetSpellTargetObject();
        int nLevel = GetCasterLevel(OBJECT_SELF);

        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        {


            effect eDamage1 = EffectDamageIncrease(IP_CONST_DAMAGEBONUS_2d6,DAMAGE_TYPE_POSITIVE);
            effect eVS = VersusRacialTypeEffect(eDamage1,RACIAL_TYPE_UNDEAD);
            effect eLink = EffectLinkEffects(eVS, eDur);
            eLink = SupernaturalEffect(eLink);

            // * Do not allow this to stack
            RemoveEffectsFromSpell(oTarget, GetSpellId());

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 899, FALSE));

            //Apply Link and VFX effects to the target
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCharismaBonus+5));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}
