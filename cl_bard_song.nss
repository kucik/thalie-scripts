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
    if (GetThalieClericDeity(OBJECT_SELF)==DEITY_MORUS)
    {
        nLevel += GetLevelByClass(CLASS_TYPE_CLERIC,OBJECT_SELF) ;
    }


    int nRanks = GetSkillRank(SKILL_PERFORM);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nPerform = nRanks;
    int nDuration = 10 ; //+ nChr;

    effect eAttack;
    effect eDamage;
    effect eWill;
    effect eFort;
    effect eReflex;
    effect eHP;
    effect eAC;
    effect eSkill;

    int nAttack;
    int nDamage;
    int nWill;
    int nFort;
    int nReflex;
    int nHP;
    int nAC;
    int nSkill;
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

    if(nPerform >= 100 && nLevel >= 40)
    {
        nAttack = 4;
        nDamage = 5;
        nWill = 5;
        nFort = 4;
        nReflex = 4;
        nHP = 70;
        nAC = 10;
        nSkill = 25;
    }
    else if(nPerform >= 98 && nLevel >= 39)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 4;
        nFort = 3;
        nReflex = 4;
        nHP = 66;
        nAC = 9;
        nSkill = 23;
    }
    else if(nPerform >= 96 && nLevel >= 38)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 4;
        nFort = 3;
        nReflex = 4;
        nHP = 64;
        nAC = 9;
        nSkill = 23;
    }
    else if(nPerform >= 94 && nLevel >= 37)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 4;
        nFort = 3;
        nReflex = 4;
        nHP = 62;
        nAC = 8;
        nSkill = 22;
    }
    else if(nPerform >= 92 && nLevel >= 36)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 4;
        nFort = 3;
        nReflex = 3;
        nHP = 60;
        nAC = 8;
        nSkill = 22;
    }
    else if(nPerform >= 90 && nLevel >= 35)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 3;
        nFort = 3;
        nReflex = 3;
        nHP = 58;
        nAC = 7;
        nSkill = 21;
    }
    else if(nPerform >= 88 && nLevel >= 34)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 3;
        nHP = 56;
        nAC = 7;
        nSkill = 21;
    }
    else if(nPerform >= 86 && nLevel >= 33)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 3;
        nHP = 54;
        nAC = 7;
        nSkill = 20;
    }
    else if(nPerform >= 84 && nLevel >= 32)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 3;
        nHP = 52;
        nAC = 7;
        nSkill = 20;
    }
    else if(nPerform >= 82 && nLevel >= 31)
    {
        nAttack = 3;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 3;
        nHP = 50;
        nAC = 7;
        nSkill = 19;
    }
    else if(nPerform >= 80 && nLevel >= 30)
    {
        nAttack = 2;
        nDamage = 4;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 48;
        nAC = 7;
        nSkill = 19;
    }
    else if(nPerform >= 77 && nLevel >= 29)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 46;
        nAC = 6;
        nSkill = 18;
    }
    else if(nPerform >= 74 && nLevel >= 28)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 44;
        nAC = 6;
        nSkill = 17;
    }
    else if(nPerform >= 71 && nLevel >= 27)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 42;
        nAC = 6;
        nSkill = 16;
    }
    else if(nPerform >= 68 && nLevel >= 26)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 40;
        nAC = 6;
        nSkill = 15;
    }
    else if(nPerform >= 65 && nLevel >= 25)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 38;
        nAC = 6;
        nSkill = 14;
    }
    else if(nPerform >= 62 && nLevel >= 24)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 36;
        nAC = 5;
        nSkill = 13;
    }
    else if(nPerform >= 59 && nLevel >= 23)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 34;
        nAC = 5;
        nSkill = 12;
    }
    else if(nPerform >= 56 && nLevel >= 22)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 32;
        nAC = 5;
        nSkill = 11;
    }
    else if(nPerform >= 53 && nLevel >= 21)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 30;
        nAC = 5;
        nSkill = 9;
    }
    else if(nPerform >= 50 && nLevel >= 20)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 28;
        nAC = 4;
        nSkill = 8;
    }
    else if(nPerform >= 45 && nLevel >= 19)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 26;
        nAC = 4;
        nSkill = 7;
    }
    else if(nPerform >= 40 && nLevel >= 18)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 24;
        nAC = 4;
        nSkill = 6;
    }
    else if(nPerform >= 35 && nLevel >= 17)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 22;
        nAC = 4;
        nSkill = 5;
    }
    else if(nPerform >= 30 && nLevel >= 16)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 3;
        nFort = 2;
        nReflex = 2;
        nHP = 20;
        nAC = 3;
        nSkill = 4;
    }
    else if(nPerform >= 24 && nLevel >= 15)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 2;
        nFort = 2;
        nReflex = 2;
        nHP = 16;
        nAC = 3;
        nSkill = 3;
    }
    else if(nPerform >= 21 && nLevel >= 14)
    {
        nAttack = 2;
        nDamage = 3;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 16;
        nAC = 3;
        nSkill = 2;
    }
    else if(nPerform >= 18 && nLevel >= 11)
    {
        nAttack = 2;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 8;
        nAC = 2;
        nSkill = 2;
    }
    else if(nPerform >= 15 && nLevel >= 8)
    {
        nAttack = 2;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 8;
        nAC = 2;
        nSkill = 1;
    }
    else if(nPerform >= 12 && nLevel >= 6)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 1;
        nHP = 0;
        nAC = 2;
        nSkill = 1;
    }
    else if(nPerform >= 9 && nLevel >= 3)
    {
        nAttack = 1;
        nDamage = 2;
        nWill = 1;
        nFort = 1;
        nReflex = 0;
        nHP = 0;
        nAC = 1;
        nSkill = 0;
    }
    else if(nPerform >= 6 && nLevel >= 2)
    {
        nAttack = 1;
        nDamage = 1;
        nWill = 1;
        nFort = 0;
        nReflex = 0;
        nHP = 0;
        nAC = 1;
        nSkill = 0;
    }
    else if(nPerform >= 3 && nLevel >= 1)
    {
        nAttack = 1;
        nDamage = 1;
        nWill = 0;
        nFort = 0;
        nReflex = 0;
        nHP = 0;
        nAC = 0;
        nSkill = 0;
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
    if(nHP > 0)
    {
        //SpeakString("HP Bonus " + IntToString(nHP));
        eHP = EffectTemporaryHitpoints(nHP);
//        eLink = EffectLinkEffects(eLink, eHP);
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

    eHP = ExtraordinaryEffect(eHP);
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
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
                else if(GetIsFriend(oTarget))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    if (nHP > 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

