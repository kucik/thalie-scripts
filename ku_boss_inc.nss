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


