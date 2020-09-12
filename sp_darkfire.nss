//::///////////////////////////////////////////////
//:: Darkfire
//:: X2_S0_Darkfire
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d6 fire damage +1 per two caster
  levels to a maximum of +10.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Dec 04, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-29: Rewritten, Georg Zoeller


#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"
#include "sh_classes_inc_e"


void AddFlamingEffectToWeapon(object oTarget, float fDuration, int nCasterLvl)
{
   // If the spell is cast again, any previous itemproperties matching are removed.
   itemproperty ip =  ItemPropertyOnHitCastSpell(127,nCasterLvl);
   SetItemPropertySpellId  (ip,EFFECT_IP_ABSOLUTE);
   IPSafeAddItemProperty(oTarget, ip, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
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
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_FLAME_M),eVis);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    nCasterLvl = GetThalieCaster(OBJECT_SELF, oTarget, nCasterLvl,FALSE);
    int nDuration = nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();

    //Limit nCasterLvl to 10, so it max out at +10 to the damage.
    //Bugfix: Limiting nCasterLvl to *20* - the damage calculation
    //        divides it by 2.
    if(nCasterLvl > 15)
    {
        nCasterLvl = 15;
    }

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    float fDuration = TurnsToSeconds(nDuration/2);


    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddFlamingEffectToWeapon(oMyWeapon, fDuration,nCasterLvl);
        }

    }
}
