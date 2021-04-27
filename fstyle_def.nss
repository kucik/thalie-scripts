/*
Skript pro prepnuti bojoveho stylu
*/
#include "me_soul_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oSoulStone = GetSoulStone(oPC);
    int iDefaultPheno = GetLocalInt(oSoulStone,"DEFAULT_PHENO");
    SetPhenoType(iDefaultPheno,oPC);
    SendMessageToPC(oPC,"Aktivovan standardni styl");
}
