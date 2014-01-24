//::///////////////////////////////////////////////
//:: Kurtizana
//:://////////////////////////////////////////////
//::Odhalený živùtek
/*
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 1. úrovni
Popis: Klidnì si tak postává na ulici, když se znièeho nic objeví strážní a ženou se na ni. Obklíèí ji, ale ona se nesmí za nic na svìtì znovu dostat do vìzení. Je jen jediný zpùsob jak uniknout.
Poskytuje: Kurtizána mùže použít tuto odbornost nìkolikrát dennì (závisle na své úrovni). Proti všem humanoidùm získává navíc nìkolikanásobné zranìní k4. Proti zákonným humanoidùm mužského pohlaví je toto zranìní k6 + bonus z Charismatu jako bonus do útoku.
Trvání: Schopnost má trvání 10 tahù ale funguje jen proti nepøátelùm, kteøí byli v dobì aktivace maximálnì 10 metrù od kurtizány.
Použití: Výbìrem
Poznámka: Pøi použití odbornosti Pánové radìji plavovlásky za brunetku získá Kurtizána proti ženám se zákonným pøesvìdèením tytéž bonusy jako proti mužùm, když jim odhalí svùj živùtek.
*///::
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
#include "sh_classes_inc_e"
#include "cl_kurt_plav_inc"
void main()
{
    object oPC = OBJECT_SELF;
    object oSoul = GetSoulStone(oPC);
    int iCha = GetAbilityModifier(ABILITY_CHARISMA);
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    SetLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK",1);
    int iRacial,iGender;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    int iHairColorType =  GetLocalInt(oSoul,"KURTIZANA_BARVA_TYP");
    if (iCha>0)
    {
        effect eAB = EffectAttackIncrease(iCha);
        eAB = VersusAlignmentEffect(eAB,ALIGNMENT_LAWFUL);
        eAB = SupernaturalEffect(eAB);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAB,oPC,TurnsToSeconds(10));
    }
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oPC),TRUE);
    while (GetIsObjectValid(oTarget))
    {
        iGender = GetGender(oTarget);
        iRacial = GetRacialType(oTarget);
        if ((
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
        )&&
        (iGender == GENDER_MALE ||
        iGender == GENDER_BOTH ||
        iGender == GENDER_NONE ||
        iGender == GENDER_OTHER ||
        iHairColorType == PANOVE_RADEJI_PLAVOVLASKY_BRUNETY
        ))

        {
            SetLocalInt(oTarget,"KURTIZANA_ODHALENY_ZIVUTEK_TARGET",1);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oPC),TRUE);
    }
    DelayCommand(TurnsToSeconds(10),DeleteLocalInt(oPC,"KURTIZANA_ODHALENY_ZIVUTEK"));

}
