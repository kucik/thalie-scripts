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

    effect eNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    effect eLevel = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
    effect eAbil = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
    effect eDeath = EffectImmunity(IMMUNITY_TYPE_DEATH);
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eVisMovement = EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT);
    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, 30, 50);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE,  30, 50);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID,  30, 50);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC,  30, 50);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,  30, 50);
    effect eDurElem = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    eLink = EffectLinkEffects(eNeg, eDur);
    eLink = EffectLinkEffects(eLink, eLevel);
    eLink = EffectLinkEffects(eLink, eAbil);
    eLink = EffectLinkEffects(eLink, eDeath);
    eLink = EffectLinkEffects(eLink, eParal);
    eLink = EffectLinkEffects(eLink, eEntangle);
    eLink = EffectLinkEffects(eLink, eSlow);
    eLink = EffectLinkEffects(eLink, eMove);
    eLink = EffectLinkEffects(eLink, eVisMovement);
    eLink = EffectLinkEffects(eLink, eCold);
    eLink = EffectLinkEffects(eLink, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDurElem);
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
