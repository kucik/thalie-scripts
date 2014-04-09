/*
Rozptylující dekolt
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 1. úrovni
Popis: Dívka ulice se nestydí využít svùj pùvab i v boji a nepøítele dokáže hlubokým dekoltem tak rozptýlit, že mnohdy ignoruje dìní kolem sebe.
Poskytuje: Pokud v širokém okolí bytosti neuspìjí v záchranném hodu na Vùli proti TO (celková hodnota Charismatu), tak se jim sníží dovednosti Všímavost a hledání a hody na Iniciativu. Pokud obìti odolají Kurtizáninì šarmu, získávají proti jejímu dekoltu na 24 hodin imunitu. Naopak, pokud neodolají, mùže je Kurtizána rozptýlit svým dekoltem opakovanì - v takovém pøípadì se zpùsobené postihy sèítají. Pokud nìjaká z obìtí má již všechny snižované hodnoty na nule a opìt neuspìje v hodu, tak je omámena na 1 kolo.
Použití: Výbìrem. Odbornost lze použít jednou za kolo.
Trvání: Pøi úspìchu trvají postihy zpùsobené nepøíteli po poèet kol rovnající se úrovni Kurtizány.
Cíl: Pouze humanoidní bytosti. Zvíøata a nemrtvá stvoøení jsou vùèi tìlesným pùvabùm Kurtizány lhostejná.
*/
#include "sh_classes_inc_e"
#include "x0_i0_spells"
#include "cl_kurt_plav_inc"
void main()
{

    int iCasterLevel = GetLevelByClass(CLASS_TYPE_KURTIZANA);
    int iCha = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA);
    //object oTarget = GetSpellTargetObject();
    object oSoul = GetSoulStone(OBJECT_SELF);
    //object oTargetSoul  = GetSoulStone(oTarget);
    int iSpot,iSearch,iGender,iRacial;
    effect eDaze = EffectDazed();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eSpotDec = EffectSkillDecrease(SKILL_SPOT,3);
    effect eSearchDec = EffectSkillDecrease(SKILL_SEARCH,3);
    int iHairColorType =  GetLocalInt(oSoul,"KURTIZANA_BARVA_TYP");
    int iDCBonus = (GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE)-10)*(iHairColorType == PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKY);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation(), TRUE);
    while(GetIsObjectValid(oTarget))
    {
        if (oTarget == OBJECT_SELF)
        {
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation(), TRUE);
            continue;
        } 
        iSpot = GetSkillRank(SKILL_SPOT,oTarget);
        iSearch = GetSkillRank(SKILL_SEARCH,oTarget);
        iGender = GetGender(oTarget);
        iRacial = GetRacialType(oTarget);
        if (iGender == GENDER_MALE && (
        iRacial == RACIAL_TYPE_DWARF ||
        iRacial == RACIAL_TYPE_ELF ||
        iRacial == RACIAL_TYPE_GNOME ||
        iRacial == RACIAL_TYPE_HALFELF ||
        iRacial == RACIAL_TYPE_HALFLING ||
        iRacial == RACIAL_TYPE_HALFORC ||
        iRacial == RACIAL_TYPE_HUMAN ||
        iRacial == RACIAL_TYPE_HUMANOID_GOBLINOID ||
        iRacial == RACIAL_TYPE_HUMANOID_MONSTROUS ||
        iRacial == RACIAL_TYPE_HUMANOID_ORC ||
        iRacial == RACIAL_TYPE_HUMANOID_REPTILIAN
        ))
        {
            //pokud neuspeje v hodu
            if (MySavingThrow(SAVING_THROW_WILL,oTarget,iCha+iDCBonus,SAVING_THROW_TYPE_ALL) == 0)
            {
                if (iSpot == 0 || iSearch == 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(iCasterLevel));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpotDec, oTarget, RoundsToSeconds(iCasterLevel));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSearchDec, oTarget, RoundsToSeconds(iCasterLevel));

                }

            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetSpellTargetLocation(), TRUE);
    }
}

