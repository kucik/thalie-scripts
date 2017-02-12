//::///////////////////////////////////////////////
//:: Bless Weapon
//:: X2_S0_BlssWeap
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

  If cast on a crossbow bolt, it adds the ability to
  slay rakshasa's on hit

  If cast on a melee weapon, it will add the
      grants a +1 enhancement bonus.
      grants a +2d6 damage divine to undead

  will add a holy vfx when command becomes available

  If cast on a creature it will pick the first
  melee weapon without these effects

*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 09, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-15: Complete Rewrite to make use of Item Property System

#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void AddBlessEffectToWeapon(object oTarget, float fDuration)
{
   // If the spell is cast again, any previous enhancement boni are kept
   IPSafeAddItemProperty(oTarget, ItemPropertyAttackBonus(1), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
   // Replace existing temporary anti undead boni
   IPSafeAddItemProperty(oTarget, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
   return;
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
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    int nDuration = 2 * GetThalieCaster(OBJECT_SELF,oTarget,GetCasterLevel(OBJECT_SELF),FALSE);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2; //Duration is +100%
    }

    if (GetIsObjectValid(oTarget) && nDuration)
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            SignalEvent(GetItemPossessor(oTarget), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            if (GetBaseItemType(oTarget) == BASE_ITEM_BOLT)
                IPSafeAddItemProperty(oTarget, ItemPropertyOnHitCastSpell(123,1), RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING );
            AddBlessEffectToWeapon(oTarget, TurnsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oTarget), TurnsToSeconds(nDuration));
            return;
        }
        else if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            object oWeapon;
            int iBlessed;
            oWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);

            if (GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
                iBlessed = TRUE;
            }

            oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);

            if (GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
                iBlessed = TRUE;
            }

            oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget);

            if (GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
                iBlessed = TRUE;
            }

            oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget);

            if (GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
                iBlessed = TRUE;
            }

            oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget);

            if (GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
                iBlessed = TRUE;
            }

            if (iBlessed) return;

            oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);

            if(GetIsObjectValid(oWeapon))
            {
                SignalEvent(GetItemPossessor(oWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                AddBlessEffectToWeapon(oWeapon, TurnsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nDuration));
            }
        }
    }
}
