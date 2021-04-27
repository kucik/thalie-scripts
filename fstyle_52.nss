/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(52,oPC);
    SendMessageToPC(oPC,"Aktivovan barbasky styk.");
}
