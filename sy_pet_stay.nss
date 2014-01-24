void main()
{
    object oPC   = GetPCSpeaker();
    string sMeno = GetName(oPC,TRUE);
    string sMenoMajitela = GetLocalString(OBJECT_SELF,"sy_majitel");

    //ak hrac neni majitelom zvierata nema pravo manipulacie
    if (sMeno!=sMenoMajitela) {
        SendMessageToPC(oPC,"Nejsi majitel!");
        return;
    }

    RemoveHenchman(oPC,OBJECT_SELF);
}
