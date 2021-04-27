#include "x2_inc_itemprop"
#include "mys_mount_lib"
void main()
{
    //Declare major variables
    int iShape = 0;
    if (GetHasFeat(1694))
    {
        //Green
        iShape = 118;
    }
    else if (GetHasFeat(1695))
    {
        //Blue
        iShape = 119;
    }
    else if (GetHasFeat(1696))
    {
        //Purple
        iShape = 120;
    }
    else if (GetHasFeat(1697))
    {
        //Orange
        iShape = 121;
    }
    else if (GetHasFeat(1698))
    {
        //Pink
        iShape = 122;
    }
    if (iShape==0)
    {
        return;
    }

    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);

    if (!GetLocalInt(GetModule(),"X3_NO_SHAPESHIFT_SPELL_CHECK"))
    { // check to see if abort due to being mounted
        if (GetIsMounted(OBJECT_SELF))
        { // abort
            if (GetIsPC(OBJECT_SELF)) FloatingTextStrRefOnCreature(111982,OBJECT_SELF,FALSE);
            return;
        } // abort
    } // check to see if abort due to being mounted
    effect ePoly = EffectPolymorph(iShape);
    ePoly = ExtraordinaryEffect(ePoly);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 997, FALSE));

    object oWeaponOld = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorOld = GetItemInSlot(INVENTORY_SLOT_CHEST,OBJECT_SELF);
    object oRing1Old = GetItemInSlot(INVENTORY_SLOT_LEFTRING,OBJECT_SELF);
    object oRing2Old = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,OBJECT_SELF);
    object oAmuletOld = GetItemInSlot(INVENTORY_SLOT_NECK,OBJECT_SELF);
    object oCloakOld  = GetItemInSlot(INVENTORY_SLOT_CLOAK,OBJECT_SELF);
    object oBootsOld  = GetItemInSlot(INVENTORY_SLOT_BOOTS,OBJECT_SELF);
    object oBeltOld = GetItemInSlot(INVENTORY_SLOT_BELT,OBJECT_SELF);
    object oHelmetOld = GetItemInSlot(INVENTORY_SLOT_HEAD,OBJECT_SELF);
    object oShield    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    object oGloves    = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) !=BASE_ITEM_LARGESHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_SMALLSHIELD &&
            GetBaseItemType(oShield) !=BASE_ITEM_TOWERSHIELD)
        {
            oShield = OBJECT_INVALID;
        }
    }
    //Apply the VFX impact and effects
    ClearAllActions(); // prevents an exploit
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePoly, OBJECT_SELF);

    object oWeaponNew = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    object oArmorNew = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    IPWildShapeCopyItemProperties(oWeaponOld,oWeaponNew, TRUE);
    IPWildShapeCopyItemProperties(oHelmetOld,oArmorNew);
    IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
    IPWildShapeCopyItemProperties(oShield,oArmorNew);
    IPWildShapeCopyItemProperties(oArmorOld,oArmorNew);
    IPWildShapeCopyItemProperties(oRing1Old,oArmorNew);
    IPWildShapeCopyItemProperties(oRing2Old,oArmorNew);
    IPWildShapeCopyItemProperties(oAmuletOld,oArmorNew);
    IPWildShapeCopyItemProperties(oCloakOld,oArmorNew);
    IPWildShapeCopyItemProperties(oBootsOld,oArmorNew);
    IPWildShapeCopyItemProperties(oBeltOld,oArmorNew);
}
