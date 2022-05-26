//script sa aktivuje ak PC equipne veci z batohu na seba
//tento script patri do modules->OnPlayerEquip
/*
 *
 * rev. Kucik 05.01.2008 pridat pozadavek na silu pri equip, zbrane
 * rev. Kucik 05.01.2008 Pridana dynamicka munice
 */

/*
 * Inventory slots constants:
 * INVENTORY_SLOT_HEAD = 0
 * INVENTORY_SLOT_CHEST = 1
 * INVENTORY_SLOT_BOOTS = 2
 * INVENTORY_SLOT_ARMS = 3
 * INVENTORY_SLOT_RIGHTHAND = 4
 * INVENTORY_SLOT_LEFTHAND = 5
 * INVENTORY_SLOT_CLOAK = 6
 * INVENTORY_SLOT_LEFTRING = 7
 * INVENTORY_SLOT_RIGHTRING = 8
 * INVENTORY_SLOT_NECK = 9
 * INVENTORY_SLOT_BELT = 10
 * INVENTORY_SLOT_ARROWS = 11
 * INVENTORY_SLOT_BULLETS = 12
 * INVENTORY_SLOT_BOLTS = 13
 * INVENTORY_SLOT_CWEAPON_L = 14
 * INVENTORY_SLOT_CWEAPON_R = 15
 * INVENTORY_SLOT_CWEAPON_B = 16
 * INVENTORY_SLOT_CARMOUR = 17
 */

#include "x2_inc_switches"
#include "sy_main_lib"
#include "ku_libbase"
#include "sh_classes_inc"


void main()
{
    object oPC   = GetPCItemLastEquippedBy();
    object oItem = GetPCItemLastEquipped();
    OnEquipClassSystem(oPC,oItem);
    //pytel na hlavu - slepota
    if (GetTag(oItem)=="sys_blind_helmet")
    {
        effect ef = EffectBlindness();
        ef = SupernaturalEffect(ef);
        SetEffectSpellId(ef,EFFECT_PYTEL_NA_HLAVU);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,ef,oPC);
    }
}


