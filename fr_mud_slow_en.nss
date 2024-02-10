//script sa aktivuje na OnEnter evente trigeru
//varianta pro brozeni bahnem (zobrazi se jine info "Brodis se bahnem")
//puvodni verze z sy_wat_slow_en skriptu
//upraveno Frynem 10.2. 2024

void main()
{
    object oPC   = GetEnteringObject();
    if (GetLocalInt(oPC,"sy_swimer")==1) return;   //tato premenna na prisere znaci, ze nebude spomalena bahnem
    if (GetLocalInt(oPC,"sy_plava")==1) return;     //pokud by byl hrac uz je v bahne a zase se volal tento script

    SetLocalInt(oPC,"sy_plava",1);
    effect eSlow = EffectMovementSpeedDecrease(GetLocalInt(OBJECT_SELF,"sy_slow_const"));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oPC);
    if (GetIsPC(oPC)) SendMessageToPC(oPC,"Brodis se bahnem");
}
