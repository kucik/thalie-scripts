//::///////////////////////////////////////////////
//:: Flame Weapon
//:: X2_S0_FlmeWeap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d4 fire damage +1 per caster
  level to a maximum of +10.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 29, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-15: Complete Rewrite to make use of Item Property System




#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "nw_i0_spells"
#include "x2_i0_spells"


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
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF)+1;
    nCasterLvl = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLvl,FALSE);
    int nDuration = 2 * nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();
    int iBonus = d6()+nCasterLvl/4;
    if (iBonus > 10)
    {
        iBonus = 10;
    }
    itemproperty ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE ,GetIPDamageBonusByValue(iBonus));

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    float fDuration = RoundsToSeconds(nDuration);

    // ---------------- TARGETED ON BOLT  -------------------
    if(GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
    {
        // special handling for blessing crossbow bolts that can slay rakshasa's
        int iItemType = GetBaseItemType(oTarget);
        if (iItemType == BASE_ITEM_BOLT ||
            iItemType == BASE_ITEM_ARROW ||
            iItemType == BASE_ITEM_BULLET)
        {
          //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
          if (nDuration>0) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oMyWeapon,fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
            return;
          }
        }
    }

    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oMyWeapon,fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }
    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oMyWeapon,fDuration);
            IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);

        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        //SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oMyWeapon,fDuration);
        }

    }

}
