//::///////////////////////////////////////////////
//:: Flame Weapon
//:: sp_flmeweap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d6 damage +1 per caster
  level/4 to a maximum of +10 for caster lvl rounds.
  Dmg type follows subradial menu:
  fire, acid, cold, electricity
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 29, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-15: Complete Rewrite to make use of Item Property System
//:: 2014_04_17: added acid, cold and electricity dmg & support of subradial spells




#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "nw_i0_spells"
#include "x2_i0_spells"
#include "sh_effects_const"

// Test if the object oMyWeapon has been enchantment with temporaly ITEM_PROPERTY_DAMAGE_BONUS,
// if so, the function removes the enchantment.
void TestAndRemoveTemporalDmgBonus(object oMyWeapon)
{
  itemproperty ipLoop=GetFirstItemProperty(oMyWeapon);
  while (GetIsItemPropertyValid(ipLoop))
  {
    if (GetItemPropertyType(ipLoop) == ITEM_PROPERTY_DAMAGE_BONUS &&
       GetItemPropertyDurationType(ipLoop) == DURATION_TYPE_TEMPORARY)
    {
      // Now remove the temporaly dmg bonus
      //IPRemoveMatchingItemProperties(oMyWeapon, ITEM_PROPERTY_DAMAGE_BONUS, DURATION_TYPE_TEMPORARY, -1);
      RemoveItemProperty(oMyWeapon, ipLoop);
    }
    ipLoop=GetNextItemProperty(oMyWeapon);
  }
}


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
    object oTarget = GetSpellTargetObject();
    int iIPConstDmgTypeID = IP_CONST_DAMAGETYPE_COLD;
    int nSpell = GetSpellId();
    int iCastingVisualEffectID = VFX_IMP_PULSE_COLD; // default casting visual effect
    int iItemVisualTypeID = ITEM_VISUAL_COLD; // default on-weapon visual effect
    int iDmgTypeID = IP_CONST_DAMAGETYPE_COLD;    // default dmg type


    effect eVis = EffectVisualEffect(iCastingVisualEffectID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    nCasterLvl = GetThalieCaster(OBJECT_SELF, oTarget, nCasterLvl,FALSE);
    int nDuration = 2 * nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();
    int iBonus = nCasterLvl;
    if (iBonus > 10)
    {
        iBonus = 10;
    }
    int iDamage = d4()+ iBonus;
    itemproperty ip = ItemPropertyDamageBonus(iDmgTypeID, GetIPDamageBonusByValue(iBonus));

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    float fDuration = TurnsToSeconds(nDuration);
    object oMyWeapon = oTarget;

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        TestAndRemoveTemporalDmgBonus(oMyWeapon);
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            SetItemPropertySpellId  (ip,EFFECT_IP_ABSOLUTE);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(iItemVisualTypeID), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }
    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        TestAndRemoveTemporalDmgBonus(oMyWeapon);
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            SetItemPropertySpellId  (ip,EFFECT_IP_ABSOLUTE);
            AddItemProperty(DURATION_TYPE_TEMPORARY, ip, oMyWeapon, fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(iItemVisualTypeID), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }

    }
}
