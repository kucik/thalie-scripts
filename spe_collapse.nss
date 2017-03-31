
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
    int nSpellDC = GetEpicSpellSaveDC(OBJECT_SELF)+GetThalieSpellDCBonus(OBJECT_SELF);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);

    SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));
    effect eCrumb = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    if(!MySavingThrow(SAVING_THROW_FORT, oTarget,nSpellDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF))
    {
        int iCurrentHP = GetCurrentHitPoints(oTarget);
        int iDamage =  FloatToInt((IntToFloat(iCasterLevel)/100.0)*(iCurrentHP));
        effect eDam = EffectDamage(iDamage);
        effect eMissile = EffectVisualEffect(477);
        effect eCrumb = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        effect eVis = EffectVisualEffect(135);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eCrumb, oTarget);
        DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
        DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
   }

}


