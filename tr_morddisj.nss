//::///////////////////////////////////////////////
//:: Mordenkainen's Disjunction Trap trigger
//:://////////////////////////////////////////////
/*
    Massive Dispel Magic and Spell Breach rolled into one
    If the target is a general area of effect they lose
    6 spell protections.  If it is an area of effect everyone
    in the area loses 2 spells protections.
*/
//:://////////////////////////////////////////////
void StripEffects(int nNumber, object oTarget);
#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"

const int def_caster_level = 40;

void main()
{

    //--------------------------------------------------------------------------
    /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

     effect  eVis        = EffectVisualEffect(VFX_IMP_HEAD_ODD);
    effect   eImpact     = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    object   oTarget     = GetEnteringObject();
//    location lLocal      = GetSpellTargetLocation();
    int      nCasterLevel= GetLocalInt(OBJECT_SELF, "CASTER_LEVEL");
    if(nCasterLevel <= 0)
      nCasterLevel = def_caster_level;


    //--------------------------------------------------------------------------
    // Mord's is not capped anymore as we can go past level 20 now
    //--------------------------------------------------------------------------
    /*
        if(nCasterLevel > 20)
        {
            nCasterLevel = 20;
        }
    */

    if (GetIsObjectValid(oTarget))
    {
        //----------------------------------------------------------------------
        // Targeted Dispel - Dispel all
        //----------------------------------------------------------------------
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact,TRUE,TRUE); /* Here the last boolean (TRUE)
        // means that after a try to dispell all on a target, greater spell breach will also be applied. I.e.
        // if the last boolean is TRUE, this raw equals to:
        // spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, TRUE);
        // DoSpellBreach(oTarget, 6, 10, GetSpellId());
        // End of comment, P. A. March 15, 2014
        */
    }
}
