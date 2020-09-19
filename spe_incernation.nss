
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

void RunImpact(object oTarget, int iActImpact, int iMaxImpact);

void main()
{
    object oTarget = GetSpellTargetObject();
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);

    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one of that type, thats ok
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    if (iCasterLevel < 1)
    {
        iCasterLevel = 1;
    }
    if (GetHasFeat(FEAT_EPIC_DRUID))
    {
        iCasterLevel= iCasterLevel + 3;
    }

    effect eRay      = EffectBeam(444,OBJECT_SELF,BODY_NODE_CHEST);
    effect eDur      = EffectVisualEffect(498);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    float fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/13;
    //----------------------------------------------------------------------
    // Engulf the target in flame
    //----------------------------------------------------------------------
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 3.0f);
    //----------------------------------------------------------------------
    // Apply the VFX that is used to track the spells duration
    //----------------------------------------------------------------------
    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(iCasterLevel)));
    object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function
    DelayCommand(fDelay+0.1f,RunImpact(oTarget, 0,iCasterLevel));
}

void RunImpact(object oTarget, int iActImpact, int iMaxImpact)
{
    iActImpact =  iActImpact+1;
    if (iActImpact==iMaxImpact)
    {
        return;
    }
    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        int nDamage = d6(iActImpact);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunImpact(oTarget,iActImpact,iMaxImpact));
    }
}

