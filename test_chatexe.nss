#include "nwnx_funcs"

void main()
{
    object oPC = GetPCChatSpeaker();
    string sText = GetPCChatMessage();
    
    SendMessageToPC(oPC, "Debug: chat test started.");
    
    int iSoundSet = GetSoundset(oPC);
    SendMessageToPC(oPC, "Debug: a)soundset index = " + IntToString(iSoundSet));
    SetSoundset(oPC, 0);
    SendMessageToPC(oPC, "Debug: b)soundset index = " + IntToString(GetSoundset(oPC)));
    BeginConversation("myd_emote", oPC);
    SetSoundset(oPC, iSoundSet);
    SendMessageToPC(oPC, "Debug: c)soundset index = " + IntToString(GetSoundset(oPC)));
    
    SetPCChatMessage("");
    SendMessageToPC(oPC, "Debug: chat test finished.");
}
    