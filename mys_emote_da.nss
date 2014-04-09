#include "nwnx_events"
#include "mys_emote_lib"

string GetDialogActionText(string sText)
{
    return "<StartAction>[" + sText + "]</Start>";
}

void main()
{
    string sText = GetSelectedNodeText();
    object oPC = GetPCSpeaker();
    
    // *************************************************************************
    // Pokøiky
    // *************************************************************************
    
    if (sText == GetDialogActionText("bojový 1"))
    {
        ActionPlayEmote(oPC, 14);
    }
    else if (sText == GetDialogActionText("bojový 2"))
    {
        ActionPlayEmote(oPC, 15);
    }
    else if (sText == GetDialogActionText("bojový 3"))
    {
        ActionPlayEmote(oPC, 16);
    }
    else if (sText == GetDialogActionText("vítìzný 1"))
    {
        ActionPlayEmote(oPC, 11);
    }
    else if (sText == GetDialogActionText("vítìzný 2"))
    {
        ActionPlayEmote(oPC, 12);
    }
    else if (sText == GetDialogActionText("vítìzný 3"))
    {
        ActionPlayEmote(oPC, 13);
    }
    
    // *************************************************************************
    // Jednorázové animace
    // *************************************************************************
    
    else if (sText == GetDialogActionText("souhlas"))
    {
        ActionPlayEmote(oPC, 47);
    }
    else if (sText == GetDialogActionText("rozpaky"))
    {
        ActionPlayEmote(oPC, 8);
    }
    else if (sText == GetDialogActionText("zamávat"))
    {
        ActionPlayEmote(oPC, 5);
    }
    else if (sText == GetDialogActionText("salutovat"))
    {
        ActionPlayEmote(oPC, 7);
    }
    else if (sText == GetDialogActionText("úklona"))
    {
        ActionPlayEmote(oPC, 1);
    }
    else if (sText == GetDialogActionText("výzva"))
    {
        ActionPlayEmote(oPC, 10);
    }
    else if (sText == GetDialogActionText("úhyb"))
    {
        ActionPlayEmote(oPC, 2);
    }
    else if (sText == GetDialogActionText("døep"))
    {
        ActionPlayEmote(oPC, 4);
    }
    else if (sText == GetDialogActionText("prùtah"))
    {
        ActionPlayEmote(oPC, 0);
    }
    else if (sText == GetDialogActionText("okrást"))
    {
        ActionPlayEmote(oPC, 9);
    }
    else if (sText == GetDialogActionText("èetba"))
    {
        ActionPlayEmote(oPC, 6);
    }
    else if (sText == GetDialogActionText("napít se"))
    {
        ActionPlayEmote(oPC, 3);
    }
    else if (sText == GetDialogActionText("skok"))
    {
        ActionPlayEmote(oPC, 38);
    }
    
    // *************************************************************************
    // Trvalé animace
    // *************************************************************************
    
    else if (sText == GetDialogActionText("založit ruce"))
    {
        ActionPlayEmote(oPC, 37);
    }
    else if (sText == GetDialogActionText("pøemýšlet"))
    {
        ActionPlayEmote(oPC, 35);
    }
    else if (sText == GetDialogActionText("dívat do dáli"))
    {
        ActionPlayEmote(oPC, 26);
    }
    else if (sText == GetDialogActionText("zakleknout"))
    {
        ActionPlayEmote(oPC, 40);
    }
    else if (sText == GetDialogActionText("kleèet"))
    {
        ActionPlayEmote(oPC, 27);
    }
    else if (sText == GetDialogActionText("prosit"))
    {
        ActionPlayEmote(oPC, 17);
    }
    else if (sText == GetDialogActionText("ukázat"))
    {
        ActionPlayEmote(oPC, 34);
    }
    else if (sText == GetDialogActionText("pobízet"))
    {
        ActionPlayEmote(oPC, 39);
    }
    else if (sText == GetDialogActionText("hrozit"))
    {
        ActionPlayEmote(oPC, 30);
    }
    else if (sText == GetDialogActionText("krýt hlavu"))
    {
        ActionPlayEmote(oPC, 36);
    }    
    else if (sText == GetDialogActionText("únava"))
    {
        ActionPlayEmote(oPC, 29);
    }
    else if (sText == GetDialogActionText("smích"))
    {
        ActionPlayEmote(oPC, 25);
    }
    else if (sText == GetDialogActionText("opilost"))
    {
        ActionPlayEmote(oPC, 20);
    }
    else if (sText == GetDialogActionText("záchvat"))
    {
        ActionPlayEmote(oPC, 28);
    }
    else if (sText == GetDialogActionText("uctívat"))
    {
        ActionPlayEmote(oPC, 31);
    }
    else if (sText == GetDialogActionText("èáry"))
    {
        ActionPlayEmote(oPC, 18);
    }
    else if (sText == GetDialogActionText("èáry nad hlavou"))
    {
        ActionPlayEmote(oPC, 19);
    }
    else if (sText == GetDialogActionText("nìco na zemi"))
    {
        ActionPlayEmote(oPC, 23);
    }
    else if (sText == GetDialogActionText("nìco v úrovni pasu"))
    {
        ActionPlayEmote(oPC, 24);
    }
    
    // *************************************************************************
    // Animace sezení
    // *************************************************************************
    
    else if (sText == GetDialogActionText("sedìt na zemi"))
    {
        ActionPlayEmote(oPC, 32);
    }
    else if (sText == GetDialogActionText("sedìt na nìèem"))
    {
        ActionPlayEmote(oPC, 33);
    }
    else if (sText == GetDialogActionText("sedìt na nejbližší vìci"))
    {
        ActionPlayEmote(oPC, 44);
    }
    else if (sText == GetDialogActionText("èíst v sedì"))
    {
        ActionPlayEmote(oPC, 46);
    }
    else if (sText == GetDialogActionText("napít se v sedì"))
    {
        ActionPlayEmote(oPC, 45);
    }
    
    // *************************************************************************
    // Animace ležení
    // *************************************************************************
    
    else if (sText == GetDialogActionText("ležet na bøiše"))
    {
        ActionPlayEmote(oPC, 22);
    }
    else if (sText == GetDialogActionText("ležet na zádech"))
    {
        ActionPlayEmote(oPC, 21);
    }
    else if (sText == GetDialogActionText("ležet na boku"))
    {
        ActionPlayEmote(oPC, 43);
    }
    
    // *************************************************************************
    // Ostatní animace
    // *************************************************************************
    
    else if (sText == GetDialogActionText("kouøit"))
    {
        ActionPlayEmote(oPC, 49);
    }
    else if (sText == GetDialogActionText("tanec"))
    {
        ActionPlayEmote(oPC, 48);
    }
    else if (sText == GetDialogActionText("rubat"))
    {
        ActionPlayEmote(oPC, 42);
    }
    else if (sText == GetDialogActionText("viset"))
    {
        ActionPlayEmote(oPC, 41);
    }
    
    // *************************************************************************
    // Zvukové projevy
    // *************************************************************************
    else if (sText == GetDialogActionText("pískat si"))
    {
        ActionPlaySoundEmote(oPC, 0);
    }
    else if (sText == GetDialogActionText("krknout"))
    {
        ActionPlaySoundEmote(oPC, 1);
    }
    else if (sText == GetDialogActionText("odplivnout"))
    {
        ActionPlaySoundEmote(oPC, 2);
    }
    else if (sText == GetDialogActionText("kýchnout"))
    {
        ActionPlaySoundEmote(oPC, 3);
    }
    else if (sText == GetDialogActionText("kašlat"))
    {
        ActionPlaySoundEmote(oPC, 4);
    }
    else if (sText == GetDialogActionText("zívnout"))
    {
        ActionPlaySoundEmote(oPC, 5);
    }
    else if (sText == GetDialogActionText("chrápat"))
    {
        ActionPlaySoundEmote(oPC, 6);
    }
    else if (sText == GetDialogActionText("pláè"))
    {
        ActionPlaySoundEmote(oPC, 7);
    }
    else if (sText == GetDialogActionText("modlení"))
    {
        ActionPlaySoundEmote(oPC, 8);
    }    
    
    else
    {
        SendMessageToPC(oPC, "Chyba: neurèená animace.");
    }
}