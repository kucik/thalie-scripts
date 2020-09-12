#include "NW_I0_SPELLS"
void Drown(object oTarget,int iDC)
{
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    // * certain racial types are immune
    if ((GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
     &&(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
     &&(GetRacialType(oTarget) != RACIAL_TYPE_ELEMENTAL))
    {
        //Make a fortitude save
        if(MySavingThrow(SAVING_THROW_FORT, oTarget, iDC) == FALSE)
        {
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            int nDamage = GetCurrentHitPoints() / 2;
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(nDamage), OBJECT_SELF);

         }
    }
}
void main ()
{

    //Declare major variables
    object oTarget;
    int iDC = 25 + GetAbilityModifier(ABILITY_CHARISMA);

    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget) == TRUE)
    {
        //Fire cast spell at event for the specified target
         SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_DROWN));
         Drown(oTarget,iDC);
         oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF));
    }
}


