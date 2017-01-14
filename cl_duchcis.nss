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
        effect eSave= EffectSavingThrowIncrease(SAVING_THROW_FORT,4);
		effect ePoison = EffectImmunity(IMMUNITY_TYPE_POISON);
		effect eDisease = EffectImmunity(IMMUNITY_TYPE_DISEASE);
        effect eLink = EffectLinkEffects(eSave, eDur);
		eLink = EffectLinkEffects (eLink, ePoison);
		eLink = EffectLinkEffects (eLink, eDisease);
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
                            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 901, FALSE));

                            //Apply Link and VFX effects to the target
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nCharismaBonus+5));
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        }
                        else if(GetIsFriend(oTarget))
                        {
                            // * Do not allow this to stack
                            RemoveEffectsFromSpell(oTarget, GetSpellId());

                            //Fire cast spell at event for the specified target
                            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 901, FALSE));

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
