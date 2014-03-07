//#include "x2_inc_switches" // included in me_pcneeds_inc
#include "ku_exp_time"
#include "sh_cr_potions"
#include "sh_cr_bandages"
#include "me_pcneeds_inc"
#include "mys_hen_lib"

void DeadBody(object oActivator, object oItem);
void SkinningKnife(object oActivator, object oItem);
void UseHenchmanKey(object oActivator, object oItem);

void main()
{
    object oActivator = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oItem);
    
    // XP system
    ku_ItemActivated(oActivator, oItem);
    
    // Tag based scripting
    SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
    int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem), OBJECT_SELF);
    if (nRet == X2_EXECUTE_SCRIPT_END)
        return;

    // Bandages and potions
    sh_ModuleOnActivationItemCheckElixirs(oItem, oTarget, oActivator);
    sh_ModuleOnActivationItemCheckBandages(oItem, oTarget, oActivator);
    
    // Food and water
    if (GetStringLeft(sTag, 5) == "water" || GetStringLeft(sTag, 4) == "food")
    {
        SpeakString(sTag);
        PC_ConsumeIt(oActivator, oItem);
        return;
    }
    
    // Skinning knife
    if (GetTag(oItem) == "cnrSkinningKnife")
    {
        SkinningKnife(oActivator, oItem);
        return;
    }
    
    // Dead PC body
    if (GetResRef(oItem) == "mrtvola")
    {
        DeadBody(oActivator, oItem);
        return;
    }
    
    // Henchman key
    if (GetResRef(oItem) == HENCHMAN_KEY_TAG)
    {
        UseHenchmanKey(oActivator, oItem);
        return;
    }
    
    if (ExecuteScriptAndReturnInt("sy_mod_onitemact", OBJECT_SELF))
        return;

    ExecuteScript("kh_item_drugs", OBJECT_SELF);
    ExecuteScript("ku_onact_item", OBJECT_SELF); // kucik funkce
}

void DeadBody(object oActivator, object oItem)
{
    object oCorpse = oItem;

    string sPlayerName = GetLocalString(oCorpse, "PLAYER");
    string sPCName = GetLocalString(oCorpse, "PC");
    string sCorpseTag = GetTag(oCorpse);
    int iSubdual = GetLocalInt(oCorpse, "SUBDUAL");
    location lCorpse = GetLocation(oActivator);

    DestroyObject(oCorpse, 0.0f);

    oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "player_corpse", lCorpse, FALSE, sCorpseTag);
    SetName(oCorpse, sPCName);
    SetLocalString(oCorpse, "PLAYER", sPlayerName);
    SetLocalString(oCorpse, "PC", sPCName);
    SetLocalInt(oCorpse,"SUBDUAL",iSubdual);
}

void SkinningKnife(object oActivator, object oItem)
{
    if (GetLocalInt(oItem, "ME_MASO") == 1)
    {
        SetLocalInt(oItem, "ME_MASO", 0);
        AssignCommand(oActivator, DelayCommand(1.0, SendMessageToPC(oActivator, "Neziskavat ze zvirat maso.")));
        SetName(oItem, GetName(oItem, TRUE) + "  *neziskavat maso*");
    }
    else
    {
        SetLocalInt(oItem, "ME_MASO", 1);
        AssignCommand(oActivator, DelayCommand(1.0, SendMessageToPC(oActivator, "Ziskavat ze zvirat maso.")));
        SetName(oItem, GetName(oItem, TRUE));
    }
}

void UseHenchmanKey(object oActivator, object oItem)
{
    // If henchman exists, unsummon him first.
    object oHenchman = GetLocalObject(oItem, "HENCHMAN");
    if (GetIsObjectValid(oHenchman))
    {
        SetCommandable(TRUE, oHenchman);
        DestroyObject(oHenchman);
    }
    // Summmon henchman or destroy key if lease expired.
    if (!GetIsHenchmanKeyExpired(oItem))
        DelayCommand(2.0f, SummonHenchman(oItem));
    else
    {
        SendMessageToPC(oActivator, "Pronájem zvíøete vypršel.");
        DestroyObject(oItem);
    }        
}
