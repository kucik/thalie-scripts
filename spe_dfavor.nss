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
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    float fDuration = HoursToSeconds(24);
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);

    effect eBonAttack = EffectAttackIncrease(3);
    effect eBonSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 3);
    effect eBonDam = EffectDamageIncrease(3, DAMAGE_TYPE_SLASHING);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, 3);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eBonAttack, eBonSave);
    eLink = EffectLinkEffects(eLink, eBonDam);
    eLink = EffectLinkEffects(eLink, ePosDur);
    eLink = EffectLinkEffects(eLink, eBonSkill);
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
