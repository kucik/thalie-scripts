//::///////////////////////////////////////////////
//:: cl_cern_nepod
//:://////////////////////////////////////////////
/*
  Cernokneznik - Nepoddajnost
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
#include "sh_effects_const"
#include "x2_inc_spellhook"
#include "me_soul_inc"

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

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eHP = EffectTemporaryHitpoints(iCasterLevel);
    effect eLink = EffectLinkEffects(eHP, eDur);
    if (GetCurrentHitPoints() <= GetMaxHitPoints()+iCasterLevel)
    {
        //Apply visual and bonus effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(24));
    }
}

