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
        effect el1 = EffectDamageResistance(DAMAGE_TYPE_ACID,10);
         effect el2 = EffectDamageResistance(DAMAGE_TYPE_COLD,10);
          effect el3 = EffectDamageResistance(DAMAGE_TYPE_FIRE,10);
           effect el4 = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,10);
        effect eLink = EffectLinkEffects(el1, el2);
        eLink = EffectLinkEffects(eLink, el3);
        eLink = EffectLinkEffects(eLink, el4);
        eLink = EffectLinkEffects(eLink, eDur);
        eLink = SupernaturalEffect(eLink);

        if (nCharismaBonus>0)
        {
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

            while(GetIsObjectValid(oTarget))
            {
                        if(oTarget == OBJECT_SELF)
                        {
                            // * Do not allow this to stack
                            RemoveEffectsFromSpell(oTarget, GetSpellId());

                            //Fire cast spell at event for the specified target
                            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 902, FALSE));

                            //Apply Link and VFX effects to the target
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCharismaBonus+5));
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        }
                        else if(GetIsFriend(oTarget))
                        {
                            // * Do not allow this to stack
                            RemoveEffectsFromSpell(oTarget, GetSpellId());

                            //Fire cast spell at event for the specified target
                            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 902, FALSE));

                            //Apply Link and VFX effects to the target
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCharismaBonus+5));
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        }

                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
            }


        }

        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}
