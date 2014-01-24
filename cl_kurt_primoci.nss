/*
Pøimhouøete oèi
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 6. úrovni
Popis:
Poskytuje: Na 6. úrovni se dokáže Kurtizána zneviditelnit. Jakmile však bìhem trvání tohoto zneviditelnìní provede útoènou akci, efekt se pøedèasnì zruší.
Použití: 3 za den.
Trvání: Poèet kol rovnající se celkovému Charismatu postavy
Cíl: Pouze na sebe
*/
#include "sh_classes_inc_e"
void main()
{

    //effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eInvis, eDur);
    //eLink = EffectLinkEffects(eLink, eVis);
    int iCha = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
    int nDuration = GetLevelByClass(CLASS_TYPE_KURTIZANA);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(iCha));
}

