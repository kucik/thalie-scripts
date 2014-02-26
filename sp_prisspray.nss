//::///////////////////////////////////////////////
//:: Prismatic Spray
//:: [NW_S0_PrisSpray.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Sends out a prismatic cone that has a random
//:: effect for each target struck.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 19, 2000
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: Last Updated By: Aidan Scanlan On: April 11, 2001
//:: Last Updated By: Preston Watamaniuk, On: June 11, 2001
//:: Last Updated By: P.A., On: Feb 25, 2014
//:://///////////////////
//:: Added metamagic:
//:: extened spell = doubled length of effects  (blind, paralyze, confusion)
//:: empowered spell = number of effects applied to each targed increased to 2-4
//:: Any effect can not be applied multiple times.


int ApplyPrismaticEffect(int nEffect, object oTarget, int nMetaMagic);
int ConvertToBinary(int nRandAct);
void DebugBinaryValues(int nValue);


#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
// End of Spell Cast Hook

    //Declare major variables
    object oTarget;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nRandom;
    int nRandomNumRepeated;
    int nAppliedEffects; // number of applied effects
    int nEffectsToApply; // number of effects to be applied
    int nRandBinaryActual; // actual random number converted to binary
    int nRandBinaryAll; // combination of effects stored as a binary value
    int nRandNumRepeated = TRUE; // logical value used in loop
    int nRandAct; // actual random number
    int nHD;
    int nVisual;
    effect eVisual;

    //Set the delay to apply to effects based on the distance to the target
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    //Get first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget)) // loop over targets
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PRISMATIC_SPRAY));
            //Make an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                //Blind the target if they are less than 9 HD
                nHD = GetHitDice(oTarget);
                if (nHD <= 8)
                {
                    if (GetMetaMagicFeat() == METAMAGIC_EXTEND )
                    {   // extended spell - duration of effect doubled
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oTarget, RoundsToSeconds(2*nCasterLevel));
                    }
                    else
                    {   // no metatamagic
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oTarget, RoundsToSeconds(nCasterLevel));
                    }
                } // end of if (nHD <= 8)
                // Determine number of effect applied to a targed
                if (GetMetaMagicFeat() == METAMAGIC_EMPOWER  )
                {   // empowered spell, 2-4 effects
                     nEffectsToApply    = d3() + 1;
                }
                else
                {   // no metamagic 1-2 effects
                     nEffectsToApply    = d2();
                }
                nAppliedEffects = 0;
                nRandBinaryAll  = 0;
                // Identify and apply particular number of effects
                for (nAppliedEffects = 0; nAppliedEffects < nEffectsToApply; nAppliedEffects++)
                {
                    nRandomNumRepeated = TRUE;
                    while (nRandomNumRepeated)
                            { // I don't allow a situation, where a target will be hit multiple times by identical effect.
                        nRandAct = Random(6);
                        nRandBinaryActual = ConvertToBinary(nRandAct);
                        if ( nRandBinaryAll & nRandBinaryActual)
                        {   // the number is repeated, try new random number again
                            nRandomNumRepeated = TRUE;
                        }
                        else
                        {   // this random number has not been used, exit the while loop
                            nRandomNumRepeated = FALSE;
                            nRandBinaryAll |= nRandBinaryActual;
                        }
                    } // end of while (nRandomNumRepeated)
                    // Get visual effect
                    nVisual = ApplyPrismaticEffect(nRandAct, oTarget, nMetaMagic);
                    //Set the visual effect
                    if(nVisual != 0)
                    {
                        eVisual = EffectVisualEffect(nVisual);
                        //Apply the visual effect
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
                    }
                 } // end of for (nAppliedEffects = 0; nAppliedEffects =< nEffectsToApply; nAppliedEffects++)
            } //end if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
        } //end of if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, GetSpellTargetLocation());
    } // end of     while (GetIsObjectValid(oTarget))
} // end of main


///////////////////////////////////////////////////////////////////////////////
// ConvertToBinary
///////////////////////////////////////////////////////////////////////////////
/* This function allows conversion of a series of random int
numbers to a single binary number to prevent repetition of a particular random
number. */
///////////////////////////////////////////////////////////////////////////////
// Created By: P.A., Feb 25, 2014
///////////////////////////////////////////////////////////////////////////////
int ConvertToBinary(int nRandAct)
{
    int nBinary;
    switch(nRandAct)
        {
              case 0: nBinary = 1; break;
              case 1: nBinary = 2; break;
              case 2: nBinary = 4; break;
              case 3: nBinary = 8; break;
              case 4: nBinary = 16; break;
              case 5: nBinary = 32; break;
              case 6: nBinary = 64; break;
              case 7: nBinary = 128; break;
        } // end of switch
       return nBinary;
}




///////////////////////////////////////////////////////////////////////////////
// ApplyPrismaticEffect
///////////////////////////////////////////////////////////////////////////////
/* Given a reference integer and a target, this function will apply the effect
    of corresponding prismatic cone to the target. To have any effect the
    reference integer (nEffect) must be from 1 to 7.*/
///////////////////////////////////////////////////////////////////////////////
// Created By: Aidan Scanlan On: April 11, 2001
///////////////////////////////////////////////////////////////////////////////

int ApplyPrismaticEffect(int nEffect, object oTarget, int nMetaMagic)
{
    int nDamage;
    effect ePrism;
    effect eVis;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    int nVis;
    float fDelay = 0.5 + GetDistanceBetween(OBJECT_SELF, oTarget)/20;
    int nEffectSecDuration = 10; // in seconds
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND )
    {
        nEffectSecDuration = 20;
    }
    //Based on the random number passed in, apply the appropriate effect and set the visual to
    //the correct constant
    switch (nEffect)
    {
        case 0: //Confusion, no save
            {
                effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                ePrism = EffectConfused();
                eLink = EffectLinkEffects(eMind, ePrism);
                eLink = EffectLinkEffects(eLink, eDur);
                // if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay)) // will save canceled
                {
                    nVis = VFX_IMP_CONFUSION_S;
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nEffectSecDuration)));
                }
            }
        break;
        case 1: //fire
            nDamage = 20;
            nVis = VFX_IMP_FLAME_S;
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 2: //Acid
            nDamage = 40;
            nVis = VFX_IMP_ACID_L;
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 3: //Electricity
            nDamage = 80;
            nVis = VFX_IMP_LIGHTNING_S;
            ePrism = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePrism, oTarget));
        break;
        case 4: //Poison
            {
                effect ePoison = EffectPoison(POISON_BEBILITH_VENOM);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, ePoison, oTarget));
            }
        break;
        case 5: //Paralyze
            {
                effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
                // if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()) == 0) // fortitude save canceled
                {
                    ePrism = EffectParalyze();
                    eLink = EffectLinkEffects(eDur, ePrism);
                   eLink = EffectLinkEffects(eLink, eDur2);
                 DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nEffectSecDuration)));
                }
            }
        break;
    }  // end of  switch(nEffect)
    return nVis;
}
