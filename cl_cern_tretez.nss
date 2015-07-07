//::///////////////////////////////////////////////
//:: Cernokneznikuv tajemny retez
//:: cl_cern_tretez
//:: Copyleft thalie.pilsfree.cz
//:://////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Created By: Shaman
//:: Refactored By Kucik 2014-02-14
//:://////////////////////////////////////////////


//#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
//#include "sh_classes_inc_e"
//#include "sh_effects_const"
#include "ku_essence_inc"
#include "ku_libtime"

object __chainNextJump(object oCaster, object oTarget, object oSource, int iSpell, float fMaxJump = 5.0, float fMaxRange = 30.0) {

    int i = 1;
    int iTime = ku_GetTimeStamp();
    string sMark = "HITBYCHAINSPELL"+IntToString(iSpell);

    /* Mark oTarget as hit */
    if(GetIsObjectValid(oTarget)) {
      SetLocalInt(oTarget,sMark,iTime);
      DelayCommand(1.0, DeleteLocalInt(oTarget,sMark));
    }

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
      /* If target was already hit in last 1 second */
      if(GetLocalInt(oNextTarget,sMark) + 1 >= iTime) {
        i++;
        oNextTarget = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, i);
        continue;
      }
      /* Do not hit caster */
      if(oCaster == oNextTarget) {
        i++;
        oNextTarget = GetNearestObject(OBJECT_TYPE_CREATURE, oTarget, i);
        continue;
      }
      /* Do not hit dead corpses */
      if(GetIsDead(oNextTarget)) {
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

   return oNextTarget;

}

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    object oTarget = GetSpellTargetObject();
    int iEsenceType = GetLocalInt(OBJECT_SELF,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
    int iCasterLevel = GetLevelByClass(44,OBJECT_SELF) ; //CLASS_TYPE_CERNOKNEZNIK
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
    int iDC = 10 + GetEssenceDCMod(iEsenceType) + GetAbilityModifier(ABILITY_CHARISMA);
    int iDCTouchMod = 0;


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

      /* Critical hit */
      iDCTouchMod = 0;
      if(iTouchAttackResult == 2)
        iDCTouchMod = 2;

      /* Apply spell */

      /* Send event */
      if( (iDamgeType == DAMAGE_TYPE_NEGATIVE) &&
          (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) )
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 869, FALSE));
      else
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 869, TRUE));

      /* Calculate ray jump distance and according dmg lose */
      if(i > 1) {
        fDistance = fDistance +  GetDistanceBetween(oSource, oTarget);
        fDelay = 0.01 * fDistance;
      }
      nDmg = iTouchAttackResult * FloatToInt(fDamage * ((100.0 - (fDistance * 2.0)) /100.0));

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
          if( (iDamgeType == DAMAGE_TYPE_NEGATIVE) &&
              (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) ) {
            eDmg =  EffectHeal(nDmg);;
          }
          DelayCommand(fDelay, AssignCommand(oCaster,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget)));
        }

        /* Additional spell effects */
        if(s_eff.iValid) {
          if(!MySavingThrow(s_eff.iSave, oTarget, iDC + iDCTouchMod, s_eff.iSaveType, oCaster, fDelay)) {
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

