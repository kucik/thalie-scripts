//::///////////////////////////////////////////////
//:: Wholeness of Body
//:: NW_S2_Wholeness
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The monk is able to heal twice his level in HP
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_MONK);
    int iWis = GetAbilityModifier(ABILITY_WISDOM);
    int nDuration = (nLevel+iWis);
    effect eRegen = EffectRegenerate(iWis,6.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    eRegen = ExtraordinaryEffect(eRegen);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_WHOLENESS_OF_BODY, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, TurnsToSeconds (nDuration));
}
