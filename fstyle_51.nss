/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(51,oPC);
    SendMessageToPC(oPC,"Aktivovan zakerny styl");
}
