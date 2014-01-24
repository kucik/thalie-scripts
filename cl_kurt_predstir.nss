/*
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 17. úrovni
Popis: Je všeobecnì známo, že skuteènì dobrá Kurtizána to umí pøedstírat. A když je opravdu zkušená, tak to stojí za to...
Poskytuje: Kurtizána mùže použít speciální útok na blízko, je to hod proti TO rovnajícímu se obrannému èíslu cíle. Ovšem BAB je nahrazeno základním bonusem do Pøesvìdèování. Pokud uspìje, cíl je zranìn za ètyønásobek zranìní ze schopnosti Odhalený živùtek.
Použití: Jednou dennì
Cíl: Humanoidní bytost libovolného pohlaví
*/
#include "sh_classes_inc_e"
#include "x0_i0_spells"
#include "ku_libtimenss"
void main()
{
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_KURTIZANA);
    int iCha = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA);
    object oTarget = GetSpellTargetObject();

    //object oSoul = GetSoulStone(OBJECT_SELF);
    object oTargetSoul  = GetSoulStone(oTarget);
    int iCount = GetLocalInt(oTargetSoul,"KURTIZANA_KZEMI");
    int iRacial = GetRacialType(oTarget);
    int iLaw = GetAlignmentLawChaos(oTarget) == ALIGNMENT_LAWFUL;
    int iDamage = 0;
    if (iLaw)
    {
        iDamage = d4((iCasterLevel+1)/2+1);
    }
    else
    {
        iDamage = d6((iCasterLevel+1)/2+1);
    }
    iDamage *=4;
    effect eDamage = EffectDamage(iDamage,DAMAGE_TYPE_BLUDGEONING);
    int iAC = GetAC(oTarget);
    int iPersuade = GetSkillRank(SKILL_PERSUADE,oTarget);
    if (
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
    )
    {
            if (iPersuade >= iAC)
            {
                AssignCommand(OBJECT_SELF,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            }
    }

}
