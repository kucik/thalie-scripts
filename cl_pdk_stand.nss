//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Final stand
//:: cl_pdk_stand.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:://////////////////////////////////////////////
#include "sh_classes_inc"

void main()
{



    int kontrola;
    object oPDK = OBJECT_SELF;


    int nCount = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPDK) + GetAbilityModifier(ABILITY_CHARISMA, oPDK);

    int nHP = d10(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPDK));
    effect eHP = EffectTemporaryHitpoints(nHP);// Increase hit points
    eHP = ExtraordinaryEffect(eHP);// Make effect ExtraOrdinary
    SetEffectSpellId(eHP,EFFECT_PDK);   //dodano shaman88
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);// Get VFX

    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), oPDK));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_FINAL_STAND), oPDK);

    int nTargetsLeft = nCount;// Number of targets equals level

    // Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

    // Cycle through the targets within the spell shape until you run out of targets.
    while (GetIsObjectValid(oTarget) && nTargetsLeft > 0)
    {



            if((oTarget == OBJECT_SELF) || GetIsNeutral(oTarget) || GetIsFriend(oTarget))
            {
                //shozeni stareho effektu
                effect eLoop=GetFirstEffect(oTarget);
                while (GetIsEffectValid(eLoop))
                {
                    if (GetEffectSpellId(eLoop)==EFFECT_PDK)
                    {
                        RemoveEffect(oTarget,eLoop);

                    }
                    eLoop=GetNextEffect(oTarget);
                }
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nCount));
            // Every time you apply effects, count down
            nTargetsLeft -= 1;
        }

        // Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }
}
