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
    else if (sText == "Pronajmout zvíøe.")
    {
        if (GetIsObjectValid(OBJECT_SELF))
        {
            object oKey = HireHenchman(OBJECT_SELF, oPC);
            if (GetIsObjectValid(oKey))
            {
                StoreMountInfo(OBJECT_SELF, oKey);
                SendMessageToPC(oPC, "Zvíøe je tvé. Pronájem vyprší za 1 rok.");                        
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
