void KupZviera(int iCena, string sTag, object oPC)
{
    object oItem = GetItemPossessedBy(oPC,"sy_itm_otrok");
    if (oItem!=OBJECT_INVALID) {
        SpeakString("Bohuzel, vlastnit muzete jenom jednoho otroka.",TALKVOLUME_TALK);
        return;
    }

    if (GetGold(oPC)<iCena) {
        SpeakString("Bohuzel nemate dost penez na zaplaceni.",TALKVOLUME_TALK);
        return;
    }

    TakeGoldFromCreature(iCena,oPC,TRUE);
    string sNewTag = sTag + GetPCPlayerName(oPC);
    object oItmPet = CreateItemOnObject("sy_itm_otrok",oPC,1,"");
    SetLocalString(oItmPet,"sy_zviera",sTag);
    SetLocalString(oItmPet,"sy_pettag",sNewTag);
    SpeakString("Tady je vas vlastnicky list.",TALKVOLUME_TALK);
}
/*
void main()
{

}
*/
