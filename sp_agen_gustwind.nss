//::///////////////////////////////////////////////
//:: Vzdusny Genasi - zavan vetru
//:: sp_agen_gustwind
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Shaman
//:: Created On: 21.7.2013
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/
    object oSoul = GetSoulStone(OBJECT_SELF);
    if (!GetLocalInt(oSoul,"RACIAL_ABILITY"))
    {
        return;
    }
    SetLocalInt(oSoul,"RACIAL_ABILITY",0);
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    string sAOETag;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetHitDice(oCaster);;
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
   // effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();

    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);


    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_AREA_OF_EFFECT);


    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            // Gust of wind should only destroy "cloud/fog like" area of effect spells.
            sAOETag = GetTag(oTarget);
            if ( sAOETag == "VFX_PER_FOGACID" ||
                 sAOETag == "VFX_PER_FOGKILL" ||
                 sAOETag == "VFX_PER_FOGBEWILDERMENT" ||
                 sAOETag == "VFX_PER_FOGSTINK" ||
                 sAOETag == "VFX_PER_FOGFIRE" ||
                 sAOETag == "VFX_PER_FOGMIND" ||
                 sAOETag == "VFX_PER_CREEPING_DOOM")
            {
                DestroyObject(oTarget);
            }
        }
        else
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

                // * unlocked doors will reverse their open state
                if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                {
                    if (GetLocked(oTarget) == FALSE)
                    {
                        if (GetIsOpen(oTarget) == FALSE)
                        {
                            AssignCommand(oTarget, ActionOpenDoor(oTarget));
                        }
                        else
                            AssignCommand(oTarget, ActionCloseDoor(oTarget));
                    }
                }
                if(!MyResistSpell(OBJECT_SELF, oTarget) && !/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF)))
                {

                    effect eKnockdown = EffectKnockdown();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));
                    // Apply effects to the currently selected target.
                 //   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                 }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }
}









