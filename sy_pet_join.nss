void main()
{
    string sMeno = GetLocalString(OBJECT_SELF,"sy_majitel");
    object oPC   = GetPCSpeaker();
    if (sMeno!=GetName(oPC,TRUE)) {
        SendMessageToPC(oPC,"Nejsi majitelem.");
        return;
    }

    if (GetHenchman(oPC)!=OBJECT_INVALID) {
        SendMessageToPC(oPC,"Muzes mit jenom jedno zvire.");
        return;
    }

    AddHenchman(oPC,OBJECT_SELF);
}
