void main()
{
    string sMajitel = GetLocalString(OBJECT_SELF,"sy_majitel");

    //najdem v zozname hracov toho komu patri toto zviera
    object oPC = GetFirstPC();
    while (oPC!=OBJECT_INVALID) {
        if (GetName(oPC)==sMajitel) {
            object oItem = GetItemPossessedBy(oPC,"sy_itm_pet");
            if (GetIsObjectValid(oItem)) {
                DestroyObject(oItem);
                SendMessageToPC(oPC,"zomrelo ti zviera");
            }
            return;
        }
        oPC = GetNextPC();
    }
    //nuz ale ked nenajdem nikoho = hrac je odlognuty a zviera
    //mu zomrie, tak potom aj tak bude mat svoje zviera spet grr
}
