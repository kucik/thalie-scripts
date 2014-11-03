
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

void ApplyBossInstantKillDamage(object oTarget, int nCasterLevel) {
  if(!GetLocalInt(oTarget,"AI_BOSS"))
    return;

  // Well... this might make a problem if someone try to kill undead by some weird spell
  // but it should not happen. :)
  if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH) && (GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD))
    return;

  effect eDam1 = EffectDamage(nCasterLevel * 10, DAMAGE_TYPE_MAGICAL);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget);
}
