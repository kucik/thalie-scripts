//::///////////////////////////////////////////////
//:: Polar ray
//:: [sp_PolarRay.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
  A blue-white ray of freezing air and ice springs
  from your hand. The ray deals 1d6 points of cold
  damage per caster level (maximum 25d6).
*/
//:://////////////////////////////////////////////
//:: Created By: P.A.
//:: Created On: Feb 27, 2014
//:://////////////////////////////////////////////



#include "NW_I0_SPELLS"
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
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    if (nCasterLevel>25)
    {
      nCasterLevel = 25;
    }
    int nDam = d10(nCasterLevel);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_FROST));
        eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);
        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Set damage effect
            eDam = EffectDamage(nDam, DAMAGE_TYPE_COLD);
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 0.7);
}
