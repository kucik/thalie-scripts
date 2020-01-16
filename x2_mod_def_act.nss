//#include "x2_inc_switches" // included in me_pcneeds_inc
#include "ku_exp_time"
#include "sh_cr_potions"
#include "sh_cr_bandages"
#include "me_pcneeds_inc"
#include "mys_hen_lib"
#include "mys_mount_lib"

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

    if (GetTag(oItem) == "me_fishingpole")
    {
        ExecuteScript("me_nc_cfishfresh", oActivator);
        return;
    }

    if (GetTag(oItem) == "rp_list")
    {
        if (oActivator==oTarget)
        {
            if (GetLocalInt(oTarget,"RP_LIST")==1)
            {
                SetLocalInt(oTarget,"RP_LIST",0);
                SendMessageToPC(oTarget,"Postava byla odebrana z RP seznamu.");
            }
            else
            {
                SetLocalInt(oTarget,"RP_LIST",1);
                SendMessageToPC(oTarget,"Postava byla pridana na RP seznam.");
            }
        }
        else
        {
            SendMessageToPC(oActivator,"RP List:");
            object oPC = GetFirstPC();
            while (GetIsObjectValid(oPC))
            {
                if (GetIsDM(oPC)==FALSE)
                {
                    SendMessageToPC(oActivator,GetName(oPC)+" - "+GetName(GetArea(oPC)));
                }
                oPC = GetNextPC();
            }


        }
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
    if (!GetIsHenchmanKeyExpired(oItem))
    {
        object oHenchman = GetLocalObject(oItem, "HENCHMAN");

        // Debug:
        //SendMessageToPC(oActivator, "[DEBUG] Poèet použití vyvolávacího itemu: " + IntToString(GetLocalInt(oItem, "HENCHMAN_USES")));
        //if (GetIsObjectValid(oHenchman) && !GetIsDead(oHenchman))
            //SendMessageToPC(oActivator, "[DEBUG] Mount jménem " + GetName(oHenchman) + " je již vyvolán. Pøivolávám.");

        // Summon when exists elsewhere, or is unsummoned.
        if (GetLocalInt(oItem, "HENCHMAN_USES") || (GetIsObjectValid(oHenchman) && !GetIsDead(oHenchman)))
        {
            // If henchman exists, unsummon him first.
            if (GetIsObjectValid(oHenchman))
            {
                SetCommandable(TRUE, oHenchman);
                DestroyObject(oHenchman);
            }
            // Summmon henchman.
            //SendMessageToPC(oActivator, "[DEBUG] Povolávám mounta...");
            object oMount = SummonHenchman(oItem);
            SetMountProperties(oMount, oItem);
            // for /h chat command
            SetLocalObject(oActivator, "HENCHMAN", oMount);
            if (GetIsObjectValid(oMount))
            {
                //SendMessageToPC(oActivator, "[DEBUG] Mount povolán.");
                //SendMessageToPC(oActivator, "[DEBUG] Poèet použití vyvolávacího itemu: " + IntToString(GetLocalInt(oItem, "HENCHMAN_USES")));
            }
        }
        else
            SendMessageToPC(oActivator, "Došla použití pro tento den.");
    }
    else
    {
        // Destroy key if lease expired.
        SendMessageToPC(oActivator, "Pronájem zvíøete vypršel.");
        DestroyObject(oItem);
    }
}
