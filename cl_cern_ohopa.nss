//::///////////////////////////////////////////////
//:: cl_cern_ohop
//:://////////////////////////////////////////////
/*
   Cernokneznik - ohniva opona.   : OnEnter
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

#include "X0_I0_SPELLS"
//:://////////////////////////////////////////////


#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    int nDamage;
    effect eDam,eDam1;
    object oTarget;
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {

        //Make SR check, and appropriate saving throw(s).
        if(!MyResistSpell(GetAreaOfEffectCreator(), oTarget))
        {
            //Roll damage.
                nDamage = d6(4);
                eDam1 = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                //Enter Metamagic conditions


                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 1.0);
                }
        }
    }
}
