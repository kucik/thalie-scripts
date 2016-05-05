//::///////////////////////////////////////////////
//:: Premonition
//:: NW_S0_Premo
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the gives the creature touched 30/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"
#include "sh_deity_inc"
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

    object oTarget = GetSpellTargetObject();

    //Declare major variables
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration,FALSE);
    int nLimit = nDuration * 10;
    int nMetaMagic = GetMetaMagicFeat();

    if(nLimit > 200) {
      nLimit = 200 + (nDuration - 20) * 5;
    }

    // Variable damage power
    int nDamagePower = DAMAGE_POWER_PLUS_FIVE;
    if(nDuration >= 20)
      nDamagePower = DAMAGE_POWER_PLUS_SIX;
    if(nDuration >= 25)
      nDamagePower = DAMAGE_POWER_PLUS_SEVEN;
    if(nDuration >= 30)
      nDamagePower = DAMAGE_POWER_PLUS_EIGHT;
    if(nDuration >= 35)
      nDamagePower = DAMAGE_POWER_PLUS_NINE;

    effect eStone = EffectDamageReduction(30, nDamagePower, nLimit);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    //Link the visual and the damage reduction effect
    effect eLink = EffectLinkEffects(eStone, eVis);
    //Enter Metamagic conditions
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PREMONITION, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    if (GetClericDomain(OBJECT_SELF,1) ==DOMENA_VEDENI || GetClericDomain(OBJECT_SELF,2)==DOMENA_VEDENI)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    RemoveEffectsFromSpell(oTarget, SPELL_PREMONITION);
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}
