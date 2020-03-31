/*
  OnDamage skript pro figurinu pro boj na blizko
  Zakladni a pokrocily trenink ukladam na postavu, epicky na dusi (musi byt pres restarty)
*/

#include "weap_train_inc"
#include "me_soul_inc"
void main()
{
    object oDummy = OBJECT_SELF;
    object oPC = GetLastDamager();
    int iLevel = GetHitDice(oPC);
    int iMaxHitCount,iReward;
    if (d20()==5)
    {
        AssignCommand(oPC, ClearAllActions());
    }
    if (iLevel <= 15)
    {
        //zakladni a pokrocily trenink
        iMaxHitCount = GetLocalInt(oPC,"WEAPON_TRAINING_MAXHITCOUNT");
        int iTrainingType = GetLocalInt(oPC,"WEAPON_TRAINING_BASETYPE");
        if (iTrainingType==0)
        {
            iTrainingType = GetWeaponFocusOrSpecializationMelee(oPC);
            if (iTrainingType==0)
            {
                return; //Neplatny stav
            }
            SetLocalInt(oPC,"WEAPON_TRAINING_BASETYPE",iTrainingType);
            if (iTrainingType == -1)
            {
                iMaxHitCount =150;
            }
            if (iTrainingType >= 1)
            {
                int iBAB = GetBaseAttackBonus(oPC);
                if (iBAB < 6)
                {
                    iMaxHitCount =200;
                }
                else if (iBAB < 11)
                {
                    iMaxHitCount =400;
                }
                else
                {
                    iMaxHitCount =600;
                }
            }
            SetLocalInt(oPC,"WEAPON_TRAINING_MAXHITCOUNT",iMaxHitCount);
        }
        int iHitCount = GetLocalInt(oPC,"WEAPON_TRAINING_HITCOUNT");
        iHitCount= iHitCount +1;
        SetLocalInt(oPC,"WEAPON_TRAINING_HITCOUNT",iHitCount);
        SendMessageToPC(oPC,"Zasah:("+IntToString(iHitCount)+"/"+IntToString(iMaxHitCount)+")");
        if (iHitCount==iMaxHitCount)
        {
            iReward = 0;
            if (iTrainingType == -1)
            {
                iReward =1000;
            }
            else if (iTrainingType == 1)
            {
                iReward =2000;
            }
            else if (iTrainingType == 2)
            {
                iReward =2500;
            }
            int iXP = GetXP(oPC);
            iXP = iXP + iReward;
            SetXP(oPC,iXP);
        }
    }
    else
    {

        //epicke treninky
        object oSoulStone = GetSoulStone(oPC);
        int iEpicTrainingLevel = GetLocalInt(oSoulStone,"WEAPON_TRAINING_EPIC_LEVEL");
        int iTrainingType = GetEpicWeaponFocusOrSpecializationMelee(oPC);
        if ((iEpicTrainingLevel==1) && (iTrainingType>=1))
        {
            iMaxHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_MAXHITCOUNT_EPIC1");
            if (iMaxHitCount==0)
            {
                iMaxHitCount = 30000;
                SetLocalInt(oSoulStone,"WEAPON_TRAINING_MAXHITCOUNT_EPIC1",iMaxHitCount);
                SetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT",0);
            }
            int iHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT");
            iHitCount= iHitCount +1;
            SetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT",iHitCount);
            SendMessageToPC(oPC,"Zasah:("+IntToString(iHitCount)+"/"+IntToString(iMaxHitCount)+")");
            if (iHitCount==iMaxHitCount)
            {
                iReward = 20000;
                int iXP = GetXP(oPC);
                iXP = iXP + iReward;
                SetXP(oPC,iXP);
            }
        }
        if ((iEpicTrainingLevel==2) && (iTrainingType==2))
        {
            iMaxHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_MAXHITCOUNT_EPIC2");
            if (iMaxHitCount==0)
            {
                iMaxHitCount = 30000;
                SetLocalInt(oSoulStone,"WEAPON_TRAINING_MAXHITCOUNT_EPIC2",iMaxHitCount);
                SetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT",0);
            }
            int iHitCount = GetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT");
            iHitCount= iHitCount +1;
            SetLocalInt(oSoulStone,"WEAPON_TRAINING_HITCOUNT",iHitCount);
            SendMessageToPC(oPC,"Zasah:("+IntToString(iHitCount)+"/"+IntToString(iMaxHitCount)+")");
            if (iHitCount==iMaxHitCount)
            {
                iReward = 25000;
                int iXP = GetXP(oPC);
                iXP = iXP + iReward;
                SetXP(oPC,iXP);
            }
        }



    }

}
