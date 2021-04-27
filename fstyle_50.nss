/*
Skript pro prepnuti bojoveho stylu
*/
void main()
{
    object oPC = GetPCSpeaker();
    SetPhenoType(50,oPC);
    SendMessageToPC(oPC,"Aktivovan styl kensaie");
}
