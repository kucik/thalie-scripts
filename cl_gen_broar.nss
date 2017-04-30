
#include "X0_I0_SPELLS"


void main()
{


// End of Spell Cast Hook

    object oPC = OBJECT_SELF;
    int iIntimadate = GetSkillRank(SKILL_INTIMIDATE,oPC);
    float fDuration = RoundsToSeconds(iIntimadate/5);
    int iDC = 10 + (GetHitDice(oPC)/2) + iIntimadate/5;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eFear = EffectFrightened();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fDelay;
    //Link the fear and mind effects
    effect eLink = EffectLinkEffects(eFear, eMind);
    eLink = EffectLinkEffects(eLink, eDur);

    //Apply Impact
    location lSelf= GetLocation(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lSelf);
    //Get first target in the spell cone
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf, TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            fDelay = GetRandomDelay();
            //Make a will save
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_FEAR, OBJECT_SELF, fDelay))
            {
               //Apply the linked effects and the VFX impact
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));

            }
        }
        //Get next target in the spell cone
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lSelf, TRUE);
    }
}

