//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Heroic Shield
//:: cl_pdk_shield.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:: Edited By: Paulus
//:: Editen On: 01.10.2016
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

    //Declare major variables
    int iLvl = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,OBJECT_SELF);
    int iDuration = 3;
    int iAC = 2;
    if (iLvl>=5)
    {
        iAC = 3;
    }
    float fDuration = TurnsToSeconds(iDuration);
    effect eAC = EffectACIncrease(iAC);// Increase attack by 1



    // Chceme dalsi visual keen efektu?
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    // Extraordinary nejde dispellnout


    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);// Get VFX
    effect eLink = EffectLinkEffects(eAC, eDur);// Link effects
    eLink = ExtraordinaryEffect(eLink);// Make effects ExtraOrdinary

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
      // Prohozeni priority podminek na friendly a silence pro lepsi efektivitu.
      // self odstranen - jenom party members
      if(GetIsFriend(oTarget))
      {
          // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
          if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) &&
          !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
          {
            //shozeni stareho effektu
            effect eLoop=GetFirstEffect(oTarget);
            while (GetIsEffectValid(eLoop))
            {
                if (GetEffectSpellId(eLoop)==EFFECT_PDK)
                {
                    RemoveEffect(oTarget,eLoop);
                }
                eLoop=GetNextEffect(oTarget);
            }
            // oTarget is a friend, apply effects
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
         }
     }
   // Get next object in the sphere
   oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
   }
}
