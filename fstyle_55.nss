/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(55,oPC);
    SendMessageToPC(oPC,"Aktivovan styl demononickeho mece.");
}
