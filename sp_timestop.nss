//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons in the Area are frozen in time
    except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: Modified By: Grinning Fool
//:: Modified On: April 4, 2004
//::
//   Changes from standard:
//   - Limit to fSPELL_TIMESTOP_RADIUS radius
//   - use Cutscene paralyze/immobile to stop creaturtes/PCs from moving for
//     duration of spell.  Testing so far has revealted no issues with this.
//   - Apply improved invisibility to caster for duration of spell, to simulate
//     the intended effect of the caster moving so quickly that s/he can't be seen
//   - Use standard 3rd ed 1d4 + 1 rounds duration.
//   - Maximize effects if non-possessed GM casting, and bSPELL_TIMESTOP_DMEXTRA
//     has been set to TRUE.
// NOTES:
// THe stop effects are simulated via custcene-paralyze, which cannot be resisted.
// However, creatures immune to paralysis are not affected.  To help
// with that (not fix completely) the Cutscene immobilize effect is used;
// this prevents leg movement, but may allow other actions; specifically,
// may cause issues when used against spellcasting undead?

#include "x2_inc_spellhook"

// Radius in meters.
const float fSPELL_TIMESTOP_RADIUS = 50.0;

// Applies to 500 meter radius for GM, and uses 36 second duration.
// If DM is possessing a creature, this doesn't apply
const int   bSPELL_TIMESTOP_DMEXTRA = TRUE;


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


    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);

    effect eParalyze =  EffectCutsceneParalyze();
    effect eImmobile =  EffectCutsceneImmobilize();

    // Standard 3rd edition duration instead of 9 seconds.
    int nRounds = 1 + d4();

    float fDuration = RoundsToSeconds(nRounds);
    float fRange = fSPELL_TIMESTOP_RADIUS;
    object oCaster = OBJECT_SELF;

    string strAreaName = GetName(GetArea(oCaster));

    // Warn the DMs that a timestop has been cast.
  /*  if (GetIsDM(oCaster) && !GetIsDMPossessed(oCaster) && bSPELL_TIMESTOP_DMEXTRA) {
        nRounds = 6;
        fDuration = RoundsToSeconds(nRounds);
        fRange = 500.0;
        SendMessageToAllDMs("Timestop Alert [" + strAreaName + "]: MAX Timestop cast by DM " + GetName(oCaster) + " and will last for " + FloatToString(fDuration) + " seconds.");
    } else {
        SendMessageToAllDMs("Timestop Alert [" + strAreaName + "]: Timestop cast by " + GetName(oCaster) + " and will last for " + FloatToString(fDuration) + " seconds.");
    }

    // Notify the caster how long the spell will last.
    SendMessageToPC(oCaster, "This spell will last for " + IntToString(nRounds) + " rounds.");


    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    // Apply the VFX impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);

    // Force invisible on the caster ...simulate the 'moving too fast to be seen' effect that
    // is the intent of this spell.  Note that I toyed w/ using Cutscene invisiblity,
    // but found that it hides caster PC from the player... too bad, because it would have worked
    // better.  If caster is  near a PC, they will still see you in 'shadowy' form, until you move
    // out of range.
    DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
        EffectInvisibility(INVISIBILITY_TYPE_IMPROVED), oCaster, fDuration));*/

    // Begin loop to find all creatures within the fSPELL_TIMESTOP_RADIUS meter radius
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lTarget, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oCreature)) {

            if (GetIsPC(oCreature)) {
               SendMessageToPC(oCreature, "TIMESTOP SE BUDE RUSIT!!!");
            }



        oCreature =  GetNextObjectInShape(SHAPE_SPHERE, fSPELL_TIMESTOP_RADIUS, lTarget, FALSE, OBJECT_TYPE_CREATURE);
    }

}


