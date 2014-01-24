// is there no master for this mula?

int StartingConditional()
{
    string sMenoMajitela = GetLocalString(OBJECT_SELF,"sy_majitel");

    return (sMenoMajitela=="nikto");
}
