#include "me_soul_inc"
#include "ku_libtime"

void main()
{
    object oPC = OBJECT_SELF;
    object oSoul = GetSoulStone(oPC);
    location lTarget = GetSpellTargetLocation();
    int iTime = ku_GetTimeStamp();
    int iPrev = GetLocalInt(oPC,"SUBRACE_LET_TIME");
    effect eAp;
    
    if (GetLocalInt(oSoul, "MOUNTED"))
    {
        SendMessageToPC(oPC, "Nelze létat v sedle.");
        return;
    }
    
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
