void main()
{
    SetListenPattern(OBJECT_SELF, "*n", 0);
    SetListenPattern(OBJECT_SELF, "*n **", 1);
    SetListenPattern(OBJECT_SELF, "** *n", 2);
    SetListenPattern(OBJECT_SELF, "** *n **", 3);
    SetListening(OBJECT_SELF, TRUE);
}
