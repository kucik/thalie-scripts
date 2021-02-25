//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "sh_classes_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
    effect eKill, eHeal;
    int nDamage, nHeal, nModify, nMetaMagic, nTouch;
    effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);
    nMetaMagic = GetMetaMagicFeat();
    int iValue = 10*(iCasterLevel);
    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
       iValue =  iValue+ (iValue/2);
    }
    //Check to see if the target is an undead
    if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
            //Make a touch attack
            if (TouchAttackMelee(oTarget))
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget))
                {
                    if (MySavingThrow(SAVING_THROW_WILL,oTarget,GetSpellSaveDC()+GetThalieSpellDCBonus(OBJECT_SELF), SAVING_THROW_TYPE_POSITIVE, OBJECT_SELF, 1.0))
                    {
                        nDamage = iValue;
                    }
                    else
                    {
                        nDamage = iValue /2;
                    }


                    //Set damage
                    eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
                }
            }
        }
    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        //Set the heal effect
        if (GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
        {
            iValue = GetMaxHitPoints(oTarget);
        }
        if (GetHasFeat(FEAT_TOUGH_AS_BONE,oTarget))
        {
            iValue = ModifyHealForPalemaster(oTarget,iValue);
        }
        eHeal = EffectHeal(iValue);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
