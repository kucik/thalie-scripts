#include "nwnx_events"
#include "mys_hen_lib"
#include "mys_mount_lib"

void main()
{
    string sText = GetSelectedNodeText();
    object oPC = GetPCSpeaker();
    
    if (sText == "<StartAction>[Odvolat]</Start>")
    {
        object oKey = GetKeyByName(oPC, GetName(OBJECT_SELF));
        SetLocalInt(oKey, "HENCHMAN_HP", GetCurrentHitPoints(OBJECT_SELF));
        DeleteLocalObject(oKey, "HENCHMAN");
        SetLocalInt(oKey, "HENCHMAN_USES", 1);
        ClearAllActions(TRUE);
        DestroyObject(OBJECT_SELF);
    }
    else if (sText == "<StartAction>[Do party]</Start>")
    {
        if (!GetIsObjectValid(GetMaster(OBJECT_SELF)))
        {
            SetCommandable(TRUE);
            AddHenchman(oPC, OBJECT_SELF);
            // for /h chat command
            SetLocalObject(oPC, "HENCHMAN", OBJECT_SELF);
        }
    }    
    else if (sText == "<StartAction>[Pøejmenovat zvíøe]</Start>")
    {
        int i = GetLocalInt(oPC, "KU_CHAT_CACHE_INDEX");
        string sNewName = GetLocalString(oPC, "KU_CHAT_CACHE_" + IntToString(i));
        int bRenamed = RenameHenchman(OBJECT_SELF, sNewName);
        
        if (bRenamed)
            SendMessageToPC(oPC, "Jméno zmìnìno na: " + sNewName + ".");
        else
            SendMessageToPC(oPC, "Zmìna jména se nezdaøila.");
    }
    else if (sText == "<StartAction>[Prodloužit pronájem o pùl roku]</Start>")
    {
        object oKey = GetLocalObject(OBJECT_SELF, "KEY");
        
        if (GetIsObjectValid(oKey))
        {
            int iPrice = GetLocalInt(oKey, "HENCHMAN_LEASE_PRICE") / 2;
            if (!iPrice)
            {
                SendMessageToPC(oPC, "Nesrovnalosti s cenou mi zabránily prodloužit pronájem.");
                return;
            }
            
            if (GetGold(oPC) < iPrice)
            {
                SendMessageToPC(oPC, "Nemáš dost grešlí.");
                return;
            }
            
            int bExtended = ExtendHenchmanKey(oKey, OBJECT_SELF, 2419200);
            if (bExtended)
            {
                TakeGoldFromCreature(iPrice, oPC, TRUE);
                SendMessageToPC(oPC, "Tvùj pronájem byl prodloužen o další pùlrok.");
            }                        
            else
                SendMessageToPC(oPC, "Nesrovnalosti mi zabránily prodloužit pronájem.");
        }
    }
    else if (sText == "<StartAction>[Prodloužit pronájem o rok]</Start>")
    {
        object oKey = GetLocalObject(OBJECT_SELF, "KEY");
        
        if (GetIsObjectValid(oKey))
        {
            int iPrice = GetLocalInt(oKey, "HENCHMAN_LEASE_PRICE");
            if (!iPrice)
            {
                SendMessageToPC(oPC, "Nesrovnalosti s cenou mi zabránily prodloužit pronájem.");
                return;
            }
            
            if (GetGold(oPC) < iPrice)
            {
                SendMessageToPC(oPC, "Nemáš dost grešlí.");
                return;
            }
            
            int bExtended = ExtendHenchmanKey(oKey, OBJECT_SELF);
            if (bExtended)
            {
                TakeGoldFromCreature(iPrice, oPC, TRUE);
                SendMessageToPC(oPC, "Tvùj pronájem byl prodloužen o další rok.");
            }                        
            else
                SendMessageToPC(oPC, "Nesrovnalosti mi zabránily prodloužit pronájem.");
        }
    }
    
    else if (sText == "Pronajmout zvíøe na pùl roku.")
    {
        if (GetIsObjectValid(OBJECT_SELF))
        {
            object oKey = HireHenchman(OBJECT_SELF, oPC, OBJECT_INVALID, 0.5f);
            if (GetIsObjectValid(oKey))
            {
                StoreMountInfo(OBJECT_SELF, oKey);
                SendMessageToPC(oPC, "Zvíøe je tvé. Pronájem vyprší za pùl roku.");                        
            }
            else
                SendMessageToPC(oPC, "Nesrovnalosti ti zabránily pronajmout si zvíøe.");
        }
        else
            SendMessageToPC(oPC, "Zvíøe není k dispozici.");
    }
    else if (sText == "Pronajmout zvíøe na 1 rok.")
    {
        if (GetIsObjectValid(OBJECT_SELF))
        {
            object oKey = HireHenchman(OBJECT_SELF, oPC);
            if (GetIsObjectValid(oKey))
            {
                StoreMountInfo(OBJECT_SELF, oKey);
                SendMessageToPC(oPC, "Zvíøe je tvé. Pronájem vyprší za rok.");                        
            }
            else
                SendMessageToPC(oPC, "Nesrovnalosti ti zabránily pronajmout si zvíøe.");
        }
        else
            SendMessageToPC(oPC, "Zvíøe není k dispozici.");
    }
    else
    {
        SendMessageToPC(oPC, "Chyba: neurèená akce.");
    }
}
