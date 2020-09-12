#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "ku_boss_inc"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


    //Search through target area
    object oTarget = GetFirstObjectInArea();
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsObjectValid(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 972, FALSE));
        }
        //Get next target in the shape
        oTarget = GetNextObjectInArea();
    }
}

