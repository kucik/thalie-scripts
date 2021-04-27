/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(56,oPC);
    SendMessageToPC(oPC,"Aktivovan styl stitonose");
}
