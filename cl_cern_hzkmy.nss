//::///////////////////////////////////////////////
//:: cl_cern_hzkmy
//:://////////////////////////////////////////////
/*
  Cernokneznik - hlubinna zkaza mysli
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
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    int iCount = 0;
    object oTarget = GetSpellTargetObject();
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect ef1 = EffectFrightened();
    effect ef2 = EffectDazed();
    effect ef3 = EffectAbilityDecrease(ABILITY_WISDOM,d2((iCasterLevel+1)/2));
    effect eLink2 = EffectLinkEffects(ef1,ef2);

    int iDC = 10 + 9 + GetAbilityModifier(ABILITY_CHARISMA);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        // Make SR Check
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            // Make Will save vs Mind-Affecting
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                  iCount++;
            }
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                  iCount++;
            }
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                  iCount++;
            }
            switch (iCount)
            {
                case 1:
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ef1, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                break;

                case 2:
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                break;

                case 3:
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, TurnsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ef3, oTarget, TurnsToSeconds(5));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                break;



            }


        }
    }
}
