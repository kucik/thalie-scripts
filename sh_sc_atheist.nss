#include "sh_classes_const"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iLvl = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION)+GetLevelByClass(CLASS_TYPE_EXORCISTA)+GetLevelByClass(CLASS_TYPE_PALADIN)+GetLevelByClass(CLASS_TYPE_BLACKGUARD);
    if (iLvl) return FALSE;
    //int iResult;

    //iResult = <<PLACE THE CONDITIONAL HERE>>;
    return TRUE;;
}
