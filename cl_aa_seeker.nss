//::///////////////////////////////////////////////
//:: x1_s2_seeker
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeker Arrow
     - creates an arrow that automatically hits target.
     - normal arrow damage, based on base item type

     - Must have shortbow or longbow in hand.


     APRIL 2003
     - gave it double damage to balance for the fact
       that since its a spell you are losing
       all your other attack actions

     SEPTEMBER 2003 (GZ)
        Added damage penetration
        Added correct enchantment bonus


*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
void main()
{
    object oTarget = GetSpellTargetObject();

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        int nDamage = ArcaneArcherCalculateBonus() + GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER)*2 + ArcaneArcherDamageDoneByBow() *2;
        if (nDamage > 0)
        {
            effect eMagic = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);

          //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 601));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);

        }
    }
}
