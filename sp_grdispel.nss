//::///////////////////////////////////////////////
//:: Greater Dispelling
//:: NW_S0_GrDispel.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:: Updated On: Oct 20, 2003, Georg Zoeller
//:: Last updated by P.A., March 15, 2014
//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "x2_inc_spellhook"

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

    effect   eVis         = EffectVisualEffect( VFX_IMP_BREACH );
    effect   eImpact      = EffectVisualEffect( VFX_FNF_DISPEL_GREATER );
    int      nCasterLevel = GetCasterLevel( OBJECT_SELF ); // here the caster lvl was increased by 15!
    object   oTarget      = GetSpellTargetObject();
    location lLocal   =     GetSpellTargetLocation();

    //--------------------------------------------------------------------------
    // Caster level progress above 10
    //--------------------------------------------------------------------------
    if(nCasterLevel > 15)
    {
        // +1 per caster level till 5
        // +1 per two caster leves above 5
        nCasterLevel = 15 + (nCasterLevel - 15) / 2;
    }

    //--------------------------------------------------------------------------
    // Dispel Magic is capped at caster level 10
    //--------------------------------------------------------------------------


    if (GetIsObjectValid(oTarget))
    {
        //----------------------------------------------------------------------
        // Targeted Dispel - Dispel all
        //----------------------------------------------------------------------
        spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact);
        // DoSpellBreach(oTarget, 2,0); // why spell breach??? commented out!
    }
    else
    {
        //----------------------------------------------------------------------
        // Area of Effect - Only dispel best effect
        //----------------------------------------------------------------------
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                //--------------------------------------------------------------
                // Handle Area of Effects
                //--------------------------------------------------------------
                spellsDispelAoE(oTarget, OBJECT_SELF, nCasterLevel);
            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            }
            else
            {
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lLocal, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }

}
