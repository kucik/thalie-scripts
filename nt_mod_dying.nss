//::///////////////////////////////////////////////
//:: Dying Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player is dying.
    DEFAULT CAMPAIGN: player dies automatically

     * Kucik 27.05.2008 Upravy subdual
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////
// melvik upava na novy zpusob nacitani soulstone 16.5.2009
#include "sh_classes_inc_e"
#include "pc_lib"

int GetSubdualMode(object oDammager)
{
    int nSubdual = GetLocalInt(oDammager, "SUBDUAL_MODE");
    
    if (!nSubdual)
    {
        if (GetIsPlayer(oDammager))
            nSubdual = GetLocalInt(GetSoulStone(oDammager), "SUBDUAL_MODE");
                            
        else if (GetAssociateType(oDammager))
        {
            object oMaster = GetTopMaster(oDammager);
            nSubdual = GetLocalInt(oMaster, "SUBDUAL_MODE");
            if (!nSubdual)
                nSubdual = GetLocalInt(GetSoulStone(oMaster), "SUBDUAL_MODE");
        }
    }
    return nSubdual;
}

void HABDRegenerationItemsUnequip(object oPC)
{
    // If the player already has unequiped items they never had a re-equip
    // call for then do nothing. WARNING: this could potential cause an
    // exploit if players can find a way to come back to life without initiating
    // the corresponding equip items call.
    //if (GetLocalInt(oPC, HABD_UNEQUIPED_ITEMS) != 0) return;

    // Go through the players inventory and unequip all of their regeneration
    // items.
    //int iCount = 0;
    int i;
    object oItem;
    object oNewItem;
    for (i=0; i<NUM_INVENTORY_SLOTS; i++)
    {
        oItem = GetItemInSlot(i, oPC);
        if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION))
        {
            //iCount++;
            // Stupid work around to ActionUnequip item not working in a timely manner.
            oNewItem = CopyItem(oItem, oPC);
            DestroyObject(oItem);
            SendMessageToPC(oPC, "Unequipping "+GetName(oItem));
            /*SetLocalObject(oPC, HABD_UNEQUIPED_ITEMS+IntToString(iCount), oNewItem);
            SetLocalInt(oPC, HABD_UNEQUIPED_ITEMS+"Slot"+IntToString(iCount), i);*/
        }
    }
    //SetLocalInt(oPC, HABD_UNEQUIPED_ITEMS, iCount);
}


void main()
{
    object oPC = GetLastPlayerDying();
//    SendMessageToPC(oPC,"Subdual check");

    object oDammager = GetLastDamager(oPC);
    /*
    int nSubdual = 0;
    object oSoul =GetSoulStone(oDammager);

    if(GetIsObjectValid(oSoul))
      nSubdual = GetLocalInt(oSoul,"SUBDUAL_MODE");
    else
      nSubdual = GetLocalInt(oDammager,"SUBDUAL_MODE");
    */
    
    // Get subdual damage (stínovky)
    int nSubdual = GetSubdualMode(oDammager);
    
    if(!nSubdual) {
      nSubdual=1;
      SendMessageToPC(oPC,"//Debug info: Zranil te "+GetName(oDammager)+" bez pouziti stinovych zraneni. Umiras.");
    }
    else
      SendMessageToPC(oPC,"//Debug info: Zranil te "+GetName(oDammager)+" s pouzitim stinovych zraneni. Upadas do bezvedomi.");

    SetLocalInt(oPC,"SUBDAMADE_TYPE",nSubdual);

    // Save HP
    SetPersistentInt(oPC, "HP", GetCurrentHitPoints(oPC));

    /*
    AssignCommand(GetLastDamager(oPC),ClearAllActions(TRUE));
    effect eHeal = EffectHeal(1 - GetCurrentHitPoints(oPC));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);
    return;
    */
//    SendMessageToPC(oPC,"You are dying.");

    effect eReg = GetFirstEffect(oPC);

    HABDRegenerationItemsUnequip(oPC);

    // Create the effect to apply
    //effect eHPLoss = EffectHitPointChangeWhenDying(-0.3);

    // Apply the effect to the object
    //ApplyEffectToObject(DURATION_TYPE_INSTANT, eHPLoss, oPC);
}

