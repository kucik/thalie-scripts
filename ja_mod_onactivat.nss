#include "x2_inc_switches"
#include "ja_inc_stamina"

void main()
{
    object oItem = GetItemActivated();

    object oPC = GetItemActivator();

    if( GetResRef(oItem) == "mrtvola" ){
        object oCorpse = oItem;

        string sPlayerName = GetLocalString(oCorpse, "PLAYER");
        string sPCName = GetLocalString(oCorpse, "PC");
        string sCorpseTag = GetTag(oCorpse);
        int iSubdual = GetLocalInt(oCorpse,"SUBDUAL");

        DestroyObject(oCorpse, 0.0f);

        location lCorpse = GetLocation(oPC);

        oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, "player_corpse", lCorpse, FALSE, sCorpseTag);
        SetName(oCorpse, sPCName);
        SetLocalString(oCorpse, "PLAYER", sPlayerName);
        SetLocalString(oCorpse, "PC", sPCName);
        SetLocalInt(oCorpse,"SUBDUAL",iSubdual);


        SetExecutedScriptReturnValue(1);
        return;
    }
    else if( GetTag(oItem) == "Hulkanabozenstvi" ){
        if(GetIsDM(oPC)){
            SetLocalObject(oPC, "JA_WAND_DEITY", GetItemActivatedTarget());
            AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "ja_wand_deity", TRUE));
        }
        else{
            DestroyObject(oItem);
            SendMessageToPC(oPC, "Tento predmet je jen pro DM!");
            SendMessageToAllDMs("Hrac +"+GetName(oPC)+" se snazil pouzit DM hulku nabozenstvi!");
        }
    }
    else if( GetStringLeft(GetTag(oItem),5) == "food" ){
        restoreStamina(oPC, 100.0);
    }
    else{
        ExecuteScript("ja_horse_onactiv", OBJECT_SELF);
    }
}
