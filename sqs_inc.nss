const string SQS_PRISONER_DISMISS_XP_VALUE = "SQS_PRISONER_DISMISS_XP_VALUE";   //INT Hodnota - XP odmena
const string SQS_PRISONER_DISMISS_ANSWER = "SQS_PRISONER_DISMISS_ANSWER";       //Text - Odpoved NPC na zachranu
const string SQS_PRISONER_DISMISSANDROB_XP_VALUE = "SQS_PRISONER_DISMISSANDROB_XP_VALUE";   //INT Hodnota - XP odmena
const string SQS_PRISONER_DISMISSANDROB_GP_VALUE = "SQS_PRISONER_DISMISSANDROB_GP_VALUE";   //INT Hodnota - XP odmena
const string SQS_PRISONER_DISMISSANDROB_ANSWER = "SQS_PRISONER_DISMISSANDROB_ANSWER";       //Text - Odpoved NPC na zachranu
const string SQS_PRISONER_KILL_ANSWER = "SQS_PRISONER_KILL_ANSWER";       //Text - Odpoved NPC na zachranu

int GetIsRewardValid(object oPrisoner, object oPC);
int GetIsRewardValid(object oPrisoner, object oPC)
{
    int iMaxLevel = GetLocalInt(oPrisoner,"SQS_PRISONER_MAX_LEVEL");
    int iLevel =  GetHitDice(oPC);
    if (iLevel <= iMaxLevel)
    {
        return TRUE;
    }
    return FALSE;
}




