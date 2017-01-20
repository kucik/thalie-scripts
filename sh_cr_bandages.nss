#include "sh_classes_inc_e"
#include "ku_libtime"

void __reportEndOfHealing(object oTarget, object oCaster) {
  SendMessageToPC(oTarget,"Ucinek obvazu prave skoncil");
  if(oTarget != oCaster)
    SendMessageToPC(oCaster, "Ucinek obvazu na "+GetName(oTarget)+" prave skoncil.");
}

int GetHealModificator(object oTarget)
{
    return GetCurrentHitPoints(oTarget) <= 0 ? (GetCurrentHitPoints(oTarget) * -1) + 1 : 0;
}

void sh_ModuleOnActivationItemCheckBandages(object oItem, object oTarget, object oActivator)
{
    string sTag = GetTag(oItem);
    effect eRegen;
    effect eHeal;
    int iRegenBand = 0;
    int iSkillHealMin = 0;
    int iPCSkillHeal = GetSkillRank(SKILL_HEAL,oActivator);
    int iHealMod = 0;

    /* Is it bandage? */
    if(GetStringLeft(sTag, 10) != "sh_it_band")
      return;

    /* Check already healing */
    int iStamp = ku_GetTimeStamp();
    if(GetLocalInt(oTarget, "KU_BANDAGE_TS") > ku_GetTimeStamp()) {
      SendMessageToPC(oTarget,"Nemuzes pouzivat vice lekaren zaroven.");
      if(oTarget != oActivator)
        SendMessageToPC(oActivator, GetName(oTarget)+" je jiz lecen.");
      return;
    }

    /* Choose bandage */
    int iBandage = StringToInt(GetStringRight(sTag , 1));
    switch(iBandage) {
      case 1:
        iRegenBand = 1;
        break;
      case 2:
        iRegenBand = 2;
        iSkillHealMin = 2;
        break;
      case 3:
        iRegenBand = 4;
        iSkillHealMin = 7;
        break;
      case 4:
        iRegenBand = 7;
        iSkillHealMin = 10;
        break;
      case 5:
        iRegenBand = 12;
        iSkillHealMin = 14;
        break;
      case 6:
        iRegenBand = 20;
        iSkillHealMin = 22;
        break;
      default:
        return;
    }

    if (iPCSkillHeal >= iSkillHealMin) {
            iHealMod = GetHealModificator(oTarget);
            eRegen = EffectRegenerate(iRegenBand,RoundsToSeconds(1));
            eRegen = SupernaturalEffect(eRegen);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRegen,oTarget,RoundsToSeconds(10));
            DelayCommand(RoundsToSeconds(10), __reportEndOfHealing(oTarget, oActivator));
            eHeal = EffectHeal(iPCSkillHeal-iSkillHealMin+iHealMod);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget);
            SetLocalInt(oTarget, "KU_BANDAGE_TS",ku_GetTimeStamp(FloatToInt(RoundsToSeconds(10))));
    }
    else {
            SendMessageToPC(oActivator,"Nejsi v léèení dostateènì zdatný");
    }

}

