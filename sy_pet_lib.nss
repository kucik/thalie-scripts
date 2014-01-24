void KupZviera(int iCena, string sTag, object oPC)
{
    object oItem = GetItemPossessedBy(oPC,"sy_itm_pet");
    if (oItem!=OBJECT_INVALID) {
        SpeakString("Bohuzel, vlastnit muzete jenom jedno zvire.",TALKVOLUME_TALK);
        return;
    }

    if (GetGold(oPC)<iCena) {
        SpeakString("Bohuzel nemate dost penez na zaplaceni.",TALKVOLUME_TALK);
        return;
    }

    TakeGoldFromCreature(iCena,oPC,TRUE);
    string sNewTag = sTag + GetPCPlayerName(oPC);
    object oItmPet = CreateItemOnObject("sy_itm_pet",oPC,1,"");
    SetLocalString(oItmPet,"sy_zviera",sTag);
    SetLocalString(oItmPet,"sy_pettag",sNewTag);
    SpeakString("Tady je vase licence. Prosim starejte se o nej.",TALKVOLUME_TALK);
}
/*
void main()
{

}
*/
