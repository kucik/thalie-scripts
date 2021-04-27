#include "ku_libbase"
#include "quest_inc"
void main()
{
    object oPC = GetPCSpeaker();
    SetPersistentInt(oPC, "PLAYED", 1,0,"pwchars");
    object oWP = GetObjectByTag("sys_main_enter");
    SetLocalString(oPC,"CHRAM","CHRAM_BOD_IV");
    SetXP(oPC,GetXP(oPC)+5000);
    SetPersistentString(oPC,"CHRAM","CHRAM_BOD_IV");
    object oSoul = GetSoulStone(oPC);
    SetLocalInt(oSoul,"PLAYED",1);
    AssignCommand(GetPCSpeaker(),ActionJumpToObject(oWP));
    SetLocalInt(oPC,"QUEST_ORDER_1",1);
    QUEST_CreateTaskList(oPC,1,1);
}
