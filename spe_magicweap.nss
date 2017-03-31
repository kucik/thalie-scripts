
#include "sh_deity_inc"
#include "x2_inc_spellhook"
#include "sh_classes_const"
#include "nwnx_funcs"

void  AddGreaterEnhancementEffectToWeapon(object oMyWeapon, float fDuration, int nBonus)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(nBonus), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}


void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int iCasterLevel = GetCasterLevel(OBJECT_SELF);
    iCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,iCasterLevel,FALSE);
    //Finish declaration of major variables
    int iBonus = 7;
    int nDuration =  iCasterLevel ;

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
