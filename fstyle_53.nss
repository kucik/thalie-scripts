/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(53,oPC);
    SendMessageToPC(oPC,"Aktivovan sermirsky styl");
}
