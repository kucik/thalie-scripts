/*
  otvori batohy na mulici, hrac tam moze ukladat veci
*/

void main()
{
    object oPC   = GetPCSpeaker();
    string sMeno = GetName(oPC,TRUE);
    string sMenoMajitela = GetLocalString(OBJECT_SELF,"sy_majitel");

    //ak hrac neni majitelom mulice nema pravo manipulacie
    if (sMeno!=sMenoMajitela) {
        SendMessageToPC(oPC,"Nejsi majitel!");
        return;
    }

    OpenInventory(OBJECT_SELF,oPC);
}
