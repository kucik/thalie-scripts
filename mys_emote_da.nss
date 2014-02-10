#include "nwnx_events"
#include "mys_emote_lib"

void main()
{
    string sText = GetSelectedNodeText();
    object oPC = GetPCSpeaker();
    
    // *************************************************************************
    // Pokøiky
    // *************************************************************************
    
    if (sText == "bojový 1")
    {
        ActionPlayEmote(oPC, 14);
    }
    else if (sText == "bojový 2")
    {
        ActionPlayEmote(oPC, 15);
    }
    else if (sText == "bojový 3")
    {
        ActionPlayEmote(oPC, 16);
    }
    else if (sText == "vítìzný 1")
    {
        ActionPlayEmote(oPC, 11);
    }
    else if (sText == "vítìzný 2")
    {
        ActionPlayEmote(oPC, 12);
    }
    else if (sText == "vítìzný 3")
    {
        ActionPlayEmote(oPC, 13);
    }
    
    // *************************************************************************
    // Jednorázové animace
    // *************************************************************************
    
    else if (sText == "souhlas")
    {
        ActionPlayEmote(oPC, 37);
    }
    else if (sText == "rozpaky")
    {
        ActionPlayEmote(oPC, 8);
    }
    else if (sText == "zamávat")
    {
        ActionPlayEmote(oPC, 5);
    }
    else if (sText == "salutovat")
    {
        ActionPlayEmote(oPC, 7);
    }
    else if (sText == "úklona")
    {
        ActionPlayEmote(oPC, 1);
    }
    else if (sText == "výzva")
    {
        ActionPlayEmote(oPC, 10);
    }
    else if (sText == "úhyb")
    {
        ActionPlayEmote(oPC, 2);
    }
    else if (sText == "døep")
    {
        ActionPlayEmote(oPC, 4);
    }
    else if (sText == "prùtah")
    {
        ActionPlayEmote(oPC, 0);
    }
    else if (sText == "okrást")
    {
        ActionPlayEmote(oPC, 9);
    }
    else if (sText == "èetba")
    {
        ActionPlayEmote(oPC, 6);
    }
    else if (sText == "napít se")
    {
        ActionPlayEmote(oPC, 3);
    }
    
    // *************************************************************************
    // Trvalé animace
    // *************************************************************************
    
    else if (sText == "ležet na bøiše")
    {
        ActionPlayEmote(oPC, 22);
    }
    else if (sText == "ležet na zádech")
    {
        ActionPlayEmote(oPC, 21);
    }
    else if (sText == "dívat do dáli")
    {
        ActionPlayEmote(oPC, 26);
    }
    else if (sText == "kleèet")
    {
        ActionPlayEmote(oPC, 27);
    }
    else if (sText == "prosit")
    {
        ActionPlayEmote(oPC, 17);
    }
    else if (sText == "únava")
    {
        ActionPlayEmote(oPC, 29);
    }
    else if (sText == "smích")
    {
        ActionPlayEmote(oPC, 25);
    }
    else if (sText == "opilost")
    {
        ActionPlayEmote(oPC, 20);
    }
    else if (sText == "záchvat")
    {
        ActionPlayEmote(oPC, 28);
    }
    else if (sText == "hrozit")
    {
        ActionPlayEmote(oPC, 30);
    }
    else if (sText == "uctívat")
    {
        ActionPlayEmote(oPC, 31);
    }
    else if (sText == "èáry")
    {
        ActionPlayEmote(oPC, 18);
    }
    else if (sText == "èáry nad hlavou")
    {
        ActionPlayEmote(oPC, 19);
    }
    else if (sText == "nìco na zemi")
    {
        ActionPlayEmote(oPC, 23);
    }
    else if (sText == "nìco v úrovni pasu")
    {
        ActionPlayEmote(oPC, 24);
    }
    
    // *************************************************************************
    // Animace sezení
    // *************************************************************************
    
    else if (sText == "sedìt na zemi")
    {
        ActionPlayEmote(oPC, 32);
    }
    else if (sText == "sedìt na nìèem")
    {
        ActionPlayEmote(oPC, 33);
    }
    else if (sText == "sedìt na nejbližší vìci")
    {
        ActionPlayEmote(oPC, 34);
    }
    else if (sText == "èíst v sedì")
    {
        ActionPlayEmote(oPC, 36);
    }
    else if (sText == "napít se v sedì")
    {
        ActionPlayEmote(oPC, 35);
    }
    
    // *************************************************************************
    // Ostatní animace
    // *************************************************************************
    
    else if (sText == "kouøit")
    {
        ActionPlayEmote(oPC, 39);
    }
    else if (sText == "tanec")
    {
        ActionPlayEmote(oPC, 38);
    }
    else
    {
        SendMessageToPC(oPC, "Chyba: neurèená animace.");
    }
}