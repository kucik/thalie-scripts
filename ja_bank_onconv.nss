#include "ja_bank_inc"

void SecondPhase(object oPC, int iComm, int iAmount){
    int iResult;
    if( iComm == bank_CommandGet)
        iResult = bank_GetFromAccount(oPC, iAmount);
    else if( iComm == bank_CommandPut)
        iResult = bank_PutInAccount(oPC, iAmount);


    string sResult;
    if( iResult == bank_Failture ){
        if( iComm == bank_CommandGet)
            sResult = "Bohuzel na vasem uctu neni tolik penez. Je mi lito, ale nemohu vas pozadavek provest.";
        else if( iComm == bank_CommandPut)
            sResult = "Bohuzel jste mi nedal dostatek penez, vracim vam je zpet. Je mi lito, ale nemohu vas pozadavek provest.";
    }
    else if( iResult == bank_Success ){
        if( iComm == bank_CommandGet)
            sResult = "Z vaseho uctu bylo vybrano "+IntToString(iAmount)+" zlatych. Prosim, zde je mate.";
        else if( iComm == bank_CommandPut)
            sResult = "Na vas ucet bylo ulozeno "+IntToString(iAmount)+" zlatych. Dekujeme za vasi duveru.";
    }

    ActionSpeakString(sResult);
}


void main()
{
    int iMatch = GetListenPatternNumber();

    if(iMatch == -1){
        BeginConversation();
        return;
    }

    object oPC = GetLocalObject(OBJECT_SELF, "CUSTOMER");
    int iComm  = GetLocalInt(OBJECT_SELF, "COMMAND");

    if( !GetIsObjectValid(oPC) || iComm == 0) return;

    object oSpeaker = GetLastSpeaker();

    if( oSpeaker != oPC ) return;

    DeleteLocalInt(OBJECT_SELF, "COMMAND");
    DeleteLocalObject(OBJECT_SELF, "CUSTOMER");

    string sAmount;

    if(iMatch == 0 || iMatch == 1){
        sAmount = GetMatchedSubstring(0);
    }
    else if(iMatch == 2 || iMatch == 3){
        sAmount = GetMatchedSubstring(2);
    }

    int iAmount = StringToInt(sAmount);

    if(iAmount <= 0) return;
    if(iAmount < 100 && iComm == bank_CommandPut){
        ActionSpeakString("Omlouvam se, ale nejmensi mozna castka, kterou muzete vlozit je 100 zlatych.");
        return;
    }

    location lSafe = GetLocation(GetNearestObjectByTag("WP_SAFE"));
    location lOrigin = GetLocation(OBJECT_SELF);

    ActionSpeakString("Dobre, pockejte chvili zde.");
    ActionMoveToLocation(lSafe);
    ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL);
    ActionMoveToLocation(lOrigin);
    ActionDoCommand(SecondPhase(oPC, iComm, iAmount));

}
