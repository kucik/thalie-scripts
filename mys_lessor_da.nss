#include "nwnx_events"
#include "mys_hen_lib"

void main()
{
    string sText = GetSelectedNodeText();
    object oPC = GetPCSpeaker();
    int i = GetLocalInt(oPC, "KU_CHAT_CACHE_INDEX");
    string sChat = GetLocalString(oPC, "KU_CHAT_CACHE_" + IntToString(i));
    
    if (sText == "Chci si pronajmout zvíøe na rok.")
    {
        object oHenchman = GetHenchmanByName(OBJECT_SELF, sChat);
        if (GetIsObjectValid(oHenchman))
        {
            int bHired = HireHenchman(oHenchman, oPC, OBJECT_SELF);
            if (bHired)
            {
                DestroyObject(oHenchman);
                SendMessageToPC(oPC, "Dìkuji za obchod. Zvíøe je tvé.");                        
            }
            else
                SendMessageToPC(oPC, "Nesrovnalosti mi zabránily ti zvíøe pronajmout.");
        }
    }
    else if (sText == "Chci prodloužit nájem o rok.")
    {
        object oKey = GetKeyByName(oPC, sChat);
        if (GetIsObjectValid(oKey))
        {
            int bExtended = ExtendHenchmanKey(oKey, OBJECT_SELF);
            if (bExtended)
                SendMessageToPC(oPC, "Tvùj pronájem byl prodloužen o další rok.");                        
            else
                SendMessageToPC(oPC, "Nesrovnalosti mi zabránily prodloužit pronájem.");
        }
    }
    else
    {
        SendMessageToPC(oPC, "Chyba: neurèená akce.");
    }
}
