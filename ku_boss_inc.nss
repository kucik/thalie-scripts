int GetCR(object oBoss) {
    return GetLocalInt(GetArea(oBoss),"TREASURE_VALUE");
}


int GetIsBoss(object oTarget) {
  if(GetLocalInt(oTarget, "AI_BOSS"))
    return TRUE;

  return FALSE;
}

float ReduceSpellDurationForBoss(object oTarget, float fDuration, int CasterLvl) {
  if(GetLocalInt(oTarget,"AI_BOSS"))
    fDuration = fDuration / 4.0;

  return fDuration;
}

int ReduceShortSpellDurationForBoss_int(object oTarget, int nDuration, int CasterLvl) {
  if(GetLocalInt(oTarget,"AI_BOSS"))
    nDuration = 1;

  return nDuration;
}

void ApplyBossInstantKillDamage(object oTarget, int nCasterLevel,int iIsDeathMagic) {
  if(!GetLocalInt(oTarget,"AI_BOSS"))
    return;

  // Well... this might make a problem if someone try to kill undead by some weird spell
  // but it should not happen. :)
  //if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH) ||((iIsDeathMagic==TRUE) && ((GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD) || (GetRacialType(oTarget)==RACIAL_TYPE_CONSTRUCT))) )
  //  return;

  int iDamage;
  effect eDam;
  int iCR = GetCR(oTarget);
  int iDiff = nCasterLevel - iCR;
  if (iDiff >=10)
  {
    if (iIsDeathMagic)
    {
        eDam = EffectDeath();
    }
    else
    {
        eDam = EffectDeath(TRUE);
        eDam = SupernaturalEffect(eDam);
    }
  }
  else if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH) && (iIsDeathMagic==TRUE))
  {
    return;
  }
  else if (iDiff >=5)
  {
    iDamage =FloatToInt(IntToFloat(GetMaxHitPoints(oTarget))*0.4);
    eDam = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
  }
  else
  {
    iDamage =FloatToInt(IntToFloat(GetMaxHitPoints(oTarget))*0.2);
    eDam = EffectDamage(iDamage, DAMAGE_TYPE_MAGICAL);
  }
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
}
