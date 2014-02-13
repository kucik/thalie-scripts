//::///////////////////////////////////////////////
//:: Cernokneznikuv tajemny retez
//:: cl_cern_tretez
//:: Copyleft thalie.pilsfree.cz
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Created By: Shaman
//:: Refactored By Kucik 2014-02-14
//:://////////////////////////////////////////////


struct EssenceEffect {
  effect eff;
  float  fduration;
  int iSave;
  int iSaveType;
  int iValid;
};

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "sh_effects_const"
#include "ku_libtime"

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

struct EssenceEffect GetEssenceAditionalEffect(int iEssence) {
  struct EssenceEffect s_eff;
  s_eff.iValid = TRUE;

  switch(iEssence) {
//    case ESENCE_MAGIC:
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
      s_eff.iSave = SAVING_THROW_WILL;
      s_eff.iSaveType = SAVING_THROW_TYPE_SPELL;
      return s_eff;

//    case ESENCE_LEPTAVA:
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

object __chainNextJump(object oCaster, object oTarget, object oSource, int iSpell, float fMaxJump = 5.0, float fMaxRange = 30.0) {

    int i = 1;
    int iTime = ku_GetTimeStamp();
    string sMark = "HITBYCHAINSPELL"+IntToString(iSpell);
    object oNextTarget = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, i);
    while(GetIsObjectValid(oNextTarget)) {
      /* Limited jump size */
      if(GetDistanceBetween(oTarget, oNextTarget) > fMaxJump) {
        oNextTarget = OBJECT_INVALID;
        break;
      }
      /* Limited distance from caster */
      if(GetDistanceBetween(oTarget, oCaster) > fMaxRange) {
        oNextTarget = OBJECT_INVALID;
        break;
      }
      /* If target was already hit in last 1 second*/
      if(GetLocalInt(oNextTarget,sMark) + 1 >= iTime) {
        i++;
        oNextTarget = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, i);
        continue;
      }
      /* Do not jump back */
      if(oSource == oNextTarget) {
        i++;
        oNextTarget = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, i);
        continue;
      }
      else {
        break;
      }
    }

   if(GetIsObjectValid(oNextTarget)) {
     SetLocalInt(oNextTarget,sMark,iTime);
     DelayCommand(1.0, DeleteLocalInt(oNextTarget,sMark));
   }

   return oNextTarget;

}

void main()
{

    object oTarget = GetSpellTargetObject();
    int iEsenceType = GetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
    int iCasterLevel = GetLevelByClass(CLASS_TYPE_CERNOKNEZNIK,OBJECT_SELF) ;
    int iMaxTargets = ((iCasterLevel + 1) / 5);
    int iDamgeType = GetEssenceDmgType(DAMAGE_TYPE_MAGICAL, iEsenceType);
    struct EssenceEffect s_eff = GetEssenceAditionalEffect(iEsenceType);
    object oCaster = OBJECT_SELF;
    float fMaxJump = 5.0;
    float fMaxRange = 30.0;
    int iTouchAttackResult;
    effect eRay;

    object oSource = oCaster;
    object oNewTarget = OBJECT_INVALID;
    int i=1;
    float fDistance = 0.0;
    float fDamage = IntToFloat(d6((iCasterLevel+1)/2));
    int nDmg;
    float fDelay = 0.0;
    int iDC = 10 + 2 + GetAbilityModifier(ABILITY_CHARISMA);


    while(GetIsObjectValid(oTarget)) {
      /* Limit number of targets */
      if(i > iMaxTargets) {
        break;
      }
      /* Try touch attack */
      iTouchAttackResult = TouchAttackRanged(oTarget);
      if(iTouchAttackResult <= 0) {
        break;
      }

      /* Apply spell */

      /* Send event */
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 869, TRUE));

      /* Calculate ray jump distance and according dmg lose */
      if(i > 0) {
        fDistance = fDistance +  GetDistanceBetween(oSource, oTarget);
        fDelay = 0.01 * fDistance;
      }
      nDmg = FloatToInt(fDamage * ((100.0 - (fDistance * 2.0)) /100.0));

      /* Prepare and apply #1 visual */
      if(i == 1)
        eRay = EffectBeam(VFX_BEAM_CHAIN , oSource, BODY_NODE_HAND);
      else
        eRay = EffectBeam(VFX_BEAM_CHAIN , oSource, BODY_NODE_CHEST);
      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7));

      /* If spell is resisted, it continues to another target */
      if(!GetEssenceSpellResist(oCaster, oTarget, iEsenceType)) {
        /* If spell makes damage */
        if(iDamgeType != -1) {

          /* compose and apply dmg */
          effect eDmg = EffectDamage(nDmg, iDamgeType);
          DelayCommand(fDelay, AssignCommand(oCaster,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget)));
        }

        /* Additional spell effects */
        if(s_eff.iValid) {
          if(!MySavingThrow(s_eff.iSave, oTarget, iDC, s_eff.iSaveType, oCaster, fDelay)) {
             int iDurType = DURATION_TYPE_TEMPORARY;
             if(s_eff.fduration <= 0.0)
               iDurType = DURATION_TYPE_INSTANT;
            DelayCommand(fDelay,AssignCommand(oCaster,ApplyEffectToObject(iDurType, s_eff.eff, oTarget,s_eff.fduration)));
          }
        }
        /* Specific esssence funcions */
        DelayCommand(fDelay,EssenceProcessSpecs(oTarget, iEsenceType));
      }

      oNewTarget = __chainNextJump(oCaster, oTarget, oSource, 869, fMaxJump, fMaxRange);
      oSource = oTarget;
      oTarget = oNewTarget;
      i++;
    }
 }

