//::///////////////////////////////////////////////
//:: Dragon Breath Lightning
//:: NW_S1_DragLightn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calculates the proper damage and DC Save for the
    breath weapon based on the HD of the dragon.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 9, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

#include "sh_classes_inc_e"
void main()
{

    object oSoul = GetSoulStone(OBJECT_SELF);
    if (!GetLocalInt(oSoul,"RACIAL_ABILITY"))
    {
        return;
    }
    SetLocalInt(oSoul,"RACIAL_ABILITY",0);
    //Declare major variables
    int nAge = GetHitDice(OBJECT_SELF);
    int nDamage, nDC, nDamStrike;
    float fDelay;
    object oTarget;
    effect eVis, eBreath;
    nDamage = d6(nAge);
    nDC = 20 + nAge/2;
    effect eDamage;

    PlayDragonBattleCry();
    //Declare major variables
    //effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF,BODY_NODE_HAND);
    eVis  = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    int nCnt;
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget) && nCnt < nAge)
    {
        if(oTarget != OBJECT_SELF && !GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_CONE_LIGHTNING));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            nDamStrike = nDamage;
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY, OBJECT_SELF, fDelay))
            {
                nDamStrike = nDamStrike/2;
                if(GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    nDamStrike = 0;
                }
            }
            else if(GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
            {
                nDamStrike = nDamStrike/2;
            }
            if(nDamStrike > 0)
            {
                //Set the damage effect
                eDamage = EffectDamage(nDamStrike, DAMAGE_TYPE_ELECTRICAL);
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 14.0, GetSpellTargetLocation());
    }
}


