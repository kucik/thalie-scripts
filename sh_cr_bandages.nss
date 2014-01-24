#include "sh_classes_inc_e"
void sh_ModuleOnActivationItemCheckBandages(object oItem, object oTarget, object oActivator)
{
    string sTag = GetTag(oItem);
    effect eRegen;
    effect eHeal;
    int iRegenBand = 0;
    int iSkillHealMin = 0;
    int iPCSkillHeal = GetSkillRank(SKILL_HEAL,oActivator);

    if (sTag =="sh_it_band1")
    {
        iRegenBand = 1;

            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);

    }
    else if (sTag =="sh_it_band2")
    {
        iRegenBand = 2;
        iSkillHealMin = 2;
        if (iPCSkillHeal >= iSkillHealMin)
        {
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
        }
        else
        {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
        }
    }
    else if (sTag =="sh_it_band3")
    {
        iRegenBand = 4;
        iSkillHealMin = 7;
        if (iPCSkillHeal >= iSkillHealMin)
        {
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
        }
        else
        {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
        }
    }
    else if (sTag =="sh_it_band4")
    {
        iRegenBand = 7;
        iSkillHealMin = 10;
        if (iPCSkillHeal >= iSkillHealMin)
        {
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
        }
        else
        {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
        }
    }
    else if (sTag =="sh_it_band5")
    {
        iRegenBand = 12;
        iSkillHealMin = 15;
        if (iPCSkillHeal >= iSkillHealMin)
        {
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
        }
        else
        {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
        }
    }
    else if (sTag =="sh_it_band6")
    {
        iRegenBand = 20;
        iSkillHealMin = 22;
        if (iPCSkillHeal >= iSkillHealMin)
        {
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
        }
        else
        {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
        }
    }




}

