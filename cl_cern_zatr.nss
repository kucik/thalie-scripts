//::///////////////////////////////////////////////
//:: cl_cern_zatr
//:://////////////////////////////////////////////
/*
  Cernokneznik - zatraceni
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
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

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect ef = EffectAttackDecrease(1);
    effect eCon = EffectAbilityDecrease(ABILITY_CONSTITUTION,3);
    effect eDex = EffectAbilityDecrease(ABILITY_DEXTERITY,3);
    effect eCha = EffectAbilityDecrease(ABILITY_CHARISMA,3);
    effect eInt = EffectAbilityDecrease(ABILITY_INTELLIGENCE,3);
    effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH,3);
    effect eWis = EffectAbilityDecrease(ABILITY_WISDOM,3);

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        SendMessageToPC(OBJECT_SELF,"Prilis velke selhani mystickeho kouzla.");
        return;
    }
    int iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        // Make SR Check
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            // Make Will save vs Mind-Affecting
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                //Apply impact and linked effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ef, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCon, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWis, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCha, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInt, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStr, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDex, oTarget, TurnsToSeconds(1));


            }
        }
    }
}
