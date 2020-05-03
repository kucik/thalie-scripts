//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Final stand
//:: cl_pdk_stand.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:://////////////////////////////////////////////
#include "sh_classes_inc"
#include "x0_i0_spells"
void main()
{
    int kontrola;
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        // Nelze pouzit kdyz ma silence
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
        return;
    }

    float fDuration = TurnsToSeconds(60);

     // Chceme dalsi visual keen efektu?
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    // Extraordinary nejde dispellnout


    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);// Get VFX

    // SetEffectSpellId(eLink,EFFECT_PDK); //dodano shaman88
    effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);// Get VFX

   // Apply effect at a location
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY), OBJECT_SELF);
   DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));

   // Get first object in sphere
   object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
   // Keep processing until oTarget is not valid
   while(GetIsObjectValid(oTarget))
   {
      if((oTarget == OBJECT_SELF) || GetIsFriend(oTarget))
      {
          int iCurrentHitPoints = GetCurrentHitPoints(oTarget);
          int iMaxHitPoints = GetMaxHitPoints(oTarget);
          if ((iCurrentHitPoints <= iMaxHitPoints)&&(IntToFloat(iCurrentHitPoints) >= (iMaxHitPoints*0.9)))
          {
            int iHD = GetHitDice(oTarget);
            int iHP = 5*iHD;
            effect eHP = EffectTemporaryHitpoints(iHP);
            effect eLink = EffectLinkEffects(eHP, eDur);// Link effects
            eLink = ExtraordinaryEffect(eLink);// Make effects ExtraOrdinary
            // oTarget is a friend, apply effects
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
         }
       }
    // Get next object in the sphere
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
   }
}
