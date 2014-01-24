//zviera nacuva co povie majitel (nove meno)

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalObject(OBJECT_SELF,"sy_listener",oPC);
    SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, "**", 1001);
}
