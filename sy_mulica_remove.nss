/*
  vypusti mulicu tak aby hocikto kto sa k nej ozve ju mohol pribrat
  k sebe a manipulovat nou
  -uzitocne ak jeden tazi(hornik) a druhy kovac si pride po
  nu a odvezie ju do dielne
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

    //SetName(OBJECT_SELF);
    //test
    SetName(OBJECT_SELF,GetName(OBJECT_SELF,TRUE));

    SetLocalString(OBJECT_SELF,"sy_majitel","nikto");
    DeleteLocalObject(oPC, "ja_mula");
    RemoveHenchman(oPC,OBJECT_SELF);
}
