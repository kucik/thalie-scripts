//::///////////////////////////////////////////////
//:: Circle of Death
//:: NW_S0_CircDeath
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster slays a number of HD worth of creatures
    equal to 1d4 times level.  The creature gets a
    Fort Save or dies.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: June 1, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Aidan Scanlan
//:: VFX Pass By: Preston W, On: June 20, 2001
//:: Update Pass By: Preston W, On: July 25, 2001

#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"
#include "ku_boss_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/
    if (GetHasFeat(FEAT_PRESTIGE_IMBUE_ARROW))
    {
        if (IsImbueArrow(GetSpellTargetObject(), GetSpellId()))
        {
            return;
        }
    }
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget;
    effect eDeath =  EffectDeath();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    int bContinueLoop = FALSE; //Used to determine if we have a next valid target
    int bAlreadyAffected;
    int nMax = 10;// maximun hd creature affected, set this to 9 so that a lower HD creature is chosen automatically
    //Also 9 is the maximum HD a creature can have and still be affected by the spell
    float fDelay;
    string sIdentifier = GetTag(OBJECT_SELF);


    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetSpellTargetLocation());
    //Check for at least one valid object to start the main loop
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    if (GetIsObjectValid(oTarget))
    {
        bContinueLoop = TRUE;
    }
    // The above checks to see if there is at least one valid target.  If no value target exists we do not enter
    // the loop.

    while ((bContinueLoop))
    {
        bContinueLoop = FALSE; //Set this to false so that the loop only continues in the case of new low HD creature
        //Get first target creature in loop
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget))
        {
            //Make sure the currect target is not an enemy
            if (oTarget != OBJECT_SELF)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CIRCLE_OF_DEATH));
                fDelay = GetRandomDelay();
                //Make a Fort Save versus death effects
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                {
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                }


            }
            //Get next target in shape to test for a new
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
        }

     }

}
