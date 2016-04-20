///////////////////////////////////////////////
// ku_essence_inc
// Cernokneznik - essence library
//
///////////////////////////////////////////////

#include "sh_effects_const" // Essence constants
#include "nw_i0_spells"  // For MyResistSpell

struct EssenceEffect {
  effect eff;
  float  fduration;
  int iSave;
  int iSaveType;
  int iValid;
};

///////////////////////////////////////////////
// Get damage type of an essence
int GetEssenceDmgType(int iDmgType, int iEssence);


///////////////////////////////////////////////
// Get struct containning the essence effect info
struct EssenceEffect GetEssenceAditionalEffect(int iEssence);

// Get spell resist for an essence
int GetEssenceSpellResist(object oCaster, object oTarget, int iEssence);

// Do essence specific actions
void EssenceProcessSpecs(object oTarget, int iEsence);

// Get save DC modoficator for essence
int GetEssenceDCMod(int iEssence);

int GetEssenceDmgType(int iDmgType, int iEssence) {

  switch(iEssence) {
    case ESENCE_MAGIC:       return DAMAGE_TYPE_MAGICAL; //Chybi popis
    case ESENCE_SZIRAVA:     return -1; // no damage
    case ESENCE_STRASLIVA:   return -1; //no damage
    case ESENCE_OSLEPUJICI:  return -1; //no damage
    case ESENCE_PEKELNA:     return -1; // no damage
    case ESENCE_MRAZIVA:     return DAMAGE_TYPE_COLD;
//    case ESENCE_UHRANCIVA:
//    case ESENCE_ZADRZUJICI:
//    case ESENCE_ZHOUBNA:
    case ESENCE_LEPTAVA:     return DAMAGE_TYPE_ACID;
    case ESENCE_SVAZUJICI:   return -1; // no damage
    case ESENCE_TEMNA:       return DAMAGE_TYPE_NEGATIVE;
  }

  return iDmgType;
}

int GetEssenceDCMod(int iEssence) {
    switch(iEssence) {
    case ESENCE_MAGIC:
    case ESENCE_SZIRAVA:
    case ESENCE_STRASLIVA:   return 2;
    case ESENCE_OSLEPUJICI:
//    case ESENCE_PEKELNA:     return -1; // no damage
    case ESENCE_MRAZIVA:
    case ESENCE_UHRANCIVA:
    case ESENCE_ZADRZUJICI:  return 4;
    case ESENCE_ZHOUBNA:
    case ESENCE_LEPTAVA:     return 6;
    case ESENCE_SVAZUJICI:   return 7; // no damage
    case ESENCE_TEMNA:       return 8;
  }
  return 0;
}

struct EssenceEffect GetEssenceAditionalEffect(int iEssence) {
  struct EssenceEffect s_eff;
  s_eff.iValid = TRUE;

  switch(iEssence) {
    case ESENCE_MAGIC: //dmg only
      s_eff.iValid = FALSE;
      s_eff.iSave = SAVING_THROW_TYPE_SPELL;
      return s_eff;
    case ESENCE_SZIRAVA:
      s_eff.eff = EffectSlow();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_WILL; // ??
      s_eff.iSaveType = SAVING_THROW_TYPE_SPELL;
      return s_eff;

    case ESENCE_STRASLIVA:
      s_eff.eff = EffectFrightened();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_WILL;
      s_eff.iSaveType = SAVING_THROW_TYPE_FEAR;
      return s_eff;

    case ESENCE_OSLEPUJICI:
      s_eff.eff = EffectBlindness();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_WILL;
      s_eff.iSaveType = SAVING_THROW_TYPE_SPELL;
      return s_eff;

//    case ESENCE_PEKELNA:
    case ESENCE_MRAZIVA:
      s_eff.eff = EffectAbilityDecrease(ABILITY_DEXTERITY,4);
      s_eff.fduration = TurnsToSeconds(10);
      s_eff.iSave = SAVING_THROW_FORT;
      s_eff.iSaveType = SAVING_THROW_TYPE_COLD;
      return s_eff;

    case ESENCE_UHRANCIVA:
      s_eff.eff = EffectConfused();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_FORT;
      s_eff.iSaveType = SAVING_THROW_TYPE_SPELL;
      return s_eff;

    case ESENCE_ZADRZUJICI:
      s_eff.eff = EffectSlow();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_WILL;
      s_eff.iSaveType = SAVING_THROW_TYPE_TRAP;
      return s_eff;

    case ESENCE_ZHOUBNA:
      s_eff.eff = EffectParalyze(); //Stun or paralyze ???
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_FORT;
      s_eff.iSaveType = SAVING_THROW_TYPE_SPELL;
      return s_eff;

    case ESENCE_LEPTAVA:  // dmg only
      s_eff.iValid = FALSE;
      s_eff.iSave = SAVING_THROW_TYPE_ACID;
      return s_eff;
    case ESENCE_SVAZUJICI:
      s_eff.eff = EffectKnockdown();
      s_eff.fduration = RoundsToSeconds(1);
      s_eff.iSave = SAVING_THROW_WILL;
      s_eff.iSaveType = SAVING_THROW_TYPE_TRAP;
      return s_eff;
    case ESENCE_TEMNA:
      s_eff.eff = EffectNegativeLevel(6);
      s_eff.fduration = 0.0;
      s_eff.iSave = SAVING_THROW_FORT;
      s_eff.iSaveType = SAVING_THROW_TYPE_EVIL;
      return s_eff;
  }

  s_eff.iValid = FALSE;;
  return s_eff;
}

int GetEssenceSpellResist(object oCaster, object oTarget, int iEssence) {
  if(ESENCE_LEPTAVA)
    return FALSE;

  return MyResistSpell(oCaster, oTarget);
}

void EssenceProcessSpecs(object oTarget, int iEsence) {
  if(iEsence == ESENCE_PEKELNA)
    ExecuteScript("x0_s0_inferno",oTarget);

  return;
}


