#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    effect eHowl = EffectStunned();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    int nSpellDC = GetEpicSpellSaveDC(OBJECT_SELF)+GetThalieSpellDCBonus(OBJECT_SELF);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,iCasterLevel,FALSE);
    effect eLink = EffectLinkEffects(eHowl, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    float fDelay;
    int nDuration = iCasterLevel;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);

    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && !GetIsFriend(oTarget) && oTarget != OBJECT_SELF)
        {
            nDuration = GetScaledDuration(nDuration , oTarget);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_CONFUSE));
            fDelay = GetDistanceToObject(oTarget)/10;
            //Make a saving throw check
            if((!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, nSpellDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay)) || (GetRacialType(oTarget)==RACIAL_TYPE_ANIMAL))
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


