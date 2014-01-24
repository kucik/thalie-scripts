//::///////////////////////////////////////////////
//:: Magic Vestment
//:: X2_S0_MagcVest
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +1 AC bonus to armor touched per 3 caster
  levels (maximum of +5).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 09, 2003
//:: 2003-07-29: Rewritten, Georg Zoeller



#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "sh_classes_inc_e"





void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    int iCasterLevel  = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel);
    int iDuration  = iCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    int nAmount = iCasterLevel/5+1;
    if (nAmount <0)
    {
        nAmount =1;
    }
    else if (nAmount>5)
    {
        nAmount =5;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        iDuration = iDuration * 2; //Duration is +100%
    }
    effect eAC = EffectACIncrease(nAmount,AC_NATURAL_BONUS);
    effect ePoison = EffectSavingThrowIncrease(SAVING_THROW_ALL,nAmount,SAVING_THROW_TYPE_POISON);
    effect eHide = EffectSkillIncrease(SKILL_HIDE,nAmount);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAC,oTarget,TurnsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePoison,oTarget,TurnsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHide,oTarget,TurnsToSeconds(iDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,TurnsToSeconds(iDuration));



}
