#include "x2_inc_spellhook"
#include "nw_i0_spells"
#include "nwnx_structs"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    // End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    float fDuration = HoursToSeconds(24);
    float fDelay;

    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 4);
    effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 4);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
    effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, 4);
    eLink = EffectLinkEffects(eStr, eDur);
    eLink = EffectLinkEffects(eLink, eDex);
    eLink = EffectLinkEffects(eLink, eCha);
    eLink = EffectLinkEffects(eLink, eInt);
    eLink = EffectLinkEffects(eLink, eCon);
    eLink = EffectLinkEffects(eLink, eWis);
    eLink = ExtraordinaryEffect(eLink);
    //Get first target in spell area
    location lLoc = GetLocation(OBJECT_SELF);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc, FALSE);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsFriend(oTarget) && OBJECT_SELF != oTarget)
        {
            // SendMessageToPC( OBJECT_SELF, ("target =" + IntToString(nTargets)+ "")); // debug msg
            fDelay = GetRandomDelay();
            DelayCommand(fDelay,SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget)); // apply visual effect of the casted spell
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration)); // apply spell effects
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc, FALSE);
    }
    DelayCommand(0.1,SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), FALSE)));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration));
}
