//::///////////////////////////////////////////////
//:: Rovnost pred radem
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all spell defenses from an enemy mage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{



// End of Spell Cast Hook


    DoSpellBreach(GetSpellTargetObject(), 50,0);
}


