#include "ku_libbase"
void main()
{
    object oPC = GetPCSpeaker();
    SetPersistentInt(oPC, "PLAYED", 1,0,"pwchars");
    object oWP = GetObjectByTag("CHRAM_JUANA_KARATHA");
    SetLocalString(oPC,"CHRAM","CHRAM_JUANA_KARATHA");
    SetXP(oPC,GetXP(oPC)+5000);
    SetPersistentString(oPC,"CHRAM","CHRAM_JUANA_KARATHA");
    object oSoul = GetSoulStone(oPC);
    SetLocalInt(oSoul,"PLAYED",1);
    AssignCommand(GetPCSpeaker(),ActionJumpToObject(oWP));
}
