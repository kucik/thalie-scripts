//::///////////////////////////////////////////////
//:: cl_cern_tvybuch
//:://////////////////////////////////////////////
/*
   Tajemny vybuch cernokneznika - paprsek.
*/
//:://////////////////////////////////////////////
//:: Created By: Shaman88
//:: Created On:

#include "X0_I0_SPELLS"
//#include "sh_classes_inc_e"
//#include "sh_effects_const"
#include "ku_essence_inc"
#include "x2_inc_spellhook"
//:://////////////////////////////////////////////

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

   //Declare major variables
    int iDCShape = 2;
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    int iDur,iTouchAttackResult;
    int iCasterLevel = GetLevelByClass(44,oCaster) ;   //CLASS_TYPE_CERNOKNEZNIK
    int iEsenceType = GetLocalInt(oCaster,ULOZENI_CERNOKNEZNIK_TYP_ESENCE);
    int iDamgeType = GetEssenceDmgType(DAMAGE_TYPE_MAGICAL, iEsenceType);
    struct EssenceEffect s_eff = GetEssenceAditionalEffect(iEsenceType);
    int iDC = 10 + GetEssenceDCMod(iEsenceType) + GetAbilityModifier(ABILITY_CHARISMA);
    int iDamage = d6((iCasterLevel+1)/2);

    /* Try touch attack */
    iTouchAttackResult = TouchAttackRanged(oTarget);
    if(iTouchAttackResult <= 0) {
      return;
    }
    /* Double damage for critical */
    iDamage = iDamage * iTouchAttackResult;
    if(iTouchAttackResult == 2)
      iDC = iDC + 2;

    /* Apply spell */

    /* Send event */
    if( (iDamgeType == DAMAGE_TYPE_NEGATIVE) &&
        (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) )
      SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), FALSE));
    else
      SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId(), TRUE));

    /* Prepare and apply #1 visual */
    effect eRay = EffectBeam(VFX_BEAM_BLACK , oCaster, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

    /* If spell is not resisted */
    if(!GetEssenceSpellResist(oCaster, oTarget, iEsenceType)) {
      /* If spell makes damage */
      if(iDamgeType != -1) {
          /* compose and apply dmg */
          effect eDmg = EffectDamage(iDamage, iDamgeType);
          if( (iDamgeType == DAMAGE_TYPE_NEGATIVE) &&
              (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) ) {
            eDmg =  EffectHeal(iDamage);
          }
          AssignCommand(oCaster,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
      }
        /* Additional spell effects */
        if(s_eff.iValid) {
          if(!MySavingThrow(s_eff.iSave, oTarget, iDC, s_eff.iSaveType, oCaster)) {
             int iDurType = DURATION_TYPE_TEMPORARY;
             if(s_eff.fduration <= 0.0)
               iDurType = DURATION_TYPE_INSTANT;
            AssignCommand(oCaster,ApplyEffectToObject(iDurType, s_eff.eff, oTarget,s_eff.fduration));
          }
        }
        /* Specific esssence funcions */
        EssenceProcessSpecs(oTarget, iEsenceType);
    }
}



