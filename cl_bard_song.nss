//::///////////////////////////////////////////////
//:: cl_bard_song
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "sh_deity_inc"

void main()
{
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
        return;
    }
    string sTag = GetTag(OBJECT_SELF);

    if (sTag == "x0_hen_dee" || sTag == "x2_hen_deekin")
    {
        // * Deekin has a chance of singing a doom song
        // * same effect, better tune
        if (Random(100) + 1 > 80)
        {
            // the Xp2 Deekin knows more than one doom song
            if (d3() ==1 && sTag == "x2_hen_deekin")
            {
                DelayCommand(0.0, PlaySound("vs_nx2deekM_050"));
            }
            else
            {
                DelayCommand(0.0, PlaySound("vs_nx0deekM_074"));
                DelayCommand(5.0, PlaySound("vs_nx0deekM_074"));
            }
        }
    }

    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD) > 0)
    {
        ExecuteScript("cl_bard_cursesng",OBJECT_SELF);
        return;
    }


    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_BARD);
    int nRanks = GetSkillRank(SKILL_PERFORM);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    int nDuration = 10 ; //+ nChr;

    effect eAttack;
    effect eDamage;
    effect eWill;
    effect eFort;
    effect eReflex;
    effect eAC;
    effect eSkill;

    int nAttack = 0;
    int nDamage= 0;
    int nWill= 0;
    int nFort= 0;
    int nReflex= 0;
    int nAC= 0;
    int nSkill= 0;
    //Check to see if the caster has Lasting Impression and increase duration.
    if(GetHasFeat(870))
    {
        nDuration *= 10;
    }

    // lingering song
    if(GetHasFeat(424)) // lingering song
    {
        nDuration += 5;
    }

    //SpeakString("Level: " + IntToString(nLevel) + " Ranks: " + IntToString(nRanks));

    if(nPerform >= 100 && nLevel >= 30)
    {
        nAttack = 2;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nAC = 7;
        nSkill = 16;
    }
    else if(nPerform >= 90 && nLevel >= 29)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nAC = 6;
        nSkill = 13;
    }
    else if(nPerform >= 90 && nLevel >= 28)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nAC = 6;
        nSkill = 12;
    }
    else if(nPerform >= 90 && nLevel >= 27)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nAC = 6;
        nSkill = 11;
    }
    else if(nPerform >= 90 && nLevel >= 26)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nAC = 6;
        nSkill = 10;
    }
    else if(nPerform >= 82 && nLevel >= 25)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 2;
        nFort = 2;
        nReflex = 2;
        nAC = 5;
        nSkill = 8;
    }
    else if(nPerform >= 74 && nLevel >= 24)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 2;
        nFort = 1;
        nReflex = 1;
        nAC = 5;
        nSkill = 6;
    }
    else if(nPerform >= 66 && nLevel >= 23)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 2;
        nFort = 1;
        nReflex = 1;
        nAC = 4;
        nSkill = 4;
    }
    else if(nPerform >= 58 && nLevel >= 22)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 1;
        nAC = 4;
        nSkill = 2;
    }
    else if(nPerform >= 55 && nLevel >= 21)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 1;
        nAC = 3;
    }
    else if(nPerform >= 35 && nLevel >= 17)
    {
        nAttack = 2;
        nDamage = 3;
        nAC = 3;
    }
    else if(nPerform >= 21 && nLevel >= 14)
    {
        nAttack = 2;
        nDamage = 3;
        nAC = 2;
    }
    else if(nPerform >= 15 && nLevel >= 8)
    {
        nAttack = 2;
        nDamage = 2;
        nAC = 2;
    }
    else if(nPerform >= 12 && nLevel >= 6)
    {
        nAttack = 1;
        nDamage = 2;
        nAC = 2;
    }
    else if(nPerform >= 9 && nLevel >= 3)
    {
        nAttack = 1;
        nDamage = 2;
        nAC = 1;
    }
    else  if(nPerform >= 6 && nLevel >= 2)
    {
        nAttack = 1;
        nDamage = 1;
        nAC = 1;
    }
    else if(nPerform >= 3 && nLevel >= 1)
    {
        nAttack = 1;
        nDamage = 1;
    }
    effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

    eAttack = EffectAttackIncrease(nAttack);
    eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_BLUDGEONING);
    effect eLink = EffectLinkEffects(eAttack, eDamage);

    if(nWill > 0)
    {
        eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWill);
        eLink = EffectLinkEffects(eLink, eWill);
    }
    if(nFort > 0)
    {
        eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nFort);
        eLink = EffectLinkEffects(eLink, eFort);
    }
    if(nReflex > 0)
    {
        eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
        eLink = EffectLinkEffects(eLink, eReflex);
    }
    if(nAC > 0)
    {
        eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
        eLink = EffectLinkEffects(eLink, eAC);
    }
    if(nSkill > 0)
    {
        eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
        eLink = EffectLinkEffects(eLink, eSkill);
    }
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);

    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eFNF = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, GetLocation(OBJECT_SELF));

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    eLink = ExtraordinaryEffect(eLink);

    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
        {
             // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
             if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
             {
                if(oTarget == OBJECT_SELF)
                {
                    effect eLinkBard = EffectLinkEffects(eLink, eVis);
                    eLinkBard = ExtraordinaryEffect(eLinkBard);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));
                }
                else if(GetIsFriend(oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

