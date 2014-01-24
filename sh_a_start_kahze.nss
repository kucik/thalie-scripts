#include "ku_libbase"
void main()
{
    object oPC = GetPCSpeaker();
    SetPersistentInt(GetPCSpeaker(), "PLAYED", 1,0,"pwchars");
    object oWP = GetObjectByTag("CHRAM_XIAN_CHARAS");
    SetLocalString(oPC,"CHRAM","CHRAM_XIAN_CHARAS");
    SetXP(oPC,GetXP(oPC)+5000);
    SetPersistentString(oPC,"CHRAM","CHRAM_XIAN_CHARAS");
    object oSoul = GetSoulStone(oPC);
    SetLocalInt(oSoul, "PLAYED",1);
    AssignCommand(GetPCSpeaker(),ActionJumpToObject(oWP));
}
