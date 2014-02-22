//::///////////////////////////////////////////////
//:: cl_cern_tzho
//:://////////////////////////////////////////////
/*
   Tajemny vybuch cernokneznika - zhouba.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

#include "X0_I0_SPELLS"

#include "sh_classes_inc_e"
#include "sh_effects_const"
//:://////////////////////////////////////////////

void main()
{
    if (GetArcaneSpellFailure(OBJECT_SELF)> 20)
    {
        return;
    }
    //Declare major variables
    int iDCShape = 8;
    location lTargetLocation = GetSpellTargetLocation();
    int iDamage,iDC,iDur,iTouchAttackResult;
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    int iEsenceType = GetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
    effect eEf,eEf1,eEf2,eRay,eVis,eDur;
    float fDelay;
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
                //Get the distance between the target and caster to delay the application of effects
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;


            /* Send event */
            if (iEsenceType == ESENCE_TEMNA && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            else
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), TRUE));
            
            /* Apply spell */
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                switch (iEsenceType)
                {
                    case ESENCE_MAGIC:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage = GetReflexAdjustedDamage(iDamage, oTarget, 10+iDCShape, SAVING_THROW_TYPE_SPELL);
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget));
                    break;

                    case ESENCE_SZIRAVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 2 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_STRASLIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 2 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectFrightened();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_OSLEPUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectBlindness();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                       AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_PEKELNA:
                    ExecuteScript("x0_s0_inferno",oTarget);
                    break;

                    case ESENCE_MRAZIVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage = GetReflexAdjustedDamage(iDamage, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_COLD);
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    eDur = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_COLD, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,TurnsToSeconds(10))));
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_COLD);
                    AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget)));
                    break;

                    case ESENCE_UHRANCIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectConfused();
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_ZADRZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_POISON, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_ZHOUBNA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 6 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectParalyze();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_LEPTAVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDC = 10 + 6 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDamage = GetReflexAdjustedDamage(iDamage, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_ACID);
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                    AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget)));
                    break;

                    case ESENCE_SVAZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 7 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    eEf = EffectKnockdown();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_TEMNA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDC = 10 + 8 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDamage = GetReflexAdjustedDamage(iDamage, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_EVIL);
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_NEGATIVE);
                    eEf1 = EffectHeal(iDamage);
                    if (GetRacialType(oTarget)!= RACIAL_TYPE_UNDEAD)
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget));
                    }
                    else
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf1, oTarget));
                    }
                    eEf2 = EffectNegativeLevel(6);
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_EVIL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf2, oTarget,60.0));

                    }
                    break;

                    default:
                }
                effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
            }
            else
            {
                 if (iEsenceType== ESENCE_LEPTAVA)
                 {
                    iDamage = d6((iCasterLevel+1)/2);
                    if(iTouchAttackResult == 2)
                    {
                        iDamage *= 2;
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget));
                    effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

                 }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE);
    }
}

