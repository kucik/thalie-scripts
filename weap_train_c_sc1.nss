#include "weap_train_inc"
#include "me_soul_inc"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSoulStone = GetSoulStone(oPC);
    int iMelee = GetEpicWeaponFocusOrSpecializationMelee(oPC);
    int iRanged = GetEpicWeaponFocusOrSpecializationRanged(oPC);
    int iGold = GetGold(oPC);
    int iEpicTrainingLevel = GetLocalInt(oSoulStone,"WEAPON_TRAINING_EPIC_LEVEL");
    int iResult = ((iMelee>=1)||(iRanged>=1)) && (iGold>=100000) && (iEpicTrainingLevel==0);
    return iResult;
}
