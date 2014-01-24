// is this my master?

int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    string sMeno = GetName(oPC,TRUE);
    string sMenoMajitela = GetLocalString(OBJECT_SELF,"sy_majitel");

    PlayVoiceChat(VOICE_CHAT_YES,OBJECT_SELF);
    //ak hrac neni majitelom mulice nema pravo manipulacie
    if (sMeno!=sMenoMajitela) {
        return 1;
    }

    return 0;
}
