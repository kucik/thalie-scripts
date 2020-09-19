#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
  //Declare major variables
  effect eVis = EffectVisualEffect(246);
  effect eHeal,eDam;
  float fDelay;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  int iDamage,iHeal;
  iDamage = GetMaxHitPoints()/10*3;
  eDam = EffectDamage(iDamage,DAMAGE_TYPE_NEGATIVE);
  //Apply the VFX impact and effects
  DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
  location lLoc = GetLocation(OBJECT_SELF);
  //Get first target in spell area
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc);
  while(GetIsObjectValid(oTarget))
  {
      fDelay = GetRandomDelay();
      //Make a faction check
      if((GetIsFriend(oTarget)) &&(oTarget!=OBJECT_SELF))
      {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL, FALSE));
                //Determine amount to heal
                                //Set the damage effect
                eHeal = EffectHeal(GetMaxHitPoints(oTarget)/2);
                //Apply the VFX impact and heal effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));

      }
      //Get next target in the spell area
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc);
   }
}
