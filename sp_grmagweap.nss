//::///////////////////////////////////////////////
//:: Greater Magic Weapon
//:: X2_S0_GrMagWeap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Grants a +1 enhancement bonus per 4 caster levels
  (maximum of +5) do any weapon(s) equipped by target
  of the spell. Lasts 1 turn per level.
  Commented: Updated to suppport empowered version (max bonus +7).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 28, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:: 2003-07-17: Complete Rewrite to make use of Item Property System
//:: Updated by P.A., March 14, 2014



#include "sh_deity_inc"
#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"

/*
void  AddAttackEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyAttackBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}
*/

void  AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
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
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel);

    // if GetCasterLevel function encountered an error, return value is zero - deal with it now
    if (iCasterLevel < 1)
      /* Test for error value of the function GetCasterLevel()
      If error in the function GetCasterLevel, then return value is zero, therefore
      iCasterLevel is set to zero.
      If so, then
      a) set iCasterLevel to 1, to protect script from launching destructor of enhancement
        property earlier than the constructor of the enhancement.
      b) send debug message to caster if it is PC
      c) send debug message to target if it is PC
      */
    {
      iCasterLevel = 1;
      if (GetIsPC( OBJECT_SELF ) )
      {
        SendMessageToPC(OBJECT_SELF, "DEBUG: spell greater_magic_weapon, caster: caster level not identified"); // DEBUG msg
      }
      if (GetIsPC( oTarget ) )
      {
        SendMessageToPC(oTarget, "DEBUG: spell greater_magic_weapon, target: caster level not identified"); // DEBUG msg
      }
    } // end of if (iCasterLevel < 1)

    //Finish declaration of major variables
    int iBonus = iCasterLevel /4;
    int nDuration =  iCasterLevel ;
    int nMetaMagic = GetMetaMagicFeat();

    //Limit nCasterLvl to 5, so it max out at +5 enhancement to the weapon.
    if(iBonus > 5)
    {
        iBonus = 5;
    }



    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }
    /*
    else
    {
      if (nMetaMagic == METAMAGIC_EMPOWER )
      { // spell is empowered
           iBonus = 3*iBonus / 2;
      }
    }
    */

    if (GetClericDomain(OBJECT_SELF,1) ==DOMENA_KOV || GetClericDomain(OBJECT_SELF,2)==DOMENA_KOV)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }


    object oMyWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }


    oMyWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    if(GetIsObjectValid(oMyWeapon) && GetBaseItemType(oMyWeapon) == BASE_ITEM_GLOVES )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon),TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus);// tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }
   oMyWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget);
    if(GetIsObjectValid(oMyWeapon) )
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        // if (nDuration>0) // nDuration is always larger than 0, IF deleted
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            //AddAttackEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // tvar z pred 27.2.2014
            AddGreaterEnhancementEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),iBonus); // upraveno dle Rejtyho, 27.2.2014
        }

    }

}
