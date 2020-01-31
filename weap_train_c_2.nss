#include "weap_train_inc"
#include "me_soul_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oSoulStone = GetSoulStone(oPC);
    int iMelee = GetEpicWeaponFocusOrSpecializationMelee(oPC);
    int iRanged = GetEpicWeaponFocusOrSpecializationRanged(oPC);
    int iGold = GetGold(oPC);
    int iEpicTrainingLevel = GetLocalInt(oSoulStone,"WEAPON_TRAINING_EPIC_LEVEL");
    int iMaxHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_MAXHITCOUNT_EPIC1");
    int iHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT");
    int iResult = ((iMelee==2)||(iRanged==2)) && (iGold>=150000) && (iEpicTrainingLevel==1) && (iHitCount>=iMaxHitCount);
    if (iResult)
    {
        TakeGoldFromCreature(150000,oPC,TRUE);
        SetLocalInt(oSoulStone,"WEAPON_TRAINING_EPIC_LEVEL",2);
    }
}

