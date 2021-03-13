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
    object oTarget;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eSleep =  EffectSleep();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);

    effect eLink = EffectLinkEffects(eSleep, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

     // * Moved the linking for the ZZZZs into the later code
     // * so that they won't appear if creature immune

    int bContinueLoop;
    int nCurrentHD;
    int bAlreadyAffected;
    int nLow;
    int nDuration = GetHitDice(OBJECT_SELF);
    int nScaledDuration;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    string sSpellLocal = "BIOWARE_SPELL_LOCAL_SLEEP_" + ObjectToString(OBJECT_SELF);


        //Get the first creature in the spell area
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget))
        {
            //Make faction check to ignore allies
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)
                && GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLEEP));
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    //Make Fort save
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, 10+nDuration/2+GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF)))
                    {
                        //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oLowest);
                        if (!GetIsBoss(oTarget) && GetIsImmune(oTarget, IMMUNITY_TYPE_SLEEP) == FALSE)
                        {
                            effect eLink2 = EffectLinkEffects(eLink, eVis);
                            nScaledDuration = GetScaledDuration(nDuration, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nScaledDuration));
                        }
                        else
                        // * even though I am immune apply just the sleep effect for the immunity message
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oTarget, RoundsToSeconds(nDuration));
                        }

                    }
                }
            }
            //Get the next target in the shape
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
        }
}
