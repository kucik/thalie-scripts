//::///////////////////////////////////////////////
//:: cl_cern_povys
//:://////////////////////////////////////////////
/*
  Cernokneznik - Podle vysmeknuti
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////
//#include "sh_classes_inc"
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

    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    int iCasterLevel = GetLevelByClass(44,OBJECT_SELF) ; //CLASS_TYPE_CERNOKNEZNIK
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eIm = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
    effect eLink = EffectLinkEffects(eIm, eDur);
    //Apply visual and bonus effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(1));

}

