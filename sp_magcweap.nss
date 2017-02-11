//::///////////////////////////////////////////////
//:: Magic Weapon
//:: X2_S0_MagcWeap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +1 enhancement bonus to all weapons  equipped
  by a target of the spell. Lasts 1 turn per level.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-17: Complete Rewrite to make use of Item Property System
//:: Updated by P.A., Sep 21, 2014


#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"
#include "sh_deity_inc"


/*
void  AddAttackEffectToWeapon(object oMyWeapon, float fDuration)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyAttackBonus(1), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING ,TRUE,TRUE);
   return;
}
*/

void AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration)
{
  IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(1), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
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
    int nDuration = GetCasterLevel(OBJECT_SELF);
    object oMyWeapon;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration);
    // object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();


    if (nDuration < 1) // if GetCasterLevel function encountered an error, return value is zero - deal with it now
      /* Test for error value of the function GetCasterLevel()
        If error in the function GetCasterLevel, then return value is zero, therefore
        nDuration is set to zero.

        If so, then
        a) set nDuration to 1, to protect script from launching destructor of enhancement
          property earlier than the constructor of the enhancement.
        b) send debug message to caster if it is PC
        c) send debug message to target if it is PC
      */
    {
      nDuration = 1;
      if (GetIsPC( OBJECT_SELF ) )
      {
        SendMessageToPC(OBJECT_SELF, "DEBUG: spell magic_weapon, caster: caster level not identified"); // DEBUG msg
      }
      if (GetIsPC( oTarget ) )
      {
        SendMessageToPC(oTarget, "DEBUG: spell magic_weapon, target: caster level not identified"); // DEBUG msg
      }
    } // end of if (nDuration < 1)

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    if (GetClericDomain(OBJECT_SELF,1) ==DOMENA_KOV || GetClericDomain(OBJECT_SELF,2)==DOMENA_KOV)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        //if (nDuration>0) // nDuration is always higher than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            // AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // tvar pred 2014_09_21, +1 AB
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        //if (nDuration>0) // nDuration is always higher than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // tvar pred 2014_09_21, +1 AB
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        //if (nDuration>0) // nDuration is always higher than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // tvar pred 2014_09_21, +1 AB
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }

    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration)); // zmena na +1 enhancement, 2014_09_21
        }
    }
}
