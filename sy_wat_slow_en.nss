//script sa aktivuje na OnEnter evente trigeru vody

void main()
{
    object oPC   = GetEnteringObject();
    if (GetLocalInt(oPC,"sy_swimer")==1) return;   //tato premenna na prisere znaci, ze nebude spomalena vodou
    if (GetLocalInt(oPC,"sy_plava")==1) return;     //ak by sa stalo ze hrac uz je vo vode a zas sa vola tento script

    SetLocalInt(oPC,"sy_plava",1);
    effect eSlow = EffectMovementSpeedDecrease(GetLocalInt(OBJECT_SELF,"sy_slow_const"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPC);
    if (GetIsPC(oPC)) SendMessageToPC(oPC,"Brodis vodou");
}
