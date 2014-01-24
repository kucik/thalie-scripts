
int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    int iTypVody = GetLocalInt(oPC, "TypVody");

    //pitna voda
    if (iTypVody==1)
    {
        return TRUE;
    }

    return FALSE;
}

