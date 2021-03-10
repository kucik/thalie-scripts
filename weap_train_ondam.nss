/*
  OnDamage skript pro figurinu pro boj na blizko
  Uklada hodnoty na postavu, tedy pres restart
*/

const int WEAPON_TRAINING_MAX_HIT_COUNT = 100;


#include "me_soul_inc"
void main()
{
    object oDummy = OBJECT_SELF;
    object oPC = GetLastDamager();
    int iXP = GetXP(oPC);
    int iLevel = GetHitDice(oPC);
    int iFighterLevel = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
    int iFighterTraining = iFighterLevel > (iLevel/2);
    if ((iXP <= 765000) || (iFighterTraining==TRUE))//18 Level
    {
        int iHitCount = GetLocalInt(oPC,"WEAPON_TRAINING_HITCOUNT");
        if ((iHitCount <  WEAPON_TRAINING_MAX_HIT_COUNT) || (iXP<=15000))
        {
            iHitCount= iHitCount +1;
            SetLocalInt(oPC,"WEAPON_TRAINING_HITCOUNT",iHitCount);
            SendMessageToPC(oPC,"Zasah:("+IntToString(iHitCount)+"/"+IntToString(WEAPON_TRAINING_MAX_HIT_COUNT)+")");
            int iReward = 6;
            object oPC1 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oPC,1);
            if ((GetIsObjectValid(oPC1)) && (GetDistanceBetween(oPC,oPC1)<= 5.5))
            {
                iReward += 2;
                object oPC2 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oPC,2);
                if ((GetIsObjectValid(oPC2)) && (GetDistanceBetween(oPC,oPC2)<= 5.5))
                {
                    iReward += 2;
                }
            }
            if (iFighterTraining==TRUE)
            {
                iReward += 2;
            }
            iXP = iXP + iReward;
            SetXP(oPC,iXP);
        }
        else
        {
            SendMessageToPC(oPC,"Tento den se jiz nic dalsiho nenaucis.");
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oPC,12.0);
    }
    else
    {
        SendMessageToPC(oPC,"Na teto urovni se jiz nic dalsiho nenaucis.");
    }
}
