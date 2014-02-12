//::///////////////////////////////////////////////
//:: Chain Lightning
//:: NW_S0_ChLightn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The primary target is struck with 1d6 per caster,
    1/2 with a reflex save.  1 secondary target per
    level is struck for 1d6 / 2 caster levels.  No
    repeat targets can be chosen.
*/
//:://////////////////////////////////////////////
//:: Created By: Brennon Holmes
//:: Created On:  March 8, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 26, 2001
//:: Update Pass By: Preston W, On: July 26, 2001

/*
bugfix by Kovi 2002.07.28
- successful saving throw and (improved) evasion was ignored for
 secondary targets,
- all secondary targets suffered exactly the same damage
2002.08.25
- primary target was not effected
*/

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "sh_effects_const"

void main()
{

    //Declare major variables
    int iDCShape = 4;
    effect eLightning = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);;
    object oFirstTarget = GetSpellTargetObject();
    int iDamage,iDC,iDur,iTouchAttackResult,nCnt;
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    object oSaveItem = GetSoulStone(OBJECT_SELF);
    int iEsenceType = GetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
    effect eEf,eEf1,eEf2,eRay,eVis,eDur;
    object oTarget,oHolder;
    int iMaxTargets = ((iCasterLevel + 1) / 5) + 1;
    nCnt =1;
    iTouchAttackResult = TouchAttackRanged(oFirstTarget);
    if (MyResistSpell(OBJECT_SELF, oFirstTarget))
    {
        //first target
        if (iEsenceType== ESENCE_LEPTAVA)
        {
            iDamage = d6((iCasterLevel+1)/2);
            if(iTouchAttackResult == 2)
            {
                iDamage *= 2;
            }
            eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
            AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oFirstTarget));

            effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oFirstTarget, 1.7);
            eLightning = EffectBeam(VFX_BEAM_BLACK, oFirstTarget, BODY_NODE_CHEST);
            float fDelay = 0.2;

            //dalsi cile
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
            while (GetIsObjectValid(oTarget) && nCnt <= iMaxTargets)
            {
                if (oTarget != oFirstTarget && oTarget != OBJECT_SELF)
                {
                    iDamage=FloatToInt(iDamage*(1-(nCnt/(IntToFloat(nCnt)+1))));
                    //Connect the new lightning stream to the older target and the new target
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.7));
                    // samotny kod
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget));
                    //
                    oHolder = oTarget;

                    //change the currect holder of the lightning stream to the current target
                    eLightning = EffectBeam(VFX_BEAM_BLACK, oHolder, BODY_NODE_CHEST);
                    fDelay = fDelay + 0.1f;
                }
                nCnt++;

                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
            }
        }
        return;
    }
    //Damage the initial target
    if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    {
        if (( iTouchAttackResult > 0) && (GetArcaneSpellFailure(OBJECT_SELF)<= 20))
        {
                switch (iEsenceType)
                {
                    case ESENCE_MAGIC:
                    iDamage = d6((iCasterLevel+1)/2);
                    if(iTouchAttackResult == 2)
                    {
                        iDamage *= 2;
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oFirstTarget));
                    break;

                    case ESENCE_SZIRAVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 2 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 10;
                        iDur = 3;
                    }
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_STRASLIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 2 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 10;
                        iDur = 3;
                    }
                    eEf = EffectFrightened();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_OSLEPUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 10;
                        iDur = 3;
                    }
                    eEf = EffectBlindness();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_PEKELNA:
                    ExecuteScript("x0_s0_inferno",oFirstTarget);
                    break;

                    case ESENCE_MRAZIVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    if(iTouchAttackResult == 2)
                    {
                        iDamage *= 2;
                        iDC += 10;
                    }
                    eDur = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
                    if(!MySavingThrow(SAVING_THROW_FORT, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_COLD, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oFirstTarget,TurnsToSeconds(10)));
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_COLD);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oFirstTarget));
                    break;

                    case ESENCE_UHRANCIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 6;
                        iDur = 3;
                    }
                    eEf = EffectConfused();
                    if(!MySavingThrow(SAVING_THROW_FORT, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_ZADRZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 6;
                        iDur = 3;
                    }
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_ZHOUBNA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 6 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 6;
                        iDur = 3;
                    }
                    eEf = EffectParalyze();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_LEPTAVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    if(iTouchAttackResult == 2)
                    {
                        iDamage *= 2;
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oFirstTarget));
                    break;

                    case ESENCE_SVAZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 7 + GetAbilityModifier(ABILITY_CHARISMA);
                    iDur = 1;
                    if(iTouchAttackResult == 2)
                    {
                        iDC += 6;
                        iDur = 3;
                    }
                    eEf = EffectKnockdown();
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,RoundsToSeconds(iDur)));
                    }
                    break;

                    case ESENCE_TEMNA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDC = 10 + 8 + GetAbilityModifier(ABILITY_CHARISMA);
                    if(iTouchAttackResult == 2)
                    {
                        iDamage *= 2;
                        iDC += 6;
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_NEGATIVE);
                    AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oFirstTarget));
                    eEf1 = EffectNegativeLevel(6);
                    if(!MySavingThrow(SAVING_THROW_WILL, oFirstTarget, iDC+iDCShape, SAVING_THROW_TYPE_EVIL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oFirstTarget,TurnsToSeconds(10)));
                    }
                    break;

                    default:
                //konec switche
                }
                effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oFirstTarget, 1.7);


        }
        else
        {
            effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND,TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oFirstTarget, 1.7);

        }


    }
    eLightning = EffectBeam(VFX_BEAM_BLACK, oFirstTarget, BODY_NODE_CHEST);
    float fDelay = 0.2;


    // *
    // * Secondary Targets
    // *


    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt <= iMaxTargets)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.7));


            // samotny kod
                switch (iEsenceType)
                {
                    case ESENCE_MAGIC:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage=FloatToInt(iDamage*(1-(nCnt/(IntToFloat(nCnt)+1))));
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
                    AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget)));
                    break;

                    case ESENCE_SZIRAVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_STRASLIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 1 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectFrightened();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_OSLEPUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 1 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectBlindness();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_PEKELNA:
                    ExecuteScript("x0_s0_inferno",oTarget);
                    break;

                    case ESENCE_MRAZIVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage=FloatToInt(iDamage*(1-(nCnt/(IntToFloat(nCnt)+1))));
                    iDC = 10 + 3 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    eDur = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_COLD, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,TurnsToSeconds(10))));
                    }
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_COLD);
                    AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget)));
                    break;

                    case ESENCE_UHRANCIVA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 4 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectConfused();
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                        AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_ZADRZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 5 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectSlow();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_ZHOUBNA:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 6 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectParalyze();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_SPELL, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_LEPTAVA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage=FloatToInt(iDamage*(1-(nCnt/(IntToFloat(nCnt)+1))));
                    eEf = EffectDamage(iDamage, DAMAGE_TYPE_ACID);
                    AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eEf, oTarget)));
                    break;

                    case ESENCE_SVAZUJICI:
                    //UTOK DOTYKEM NA DALKU
                    iDC = 10 + 7 + GetAbilityModifier(ABILITY_CHARISMA)-2*nCnt;
                    iDur = 1;
                    eEf = EffectKnockdown();
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC+iDCShape, SAVING_THROW_TYPE_TRAP, OBJECT_SELF, GetRandomDelay(0.4, 1.2)))
                    {
                         AssignCommand(OBJECT_SELF,DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEf, oTarget,RoundsToSeconds(iDur))));
                    }
                    break;

                    case ESENCE_TEMNA:
                    iDamage = d6((iCasterLevel+1)/2);
                    iDamage=FloatToInt(iDamage*(1-(nCnt/(IntToFloat(nCnt)+1))))-2*nCnt;
                    iDC = 10 + 8 + GetAbilityModifier(ABILITY_CHARISMA);
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
                //konec switche
                }
            //
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            eLightning = EffectBeam(VFX_BEAM_BLACK, oHolder, BODY_NODE_CHEST);
            fDelay = fDelay + 0.1f;
        }
        nCnt++;
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
      }
 }
