/*
  mulica sa odpoji z party a ostane stat na mieste, flag o
  zmene majitela sa nezmeni, cize nikto iny okrem povodneho
  majitela nemoze mulicou manipulovat
  -tuto moznost som dal preto aby mulica nechodila za hracom
  kam nema, napr do domu ak si to hrac nepraje
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

    RemoveHenchman(oPC,OBJECT_SELF);
}
