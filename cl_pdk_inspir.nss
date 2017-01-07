//::///////////////////////////////////////////////
//:: Purple Dragon Knight - Inspire Courage
//:: cl_pdk_inspir.nss
//:://////////////////////////////////////////////
//::
//::
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On: 25.6.2011
//:: Edited  By: Paulus
//:: Edited  On: 04.10.2016
//:://////////////////////////////////////////////
     #include "x0_i0_spells"

     #include "sh_classes_inc"

     void main()

    {

        int kontrola;
        if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))

        {

         // Not useable when silenced. Floating text to user
            FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
            return;
        }

     //Declare major variables
     object oPDK = OBJECT_SELF;

     int nCount = GetLevelByClass(41, oPDK) + GetAbilityModifier(ABILITY_CHARISMA, oPDK);
     int nHP =  d10(((GetLevelByClass(41, oPDK))/6)+1); // Count of d10
     int iCHA = GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
     int iLvl = GetLevelByClass(41,OBJECT_SELF);
     int nDuration = 10 + iLvl + iCHA;
     int iBonus = (iLvl / 6)+1;

     effect eSaveFEffectSavingThrowIncrease = EffectSavingThrowIncrease(SAVING_THROW_ALL, iBonus);// Saving throw increase
     effect eHP = EffectTemporaryHitpoints(nHP); //Temporary HP increase
     effect eImmune = EffectImmunity(IMMUNITY_TYPE_FEAR); //fear immunity
     effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE); // Get VFX

     effect eLink = EffectLinkEffects(eSaveFEffectSavingThrowIncrease, eHP);
     eLink = EffectLinkEffects(eLink, eImmune);
     eLink = EffectLinkEffects(eLink, eDur);// link VFXs
     eLink = ExtraordinaryEffect(eLink); // make effects ExtraOrdinary

     SetEffectSpellId(eLink,EFFECT_PDK); //dodano shaman88

     effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);// Get VFX

     // Apply effect at location

     ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_INSPIRE_COURAGE), OBJECT_SELF);

     DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));


     // Get first target

     object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));


     // Keep processing while oTarget is valid

        while(GetIsObjectValid(oTarget))
        {

            // * GZ Oct 2003: If we are silenced, we can not benefit from bard song

            if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))

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

                    // oTarget is a friend, apply effects
                    DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

                }
            }
			
            // Get next object in the sphere
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

        }
    }
	