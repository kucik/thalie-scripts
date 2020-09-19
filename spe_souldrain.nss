#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

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
    object oCaster = OBJECT_SELF;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_EVIL_20); //Replace with Negative Pulse
    int nSpellDC = GetEpicSpellSaveDC(OBJECT_SELF)+GetThalieEpicSpellDCBonus(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eDam, eHeal;
    int iSum = 0;
    int nDamage;
    float fDelay;

    //Get the spell target location as opposed to the spell target.
    location lTarget = GetLocation(OBJECT_SELF);
    //Apply the explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
       if((GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD) && (GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)&& (oTarget!= OBJECT_SELF))
       {
            //Roll damage for each target
            nDamage = d6(25);
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            if (MySavingThrow(SAVING_THROW_FORT,oTarget,nSpellDC,SAVING_THROW_TYPE_DEATH) >0)
            {
                nDamage /=2;
            }
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            iSum += nDamage;
       }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }
   effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
   eHeal = EffectHeal(iSum);
   //Apply the heal effect and the VFX impact
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
}
