
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "X2_i0_spells"

void DoCrumble (int nDam, object oCaster, object oTarget);

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    // End of Spell Cast Hook

    object oCaster  = OBJECT_SELF;

    object oTarget = GetSpellTargetObject();

    SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
    int iCurrentHP = GetCurrentHitPoints(oTarget);
    int iDamage =  iCurrentHP / 2;
    effect eDam = EffectDamage(iDamage);
    effect eMissile = EffectVisualEffect(477);
    effect eCrumb = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eVis = EffectVisualEffect(135);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eCrumb, oTarget);
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));


}


