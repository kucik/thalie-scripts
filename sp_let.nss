#include "ku_libtime"

void main()
{
    object oPC = OBJECT_SELF;
    location lTarget = GetSpellTargetLocation();
    int iTime = ku_GetTimeStamp();
    int iPrev = GetLocalInt(oPC,"SUBRACE_LET_TIME");
    SendMessageToPC(oPC,"Cas je "+IntToString(iTime));
    effect eAp;
    if ((iTime-iPrev)>= 1800 || iPrev == 0) //delsi cas nez 30 minut
    {
        eAp = EffectDisappearAppear(lTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eAp,oPC,8.0);
        AssignCommand(oPC,DelayCommand(8.1,ActionJumpToLocation(lTarget)));
        SetLocalInt(oPC,"SUBRACE_LET_TIME",iTime);
    }
    else
    {
        SendMessageToPC(oPC,"Letet budete moci za " + IntToString((1800-iTime+iPrev)/60) + " minut a "+ IntToString((1800-iTime+iPrev)%60) + " sekund.");
    }
}
