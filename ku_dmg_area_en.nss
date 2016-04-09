/*
 * Make damage to each person in area
 * 2016-04-09
 *
 * Settings:
 * Set following INT variables on object. If not set, default values will be used
 * KU_DMG_AREA_DICES - Number of dmg dices (Xd6).
 * KU_DMG_AREA_DICES_SIZE - Size of dices (d2, d3, d4, ... ).
 * KU_DMG_AREA_DAMAGE_TYPE - Dmg type. See DAMAGE_TYPE_* const
 * KU_DMG_AREA_DAMAGE_DELAY - Delay between each hit in seconds.
 *
 * Use ku_dmg_area_ex when using on triggers!
 *
 * Default values: 1d6 fire damage per 6 seconds.
 */


int iDiceDmg(int iDices, int iDiceSize) {
  switch(iDiceSize) {
    case 2: return d2(iDices);
    case 3: return d3(iDices);
    case 4: return d4(iDices);
    case 6: return d6(iDices);
    case 8: return d8(iDices);
    case 10: return d10(iDices);
    case 12: return d12(iDices);
    case 20: return d20(iDices);
    case 100: return d100(iDices);
  }
  return 0;
}

int iSwitchEffect(int iDmgType) {
  switch(iDmgType) {
    case DAMAGE_TYPE_ACID        : return VFX_COM_HIT_ACID;
//    case DAMAGE_TYPE_BASE_WEAPON : return
    case DAMAGE_TYPE_BLUDGEONING : return VFX_IMP_HARM;
    case DAMAGE_TYPE_COLD        : return VFX_IMP_HEAD_COLD;
    case DAMAGE_TYPE_DIVINE      : return VFX_COM_HIT_DIVINE;
    case DAMAGE_TYPE_ELECTRICAL  : return VFX_COM_HIT_ELECTRICAL;
    case DAMAGE_TYPE_FIRE        : return VFX_COM_HIT_FIRE;
    case DAMAGE_TYPE_MAGICAL     : return VFX_COM_HIT_DIVINE;
    case DAMAGE_TYPE_NEGATIVE    : return VFX_COM_HIT_NEGATIVE;
    case DAMAGE_TYPE_PIERCING    : return VFX_IMP_SPIKE_TRAP;
    case DAMAGE_TYPE_POSITIVE    : return VFX_COM_HIT_DIVINE;
    case DAMAGE_TYPE_SLASHING    : return VFX_IMP_SPIKE_TRAP;
    case DAMAGE_TYPE_SONIC       : return VFX_COM_HIT_SONIC;
  }
  return 0;
}

void __MakeDmgToPC(object oPC, int iDices, int iDiceSize, int iDmgType, float fDelay, object oCreator) {

  /* Script executed by trigger */
  if(GetObjectType(oCreator) == OBJECT_TYPE_TRIGGER) {
    /* Trigger left */
    if(GetLocalObject(oPC,"__KU_DMG_AREA") != oCreator)
      return;
  }
  /* So is it area? */
  else {
    if(GetArea(oPC) != oCreator)
      return;
  }
  if(!GetIsObjectValid(oCreator))
    return;

  effect eDmg = EffectDamage(iDiceDmg(iDices, iDiceSize), iDmgType, DAMAGE_POWER_NORMAL);
  effect eVis = EffectVisualEffect(iSwitchEffect(iDmgType));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
  DelayCommand(fDelay,__MakeDmgToPC(oPC, iDices, iDiceSize, iDmgType, fDelay, oCreator));
}

void main()
{
  object oPC = GetEnteringObject();
  /* Do not hurt NPCs */
  if(!GetIsPC(oPC))
    return;

  /* Store dmg creator */
  SetLocalObject(oPC,"__KU_DMG_AREA",OBJECT_SELF);

  int iDices = GetLocalInt(OBJECT_SELF,"KU_DMG_AREA_DICES");
  int iDiceSize = GetLocalInt(OBJECT_SELF,"KU_DMG_AREA_DICES_SIZE");
  int iDmgType = GetLocalInt(OBJECT_SELF,"KU_DMG_AREA_DAMAGE_TYPE");
  int iDelay = GetLocalInt(OBJECT_SELF,"KU_DMG_AREA_DAMAGE_DELAY");

  /* Defaults */
  if(iDices <= 0)
    iDices = 1;
  if(iDiceSize <= 0)
    iDiceSize = 6;
  if(iDmgType <= 0)
    iDmgType = DAMAGE_TYPE_FIRE;
  if(iDelay <= 0)
    iDelay = 6; // Round

  __MakeDmgToPC(oPC, iDices, iDiceSize, iDmgType, IntToFloat(iDelay), OBJECT_SELF);
}



