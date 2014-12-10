//::///////////////////////////////////////////////
//:: Blade Thrist
//:: X2_S0_BldeThst
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +3 enhancement bonus to a slashing weapon
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 27, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-21: Complete Rewrite to make use of Item Property System


#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void  AddEnhanceEffectToWeapon(object oMyWeapon, float fDuration)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(3), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
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
    int nCasterLevel = GetThalieCaster(OBJECT_SELF,OBJECT_SELF,GetCasterLevel(OBJECT_SELF),FALSE);
    int nMetaMagic = GetMetaMagicFeat();
    int nPower = nCasterLevel / 4;
    if (nPower > 5)  nPower = 5;  // * max of +5 bonus
    int nDuration = nCasterLevel;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    float fDuration = TurnsToSeconds(nDuration);
    itemproperty ip1 = ItemPropertyEnhancementBonus(nPower);
    itemproperty ip2 = ItemPropertyVampiricRegeneration(nPower);
    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nCasterLevel>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip1,oMyWeapon,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip2,oMyWeapon,fDuration);
        }
    }
    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nCasterLevel>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip1,oMyWeapon,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip2,oMyWeapon,fDuration);
        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nCasterLevel>0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip1,oMyWeapon,fDuration);
            AddItemProperty(DURATION_TYPE_TEMPORARY,ip2,oMyWeapon,fDuration);
        }

    }






}
