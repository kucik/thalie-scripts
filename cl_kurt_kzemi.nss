/*
K zemi
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 5. úrovni
Popis: Pøiznejme si to, pokud si má èlovìk vybrat, zda-li ho srazí k zemi neurvalý ork nebo vnadná dìva, volba je jasná.
Poskytuje: Kdykoli se pokusí Kurtizána použít srážení proti humanoidovi mužského pohlaví, obì si háže na Vùli proti TO (10 + úroveò Kurtizány) jinak klesá k zemi.
Použití: Kurtizána mùže použít tuto odbornost libovolnì krát za den, ale vždy aspoò s odstupem 5 tahù. Pokud použije schopnost opakovanì na stejný cíl, tak je TO pøi každém dalším takovém pokusu o 3 menší. Tato stupnice je zapomenuta spánkem èi meditací cíle.
Trvání: 1 kolo
Cíl: Humanoidní bytost mužského pohlaví
*/
#include "sh_classes_inc_e"
#include "x0_i0_spells"
#include "ku_libtimenss"


void main()
{
    int iTime = ku_GetTimeStamp();
    int iPrev = GetLocalInt(OBJECT_SELF,"KURTIZANA_KZEMI_TIME");
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_KURTIZANA);
    int iCha = GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA);
    object oTarget = GetSpellTargetObject();

    //object oSoul = GetSoulStone(OBJECT_SELF);
    object oTargetSoul  = GetSoulStone(oTarget);
    int iCount = GetLocalInt(oTargetSoul,"KURTIZANA_KZEMI");
    int iGender = GetGender(oTarget);
    int iRacial = GetRacialType(oTarget);
    effect eKnockdown = EffectKnockdown();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eKnockdown, eDur);
    SendMessageToPC(OBJECT_SELF,"Pohlavi cile ="+IntToString(iGender)+". Rasa cile="+IntToString(iRacial)+". Time="+IntToString(iTime)+". PrevTime cile="+IntToString(iPrev)+". Count="+IntToString(iCount));
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
    iGender == GENDER_MALE)
    {

        if ((iTime-iPrev)>= 300 || iPrev == 0) //delsi cas nez 30 minut
        {

            AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
            if (MySavingThrow(SAVING_THROW_WILL,oTarget,(10+iCasterLevel)-(iCount*3),SAVING_THROW_TYPE_ALL) == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
            }
            SetLocalInt(OBJECT_SELF,"KURTIZANA_KZEMI_TIME",iTime);
            SetLocalInt(oTargetSoul,"KURTIZANA_KZEMI",iCount+1);
        }
        else
        {
            SendMessageToPC(OBJECT_SELF,"Shopnost budete moci pouzit za " + IntToString((300-iTime+iPrev)/60) + " minut a "+ IntToString((300-iTime+iPrev)%60) + " sekund.");
        }



    }

}

