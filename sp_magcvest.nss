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

//#include "nw_i0_spells"
//#include "x2_i0_spells"
#include "sh_deity_inc"
#include "x2_inc_spellhook"
#include "sh_classes_inc_e"
#include "sh_deity_inc"
//#include "nwnx_funcs"
//#include "nwnx_functions"






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
    int iIP,bHasArmorBonus = FALSE;
    itemproperty ip;
    int iCasterLevel  = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel);
    int nDuration  = iCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();
    int nAmount = 1+iCasterLevel/5;
    if (nDuration<=4)
    {
         nDuration = 5;
    }
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
        nDuration = nDuration * 2; //Duration is +100%
    }

    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    if(   (GetIsObjectValid(oShield)) &&
          ( (GetBaseItemType(oShield) == BASE_ITEM_LARGESHIELD) ||
            (GetBaseItemType(oShield) == BASE_ITEM_SMALLSHIELD) ||
            (GetBaseItemType(oShield) == BASE_ITEM_TOWERSHIELD)))
    {
        DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        ip = ItemPropertyACBonus(nAmount);
        SetItemPropertySpellId  (ip,EFFECT_IP_ABSOLUTE);
        IPSafeAddItemProperty(oShield,ip, TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    }
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
    if(   (GetIsObjectValid(oArmor)))
    {
        DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        ip = ItemPropertyACBonus(nAmount);
        SetItemPropertySpellId  (ip,EFFECT_IP_ABSOLUTE);
        IPSafeAddItemProperty(oArmor,ip, TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    }

}
