/*
  priberie mulicu k sebe do party ale funguje len vtedy ak:
  a) hrac ktory ju vlastnil ju vypustil natrvalo
  b) hrac ktory ju vypustil docasne ju berie spet

  -podmienkou je ze hrac nesmie mat uz u seba jednu mulicu
  a brat si dalsiu
*/

void main()
{
    object oPC   = GetPCSpeaker();
    string sMeno = GetName(oPC,TRUE);
    string sMenoMajitela = GetLocalString(OBJECT_SELF,"sy_majitel");

    //ak sa majitel vzdal mulice moze ju hocikto zobrat
    if (sMenoMajitela=="nikto") {
        object oMula = GetLocalObject(oPC, "ja_mula");

        if (GetIsObjectValid(oMula)) {
            SendMessageToPC(oPC,"Muzes mit jenom jedno zvire!");
            return;
        }

        SetLocalObject(oPC, "ja_mula", OBJECT_SELF);
        SetName(OBJECT_SELF,GetName(OBJECT_SELF,TRUE) + " ("+sMeno+")");
        SetLocalString(OBJECT_SELF,"sy_majitel",sMeno);
        AddHenchman(oPC,OBJECT_SELF);
        return;
    }

    //ak hrac neni majitelom mulice nema pravo manipulacie
    if (sMeno!=sMenoMajitela) {
        SendMessageToPC(oPC,"Nejsi majitel!");
        return;
    }

    AddHenchman(oPC,OBJECT_SELF);
}
